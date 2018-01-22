class OBullet
{
	public var pos:Vector;
	public var vel:Vector;
	public var mc:MovieClip;
	public var state:Number = 0;
	public var screenPos:Vector;

	public function OBullet(mc:MovieClip)
	{
		this.mc = mc;
		mc._visible = false;
		this.pos = new Vector(-10, -10);
		this.vel = new Vector(0, 0);
		this.screenPos = new Vector(0, 0);
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