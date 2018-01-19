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
	public var bulletNB:Number = 0;
	public var lastFireFrames:Number = 0;
	public var points:Array;

	public function OEnemy(mc:MovieClip)
	{
		this.mc = mc;
		mc.gotoAndPlay(1);
		mc.ship.gotoAndStop(1);
		mc._visible = true;
		this.phys = new OEnemyPhys();
		this.phys.rot = mc._rotation;
		this.bulletNB = 0;
		this.lastFireFrames = 0;
		this.state = 1;
	}

	public function setProp(propertie:OEnemyTypeProperties):Void
	{
		this.hitpoints = propertie.hitpoints;
		this.nbBullets = propertie.nbBullets;
		this.bulletType = propertie.bulletType;
	}

	public function initBullets(arena:MovieClip):Void
	{
		this.bullets = new Array(this.nbBullets);
		var i = 0;
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
}