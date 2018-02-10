class OSavedEnemy
{
	public var state:Number;
	public var hitpoints:Number;
	public var type:String;
	public var propertie:OEnemyTypeProperties;

	public function OSavedEnemy()
	{

	}

	public function save(enemy:OEnemy):OSavedEnemy
	{
		this.state = enemy.state;
		this.hitpoints = enemy.hitpoints;
		this.type = enemy.type;
		this.propertie = enemy.propertie;
		return this;
	}

}

