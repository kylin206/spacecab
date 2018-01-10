class o_enemy
{
	public var id:Number = 0;
	public var phys = {};
	public var mc:MovieClip;
	public var hitpoints:Array;
	public var type:String = "";
	public var typeID:Number = 0;
	public var state:Number = 0;
	public var bullets:Array;
	public var bulletType:Number = 0;
	public var bulletVel:Number = 0;
	public var nbBullets:Array;
	public var bulletNB:Number = 0;
	public var lastFireFrames:Number = 0;
	public var points:Array;


	public function o_enemy()
	{
	}

}