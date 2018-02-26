class OVector
{
	public var x:Number = 0;
	public var y:Number = 0;

	function OVector(x:Number, y:Number)
	{
		this.x = x;
		this.y = y;
	}
	
	public function setTo(x:Number, y:Number):Void
	{
		this.x = x;
		this.y = y;
	}
	
	public function subtract(vec:OVector):Void
	{
		this.x -= vec.x;
		this.y -= vec.y;
	}

	public function add(vec:OVector):Void
	{
		this.x += vec.x;
		this.y += vec.y;
	}

	public function normalize():Void
	{
		var dis = Math.sqrt(x * x + y * y);
		this.x = x / dis;
		this.y = y / dis;
	}

	public function get length():Number
	{
		return Math.sqrt(this.x * this.x + this.y * this.y);
	}

	public function clone():OVector
	{
		return new OVector(this.x,this.y);
	}

	public function toString():String
	{
		return "[" + this.x + "," + this.y + "]";
	}

}