/**
 * ...
 * @author linye
 */
class EnemyTypeProperties
{
	public var counts:Number = 8;
	private var props:Array = [];
	public function EnemyTypeProperties()
	{
		var etp0:OEnemyTypeProperties = new OEnemyTypeProperties();
		var etp1:OEnemyTypeProperties = new OEnemyTypeProperties();
		var etp2:OEnemyTypeProperties = new OEnemyTypeProperties();
		var etp3:OEnemyTypeProperties = new OEnemyTypeProperties();
		var etp4:OEnemyTypeProperties = new OEnemyTypeProperties();
		var etp5:OEnemyTypeProperties = new OEnemyTypeProperties();
		var etp6:OEnemyTypeProperties = new OEnemyTypeProperties();
		var etp7:OEnemyTypeProperties = new OEnemyTypeProperties();
		this.props.push(etp0);
		this.props.push(etp1);
		this.props.push(etp2);
		this.props.push(etp3);
		this.props.push(etp4);
		this.props.push(etp5);
		this.props.push(etp6);
		this.props.push(etp7);
		etp0.id = 0;
		etp0.type = "BOA";
		etp0.hitpoints = 10;
		etp0.bulletType = "bulletred";
		etp0.bulletVel = 4;
		etp0.nbBullets = 5;
		etp0.nbGuns = 1;
		etp0.firerate = 50;
		etp0.accuracy = -0.0001;
		etp0.fireSound = "fireBOA";
		etp0.hitSound = "bullethitter";
		etp0.points = 50;

		etp1.id = 1;
		etp1.type = "WORMDOWN";
		etp1.hitpoints = 7;
		etp1.bulletType = "bulletgreen";
		etp1.bulletVel = 4;
		etp1.nbBullets = 4;
		etp1.nbGuns = 1;
		etp1.firerate = 50;
		etp1.accuracy = 180;
		etp1.fireSound = "fire1";
		etp1.hitSound = "hit1";
		etp1.points = 25;

		etp2.id = 2;
		etp2.type = "BOSS";
		etp2.hitpoints = 40;
		etp2.bulletType = "bulletred";
		etp2.bulletVel = 8;
		etp2.nbBullets = 25;
		etp2.nbGuns = 1;
		etp2.firerate = 50;
		etp2.accuracy = -1;
		etp2.fireSound = "fireBOA";
		etp2.hitSound = "bullethitter";
		etp2.points = 500;

		etp3.id = 3;
		etp3.type = "BOSSARM";
		etp3.hitpoints = 5;
		etp3.bulletType = "bulletgreen";
		etp3.bulletVel = 6;
		etp3.nbBullets = 12;
		etp3.nbGuns = 1;
		etp3.firerate = 0.04;
		etp3.accuracy = -0.05;
		etp3.fireSound = "fireBOA";
		etp3.hitSound = "bullethitter";
		etp3.points = 50;

		etp4.id = 4;
		etp4.type = "SEEDPOD";
		etp4.hitpoints = 7;
		etp4.bulletType = "bulletgreen";
		etp4.bulletVel = 4;
		etp4.nbBullets = 10;
		etp4.nbGuns = 4;
		etp4.firerate = 50;
		etp4.accuracy = 0;
		etp4.fireSound = "fire1";
		etp4.hitSound = "hit1";
		etp4.points = 70;

		etp5.id = 5;
		etp5.type = "FLY";
		etp5.hitpoints = 3;
		etp5.bulletType = "bulletgreen";
		etp5.bulletVel = 4;
		etp5.nbBullets = 10;
		etp5.nbGuns = 1;
		etp5.firerate = 50;
		etp5.accuracy = -1;
		etp5.fireSound = "fire1";
		etp5.hitSound = "hit1";
		etp5.points = 100;

		etp6.id = 6;
		etp6.type = "WORMRIGHT";
		etp6.hitpoints = 10;
		etp6.bulletType = "bulletgreen";
		etp6.bulletVel = 4;
		etp6.nbBullets = 4;
		etp6.nbGuns = 1;
		etp6.firerate = 30;
		etp6.accuracy = 90;
		etp6.fireSound = "fire1";
		etp6.hitSound = "hit1";
		etp6.points = 30;

		etp7.id = 7;
		etp7.type = "WORMLEFT";
		etp7.hitpoints = 10;
		etp7.bulletType = "bulletgreen";
		etp7.bulletVel = 4;
		etp7.nbBullets = 4;
		etp7.nbGuns = 1;
		etp7.firerate = 30;
		etp7.accuracy = 270;
		etp7.fireSound = "fire1";
		etp7.hitSound = "hit1";
		etp7.points = 30;
	}
	

	public function getPropertie(typeID:Number):OEnemyTypeProperties
	{
		return props[typeID];
	}
}