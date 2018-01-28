class OEnemy
{
	public var id:Number = 0;
	public var phys:OEnemyPhys;
	public var mc:MovieClip;
	public var hitpoints:Number;
	public var type:String = "";
	public var typeID:Number = 0;
	public var state:Number = 0;
	public var bullets:Array;
	public var bulletType:String = "";
	public var bulletVel:Number = 0;
	public var nbBullets:Number;
	public var bulletI:Number = 0;
	public var lastFireFrames:Number = 0;
	public var points:Array;
	public var propertie:OEnemyTypeProperties;

	public function OEnemy(mc:MovieClip)
	{
		this.mc = mc;
		mc.gotoAndPlay(1);
		mc.ship.gotoAndStop(1);
		mc._visible = true;
		this.phys = new OEnemyPhys();
		this.phys.rot = mc._rotation;
		this.bulletI = 0;
		this.lastFireFrames = 0;
		this.state = 1;
	}

	public function setProp(propertie:OEnemyTypeProperties):Void
	{
		trace("Enemy setProp" +propertie)
		this.propertie = propertie;
		this.hitpoints = propertie.hitpoints;
		this.nbBullets = propertie.nbBullets;
		this.bulletType = propertie.bulletType;
	}

	public function initBullets(arena:MovieClip):Void
	{
		this.bullets = new Array(this.nbBullets);
		var i:Number = 0;
		var bullet:OBullet;
		while (i < this.nbBullets)
		{
			var mc:MovieClip = arena.attachMovie(
				this.bulletType, ("enemy" + this.id + "bullet" + i),
				(this.id  + 2) * 100 + i
			);
			bullet = new OBullet(mc);
			this.bullets[i] = bullet;
			i++;
		}
	}

	public function checkFire():Boolean
	{
		var result:Boolean = false;
		if (this.state == 1)
		{
			this.lastFireFrames++;
			if (propertie.firerate == "ONSIGHT")
			{
				this.phys.rot = this.mc.ship._rotation;
			}
			else if (propertie.firerate > 1)
			{
				if (this.lastFireFrames >= propertie.firerate)
				{
					//fireEnemyBullets(this, 0);
					result = true;
					this.lastFireFrames = 0;
				}
			}
			else if (propertie.firerate < 1)
			{
				if (Math.random() <= propertie.firerate)
				{
					//fireEnemyBullets(this,0);
					result = true;
					this.lastFireFrames = 0;
				}
			}
			else
			{

				trace("---------------------------------------------")
				trace(propertie)

				trace("enemy firerate not identified!!!!!!!!!! Something is weird!!!!!!!!!!!  " +propertie.firerate);
			}
		}
		return result;
	}

	public function updateBullets():Void
	{
		var bullet:OBullet;
		var i:Number = 0;
		while (i < this.nbBullets)
		{
			bullet = this.bullets[i];
			bullet.update();
			i++;
		}
	}

	public function clearBullets():Void
	{
		var bullet:OBullet;
		trace("Removing bullets for enemy  " + this.id);
		var j:Number = 0;
		while (j < this.nbBullets)
		{
			bullet = this.bullets[j];
			bullet.dispose();
			j++;
		}
	}

	public function load(senemy:OSavedEnemy):Void
	{
		this.state = senemy.state;
		this.hitpoints = senemy.hitpoints;
		this.type = senemy.type;
		this.propertie = senemy.propertie;
		trace("Enemy id : " + id + "   State : " + senemy.state);
		if (this.state == 0)
		{
			this.mc.stop();
			this.mc.ship.gotoAndStop("dead");
		}
	}

	public function fireEnemyBullets(gunID:Number,hero:OShip):Void
	{
		if (this.bulletI >= (this.nbBullets - 1))
		{
			this.bulletI = 0;
		}
		else
		{
			this.bulletI++;
		}
		var _local3 = new Vector(0, 0);
		_local3.x = this.mc.ship.bulletpoint0._x;
		_local3.y = this.mc.ship.bulletpoint0._y;
		this.mc.ship.localToGlobal(_local3);
		_global.arena.globalToLocal(_local3);
		this.bullets[this.bulletI].pos.x = _local3.x;
		this.bullets[this.bulletI].pos.y = -_local3.y;

		if (this.type == "SEEDPOD")
		{
			var randDegree:Number = (Math.random() * 90) - 45;
			var aimCos:Number = Math.cos((this.phys.rot - 90 + randDegree) * Math.PI / 180);
			var aimSin:Number = -Math.sin((this.phys.rot - 90 + randDegree) * Math.PI / 180);
			this.bullets[this.bulletI].vel.x = aimCos * this.propertie.bulletVel;
			this.bullets[this.bulletI].vel.y = aimSin * this.propertie.bulletVel;
		}
		else if (this.propertie.accuracy < 0)
		{
			var vec:Vector = new Vector();
			vec.x = hero.phys.pos.x - this.bullets[this.bulletI].pos.x;
			vec.y = hero.phys.pos.y - this.bullets[this.bulletI].pos.y;
			vec.normalize();
			var adjustDegrees = 360 * (this.propertie.accuracy + 1);
			adjustDegrees = (Math.random() * adjustDegrees) - (adjustDegrees / 2);
			var aimCos = Math.cos((adjustDegrees * Math.PI) / 180);
			var aimSin = -Math.sin((adjustDegrees * Math.PI) / 180);
			var newX = (vec.x * aimCos) + (vec.y * (-aimSin));
			var newY = (vec.x * aimSin) + (vec.y * aimCos);
			this.bullets[this.bulletI].vel.x = newX * this.propertie.bulletVel;
			this.bullets[this.bulletI].vel.y = newY * this.propertie.bulletVel;
		}
		else if (this.propertie.accuracy >= 0)
		{
			var aimCos = Math.cos(((this.propertie.accuracy + this.phys.rot - 90) * Math.PI) / 180);
			var aimSin = -Math.sin(((this.propertie.accuracy + this.phys.rot - 90) * Math.PI) / 180);
			this.bullets[this.bulletI].vel.x = aimCos * this.propertie.bulletVel;
			this.bullets[this.bulletI].vel.y = aimSin * this.propertie.bulletVel;
		}
		this.bullets[this.bulletI].state = 1;
		this.bullets[this.bulletI].mc.gotoAndStop(1);
		this.bullets[this.bulletI].mc._visible = true;

		if (gunID < (this.propertie.nbGuns - 1))
		{
			this.fireEnemyBullets(gunID + 1,hero);
		}
		else
		{
			_global.theSounds.heroshoot.start();
		}
	}
}