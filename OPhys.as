class OPhys
{
	var pos;
	var vel:OVector;
	var acc;
	var rot;
	var rotVel;
	var maxAcc;
	var minAcc;
	var maxVel;
	var maxRotVel;

	public function OPhys(pos, acc, rot, rotVel, maxAcc, minAcc, maxVel, maxRotVel)
	{
		this.pos = pos;
		this.vel = new OVector();
		this.acc = acc;
		this.rot = rot;
		this.rotVel = rotVel;
		this.maxAcc = maxAcc;
		this.minAcc = minAcc;
		this.maxVel = maxVel;
		this.maxRotVel = maxRotVel;
	}

}