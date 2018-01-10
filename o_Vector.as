class o_Vector
{
	public var x:Number = 0;
	public var y:Number = 0;

	function o_Vector(x, y)
	{
		this.x = x;
		this.y = y;

	}
	function toString():String
	{
		return "[" + this.x + "," + this.y + "]";
	}
}