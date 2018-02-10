/**
 * ...
 * @author linye
 */
class OSavedRoom
{
	public var enemys = new Array();
	public var crates = new Array();
	public var triggers = new Array();

	public function OSavedRoom()
	{

	}

	public function save($enemys:Array)
	{
		var len:Number = $enemys.length;
		var enemy:OEnemy;
		for (var i:Number = 0; i < len; i++)
		{
			enemy = $enemys[i];
			this.enemys[i] = new OSavedEnemy().save(enemy);
		}
	}

	public function getSavedEnemy(i:Number):OSavedEnemy
	{
		return this.enemys[i];
	}

}