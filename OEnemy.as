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
}