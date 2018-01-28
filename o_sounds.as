/**
 * ...
 * @author linye
 */
class o_sounds
{
	var heroshoot:Sound;
	var bullethitter:Sound;
	var explode :Sound;
	var gameover :Sound;
	var levelcompleted :Sound;
	var pickup :Sound;
	var deliver :Sound;
	var thrust :Sound;
	var door :Sound;
	var explodeshort:Sound;
	
	public function o_sounds(_local1)
	{
		this.heroshoot = new Sound(_local1);
		this.heroshoot.attachSound("heroshoot");
		this.bullethitter = new Sound(_local1);
		this.bullethitter.attachSound("bullethitter");
		this.explode = new Sound(_local1);
		this.explode.attachSound("explode");
		this.explodeshort = new Sound(_local1);
		this.explodeshort.attachSound("explodeshort");
		this.gameover = new Sound(_local1);
		this.gameover.attachSound("gameover");
		this.levelcompleted = new Sound(_local1);
		this.levelcompleted.attachSound("levelcompleted");
		this.pickup = new Sound(_local1);
		this.pickup.attachSound("pickup");
		this.deliver = new Sound(_local1);
		this.deliver.attachSound("deliver");
		this.thrust = new Sound(_local1);
		this.thrust.attachSound("thrust");
		this.door = new Sound(_local1);
		this.door.attachSound("door");

		this.door.onSoundComplete = function()
		{
			this.door.setVolume(100);
		}
	}

}