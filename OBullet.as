class OBullet
{
	public var pos:OVector;
	public var vel:OVector;
	public var mc:MovieClip;
	public var state:Number = 0;
	public var screenPos:OVector;

	public function OBullet(mc:MovieClip)
	{
		this.mc = mc;
		mc._visible = false;
		this.pos = new OVector(-10, -10);
		this.vel = new OVector(0, 0);
		this.screenPos = new OVector(0, 0);
		this.state = 0;
	}
	public function dispose():Void
	{
		this.mc._visible = false;
		this.pos.setTo( -10, -10);
		this.vel.setTo(0,0);
		this.state = 0;
	}

	public function update():Void
	{
		if (this.state == 1)
		{
			this.pos.add(this.vel);
			this.mc._x = this.pos.x;
			this.mc._y = -this.pos.y;
		}
	}
}