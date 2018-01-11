class o_bullet
{
	public var pos:Vector;
	public var vel:Vector;
	public var mc:MovieClip;
	public var state:Number = 0;
	public var screenPos:Vector;


	public function o_bullet()
	{
		this.pos = new Vector(0, 0);
		this.vel = new Vector(0, 0);
		this.screenPos = new Vector(0, 0);
	}
}