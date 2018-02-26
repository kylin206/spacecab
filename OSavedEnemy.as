class OSavedEnemy
{
	private var _state:Number;
	private var _propertie:OEnemyTypeProperties;
	public var hitpoints:Number;
	public var type:String;

	public function OSavedEnemy()
	{

	}

	public function get state():Number
	{
		return this._state;
	}
	
	public function get propertie():OEnemyTypeProperties
	{
		return this._propertie;
	}
	
	public function save(enemy:OEnemy):OSavedEnemy
	{
		this._state = enemy.state;
		this.hitpoints = enemy.hitpoints;
		this.type = enemy.type;
		this._propertie = enemy.propertie;
		return this;
	}

}

