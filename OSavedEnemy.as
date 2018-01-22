class OSavedEnemy
{
	public var state:Number;
	public var hitpoints:Number;
	public var type:String;
	public var propertie:OEnemyTypeProperties;

	public function OSavedEnemy()
	{

	}

	public function save(enemy:OEnemy):Void
	{
		this.state = enemy.state;
		this.hitpoints = enemy.hitpoints;
		this.type = enemy.type;
		this.propertie = enemy.propertie;
	}

}

