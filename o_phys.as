class o_phys
{
	var pos;
	var vel:o_Vector;
	var acc;
	var rot;
	var rotVel;
	var maxAcc;
	var minAcc;
	var maxVel;
	var maxRotVel;

	public function o_phys(pos, acc, rot, rotVel, maxAcc, minAcc, maxVel, maxRotVel)
	{
		this.pos = pos;
		this.vel = new o_Vector();
		this.acc = acc;
		this.rot = rot;
		this.rotVel = rotVel;
		this.maxAcc = maxAcc;
		this.minAcc = minAcc;
		this.maxVel = maxVel;
		this.maxRotVel = maxRotVel;
	}

}