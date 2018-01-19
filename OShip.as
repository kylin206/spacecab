class OShip
{
	var phys:OPhys;
	var mc;
	var hitpoints;
	var state;
	var color;
	var weight;
	var maxWeight;
	var cargo;
	var lives;
	var score;
	var fuel;
	var powerup;
	var killAll;

	public function OShip(phys, mc, hitpoints, state, color, weight, maxWeight, cargo, lives, score, fuel, powerup)
	{
		this.phys = this.createPhys();
		this.mc = mc;
		this.hitpoints = hitpoints;
		this.state = state;
		this.color = color;
		this.weight = weight;
		this.maxWeight = maxWeight;
		this.cargo = cargo;
		this.lives = lives;
		this.score = score;
		this.fuel = fuel;
		this.powerup = powerup;
	}

	private function createPhys():OPhys
	{
		var phys:OPhys = new OPhys();
		phys.pos = new Vector(100, 100);
		phys.vel = new Vector(0, 0);
		phys.acc = 0;
		phys.rot = 0;
		phys.rotVel = 0;
		phys.maxAcc = 1;
		phys.minAcc = -1;
		phys.maxVel = 1;
		return phys;
	}

}