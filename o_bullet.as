class o_bullet
{
	public var pos:o_Vector;
	public var vel:o_Vector;
	public var mc:MovieClip;
	public var state:Number = 0;
	public var screenPos:o_Vector;


	public function o_bullet()
	{
		this.pos = new o_Vector(0, 0);
		this.vel = new o_Vector(0, 0);
		this.screenPos = new o_Vector(0, 0);
	}
}