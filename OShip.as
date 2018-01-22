class OShip
{
	public var nbBullets:Number = 50;
	var phys:OPhys;
	var mc;
	var hitpoints;
	public var state:String;
	var color;
	var weight;
	var maxWeight;
	var cargo;//货物
	var lives;
	var score;
	var fuel;
	var powerup;//升级
	var killAll;
	var heroCos:Number;
	var heroSin:Number;
	var bullets:Array;

	public function OShip()
	{
		this.phys = this.createPhys();
		this.mc = mc;
		this.hitpoints = [];
		
		var t:Number = 0;
		while (t < 4)
		{
			this.hitpoints[t] = new Vector(0, 0);
			t++;
		}
		
		this.state = state;
		this.color = color;
		this.weight = weight;
		this.maxWeight = maxWeight;
		this.cargo = [];
		this.bullets = new Array(nbBullets);
		this.lives = lives;
		this.score = score;
		this.fuel = fuel;
		this.powerup = powerup;
	}
	
	public function initBullets(arena:MovieClip):Void
	{
		this.bullets = new Array(this.nbBullets);
		var i:Number = 0;
		var bullet:OBullet;
		while (i < this.nbBullets)
		{
			var mc:MovieClip = arena.attachMovie("bullethero","herobullet" + i,100 + i);
			bullet = new OBullet(mc);
			this.bullets[i] = bullet;
			i++;
		}
	}

	
	
	
	public function update(arena:MovieClip,level:Number,triggers:Array,GRAVITY:Number):Void{
		var phys:OPhys = this.phys;
		if (this.state == "FLYING")
		{
			heroCos = Math.cos((phys.rot - 90) * Math.PI / 180);
			heroSin = -Math.sin((phys.rot - 90) * Math.PI / 180);

			var vel:Vector = phys.vel;
			phys.rot += phys.rotVel;
			vel.x *= 0.98;
			vel.y *= 0.98;
			vel.x += phys.acc * heroCos;
			vel.y += phys.acc * heroSin + (GRAVITY * ((this.weight / 2) + 1));
			
			if (level == 4 && (phys.pos.x < arena.blackhole0._x))
			{
				var t = 0;
				while (t < 6)
				{
					var tmpBlackholeMC:MovieClip = arena["blackhole" + t];
					var tmpBlackvector:Vector = new Vector(0, 0);
					tmpBlackvector.x = phys.pos.x - tmpBlackholeMC._x;
					tmpBlackvector.y = phys.pos.y + tmpBlackholeMC._y;
					var dist:Number = (tmpBlackvector.x * tmpBlackvector.x) + (tmpBlackvector.y * tmpBlackvector.y);
					
					if (dist < 22500)
					{
						var holepower:Number = (dist / 22500) - 1;
						tmpBlackvector.normalize();
						if (triggers[2] != 1)
						{
							vel.x -= (tmpBlackvector.x * holepower) * 0.3;
							vel.y -= (tmpBlackvector.y * holepower) * 0.3;
						}
						else
						{
							vel.x += (tmpBlackvector.x * holepower) * 0.25;
							vel.y += (tmpBlackvector.y * holepower) * 0.25;
						}
					}
					t++;
				}
			}
			phys.pos.x += vel.x;
			phys.pos.y += vel.y;
			arena.heroholder._x = phys.pos.x;
			arena.heroholder._y = -phys.pos.y;
			arena.heroholder._rotation = phys.rot;
			phys.acc *= 0.9;
		}
	}
	private function createPhys():OPhys
	{
		var phys:OPhys = new OPhys();
		phys.pos = new Vector(100, 100);
		phys.vel = new Vector(0, 0);
		phys.acc = 0;
		phys.rot = 0;
		phys.rotVel = 0;
		phys.maxAcc = 1;
		phys.minAcc = -1;
		phys.maxVel = 1;
		return phys;
	}
	
	public function clearBullets():Void
	{
		var bullet:OBullet;
		var i:Number = 0;
		while (i < this.nbBullets)
		{
			bullet = this.bullets[i];
			bullet.dispose();
			i++;
		}
	}

}