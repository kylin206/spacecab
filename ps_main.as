this.onEnterFrame = function()
{
	startTime = getTimer();
	if (gameState == "ON")
	{
		if (hero.state == "UNLOADING")
		{
			unloadCrates();
		}
		else if (hero.state != "DYING")
		{
			checkKeys();
			updateHero();
			checkHeroBulletsHit();
			checkShipHit();
			checkLevelchange();
		}
		updateHeroBullets();
		checkEnemyFire();
		checkEnemyBulletsHit();
		updateEnemyBullets();
		updateCamera();
		updateTimer();
	}
	else if (gameState == "OUTRO")
	{
		outroPilot(hero.phys);
	}
	else if (gameState == "GAMEOVER")
	{
	}
	endTime = getTimer();
	_parent.statusbar.looptime = endTime - startTime;
};
var hero:OShip;
this.loadLevels();
function loadLevels()
{
	arena.loadMovie("levels.swf");
}
function loadShip()
{
	hero = createShip("blue");
	arena.heroholder.loadMovie("heroship.swf");
}
function initGame()
{
	trace("initGame function started!");
	trace("Dette er main ja det er så!!!!!!!!!!!!!! " + this);
	this._quality = _parent._parent._parent.dataholder.gameQuality;
	enemyTypeProperties = new Array();
	enemyTypeProperties[0] = new o_enemyTypeProperties();
	enemyTypeProperties[0].id = 0;
	enemyTypeProperties[0].type = "BOA";
	enemyTypeProperties[0].hitpoints = 10;
	enemyTypeProperties[0].bulletType = "bulletred";
	enemyTypeProperties[0].bulletVel = 4;
	enemyTypeProperties[0].nbBullets = 5;
	enemyTypeProperties[0].nbGuns = 1;
	enemyTypeProperties[0].firerate = 50;
	enemyTypeProperties[0].accuracy = -0.0001;
	enemyTypeProperties[0].fireSound = "fireBOA";
	enemyTypeProperties[0].hitSound = "bullethitter";
	enemyTypeProperties[0].points = 50;
	enemyTypeProperties[1] = new o_enemyTypeProperties();
	enemyTypeProperties[1].id = 1;
	enemyTypeProperties[1].type = "WORMDOWN";
	enemyTypeProperties[1].hitpoints = 7;
	enemyTypeProperties[1].bulletType = "bulletgreen";
	enemyTypeProperties[1].bulletVel = 4;
	enemyTypeProperties[1].nbBullets = 4;
	enemyTypeProperties[1].nbGuns = 1;
	enemyTypeProperties[1].firerate = 50;
	enemyTypeProperties[1].accuracy = 180;
	enemyTypeProperties[1].fireSound = "fire1";
	enemyTypeProperties[1].hitSound = "hit1";
	enemyTypeProperties[1].points = 25;
	enemyTypeProperties[2] = new o_enemyTypeProperties();
	enemyTypeProperties[2].id = 2;
	enemyTypeProperties[2].type = "BOSS";
	enemyTypeProperties[2].hitpoints = 40;
	enemyTypeProperties[2].bulletType = "bulletred";
	enemyTypeProperties[2].bulletVel = 8;
	enemyTypeProperties[2].nbBullets = 25;
	enemyTypeProperties[2].nbGuns = 1;
	enemyTypeProperties[2].firerate = 50;
	enemyTypeProperties[2].accuracy = -1;
	enemyTypeProperties[2].fireSound = "fireBOA";
	enemyTypeProperties[2].hitSound = "bullethitter";
	enemyTypeProperties[2].points = 500;
	enemyTypeProperties[3] = new o_enemyTypeProperties();
	enemyTypeProperties[3].id = 3;
	enemyTypeProperties[3].type = "BOSSARM";
	enemyTypeProperties[3].hitpoints = 5;
	enemyTypeProperties[3].bulletType = "bulletgreen";
	enemyTypeProperties[3].bulletVel = 6;
	enemyTypeProperties[3].nbBullets = 12;
	enemyTypeProperties[3].nbGuns = 1;
	enemyTypeProperties[3].firerate = 0.04;
	enemyTypeProperties[3].accuracy = -0.05;
	enemyTypeProperties[3].fireSound = "fireBOA";
	enemyTypeProperties[3].hitSound = "bullethitter";
	enemyTypeProperties[3].points = 50;
	enemyTypeProperties[4] = new o_enemyTypeProperties();
	enemyTypeProperties[4].id = 4;
	enemyTypeProperties[4].type = "SEEDPOD";
	enemyTypeProperties[4].hitpoints = 7;
	enemyTypeProperties[4].bulletType = "bulletgreen";
	enemyTypeProperties[4].bulletVel = 4;
	enemyTypeProperties[4].nbBullets = 10;
	enemyTypeProperties[4].nbGuns = 4;
	enemyTypeProperties[4].firerate = 50;
	enemyTypeProperties[4].accuracy = 0;
	enemyTypeProperties[4].fireSound = "fire1";
	enemyTypeProperties[4].hitSound = "hit1";
	enemyTypeProperties[4].points = 70;
	enemyTypeProperties[5] = new o_enemyTypeProperties();
	enemyTypeProperties[5].id = 5;
	enemyTypeProperties[5].type = "FLY";
	enemyTypeProperties[5].hitpoints = 3;
	enemyTypeProperties[5].bulletType = "bulletgreen";
	enemyTypeProperties[5].bulletVel = 4;
	enemyTypeProperties[5].nbBullets = 10;
	enemyTypeProperties[5].nbGuns = 1;
	enemyTypeProperties[5].firerate = 50;
	enemyTypeProperties[5].accuracy = -1;
	enemyTypeProperties[5].fireSound = "fire1";
	enemyTypeProperties[5].hitSound = "hit1";
	enemyTypeProperties[5].points = 100;
	enemyTypeProperties[6] = new o_enemyTypeProperties();
	enemyTypeProperties[6].id = 6;
	enemyTypeProperties[6].type = "WORMRIGHT";
	enemyTypeProperties[6].hitpoints = 10;
	enemyTypeProperties[6].bulletType = "bulletgreen";
	enemyTypeProperties[6].bulletVel = 4;
	enemyTypeProperties[6].nbBullets = 4;
	enemyTypeProperties[6].nbGuns = 1;
	enemyTypeProperties[6].firerate = 30;
	enemyTypeProperties[6].accuracy = 90;
	enemyTypeProperties[6].fireSound = "fire1";
	enemyTypeProperties[6].hitSound = "hit1";
	enemyTypeProperties[6].points = 30;
	enemyTypeProperties[7] = new o_enemyTypeProperties();
	enemyTypeProperties[7].id = 7;
	enemyTypeProperties[7].type = "WORMLEFT";
	enemyTypeProperties[7].hitpoints = 10;
	enemyTypeProperties[7].bulletType = "bulletgreen";
	enemyTypeProperties[7].bulletVel = 4;
	enemyTypeProperties[7].nbBullets = 4;
	enemyTypeProperties[7].nbGuns = 1;
	enemyTypeProperties[7].firerate = 30;
	enemyTypeProperties[7].accuracy = 270;
	enemyTypeProperties[7].fireSound = "fire1";
	enemyTypeProperties[7].hitSound = "hit1";
	enemyTypeProperties[7].points = 30;
	GRAVITY = -0.15;
	nbHeroBullets = 50;
	hero.mc = arena.heroholder;
	hero.hitpoints = new Array();
	var t = 0;
	while (t < 4)
	{
		hero.hitpoints[t] = new Vector(0, 0);
		t++;
	}
	hero.mc.exhaust._visible = false;
	hero.cargo = new Array();
	trace("Creating bullets");
	bullets = new Array(nbHeroBullets);
	var t = 0;
	while (t < nbHeroBullets)
	{
		bullets[t] = new o_bullet();
		arena.attachMovie("bullethero","herobullet" + t,100 + t);
		bullets[t].mc = eval("arena.herobullet" + t);
		bullets[t].mc._visible = false;
		bullets[t].pos.x = -10;
		bullets[t].pos.y = -10;
		bullets[t].vel.x = 0;
		bullets[t].vel.y = 0;
		bullets[t].state = 0;
		t++;
	}
	initSound();
	level = 1;
	bulletNB = 0;
	dropCrateOK = true;
	hero.lives = 3;
	hero.score = 0;
	hero.fuel = 99;
	hero.weight = 0;
	hero.powerup = 0;
	hero.maxWeight = 3;
	hero.killAll();
	gameSuccess = false;
	nbLevels = arena.nbLevels;
	nbCratesAll = arena.nbCrates;
	cratesLeft = NBcratesAll;
	cratesDelivered = 0;
	scoreMultiplier = 1;
	arena.arenahit.pod.gotoAndStop(1);
	arena.startPosX = 550;
	arena.startPosY = 100;
	triggers = new Array();
	var t = 1;
	while (t < 4)
	{
		triggers[t] = 0;
		t++;
	}
	firstTimeInRoom = new Array();
	savedRoom = new Array();
	var t = 1;
	while (t <= nbLevels)
	{
		firstTimeInRoom[t] = true;
		savedRoom[t] = new o_savedRoom();
		t++;
	}
	doors = new Array();
	var t = 0;
	while (t < 5)
	{
		doors[t] = new o_door();
		t++;
	}
	_parent.statusbar.light0.gotoAndStop("greenoff");
	_parent.statusbar.light1.gotoAndStop("greenoff");
	_parent.statusbar.light2.gotoAndStop("greenoff");
	_parent.statusbar.light3.gotoAndStop("redon");
	_parent.statusbar.light4.gotoAndStop("greenoff");
	_parent.statusbar.fuel.gastank.gotoAndStop("green");
	gameState = "ON";
	initLevel(level);
	heroRespawn();
	initTimer();
}
function initLevel(newLevel)
{
	trace("Next level");
	level = newLevel;
	arena.gotoAndStop(level);
	initEnemys();
	NBplatforms = 0;
	var t = 0;
	while (t < 1000)
	{
		var tmpPlatform = eval("arena.platform" + t);
		if (typeof (tmpPlatform) == "undefined")
		{
			break;
		}
		else
		{
			NBplatforms++;
		}
		t++;
	}
	NBcrates = 0;
	var t = 0;
	while (t < 1000)
	{
		var tmpCrate = eval("arena.crate" + t);
		if (typeof (tmpCrate) == "undefined")
		{
			break;
		}
		else
		{
			NBcrates++;
			tmpCrate._visible = true;

		}
		t++;
	}
	NBpowerups = 0;
	var t = 0;
	while (t < 1000)
	{
		var tmpPowerup = eval("arena.powerup" + t);
		if (typeof (tmpPowerup) == "undefined")
		{
			break;
		}
		else
		{
			NBpowerups++;
			tmpPowerup.gotoAndPlay(1);
		}
		t++;
	}
	var t = 0;
	while (t < 5)
	{
		if (doors[t].state == 0)
		{
			tmpDoor = eval("arena.arenahit.door" + t);
			tmpDoor.gotoAndStop("closed");
		}
		t++;
	}
	if (firstTimeInRoom[level] == false)
	{
		loadRoomState(level);
	}
	else
	{
		if (level == 1)
		{
			randomMessage("ROOM1");
		}
		else if (level == 2)
		{
			enemys[0].state = 2;
			enemys[1].state = 2;
			enemys[2].state = 2;
			enemys[3].state = 2;
			enemys[4].state = 2;
			enemys[5].state = 2;
			randomMessage("ROOM2");
		}
		else if (level == 3)
		{
			randomMessage("ROOM3");
		}
		else if (level == 4)
		{
			randomMessage("ROOM4");
		}
		else if (level == 5)
		{
			enemys[0].state = 2;
			enemys[1].state = 2;
			enemys[2].state = 2;
			randomMessage("ROOM5");
		}
		else if (level == 6)
		{
			enemys[0].state = 2;
			enemys[1].state = 2;
			enemys[2].state = 2;
			enemys[3].state = 2;
			enemys[4].state = 2;
			randomMessage("ROOM6");
		}
		firstTimeInRoom[level] = false;
	}
	if (level == 1)
	{
		if (triggers[0] != 1)
		{
			arena.triggerlight.blink.gotoAndStop(1);
		}
		if ((savedRoom[6].enemys[0].state != 0) && (triggers[2] == 1))
		{
			triggers[3] = 0;
			doors[3].state = 1;
			arena.arenahit.door3.gotoAndStop("open");
			savedRoom[6].enemys[0].state = 2;
			if (savedRoom[6].enemys[1].state != 0)
			{
				savedRoom[6].enemys[1].state = 2;
			}
			if (savedRoom[6].enemys[2].state != 0)
			{
				savedRoom[6].enemys[2].state = 2;
			}
			if (savedRoom[6].enemys[3].state != 0)
			{
				savedRoom[6].enemys[3].state = 2;
			}
			if (savedRoom[6].enemys[4].state != 0)
			{
				savedRoom[6].enemys[4].state = 2;
			}
		}
	}
	else if (level == 3)
	{
		if (triggers[1] != 1)
		{
			arena.triggerlight.blink.gotoAndStop(1);
		}
	}
	else if (level == 4)
	{
		trace("OG DET VAR SÅ LEVEL 4");
		if (triggers[2] != 0)
		{
			arena.steamout0._visible = false;
			arena.steamout1._visible = false;
			arena.steamout2._visible = false;
			arena.steamout3._visible = false;
			arena.steamout4._visible = false;
			arena.steamout5._visible = false;
			arena.steamin1.gotoAndPlay(16);
			arena.steamin2.gotoAndPlay(32);
			arena.steamin3.gotoAndPlay(8);
			arena.steamin4.gotoAndPlay(24);
			arena.steamin5.gotoAndPlay(40);
		}
		else
		{
			arena.steamin0._visible = false;
			arena.steamin1._visible = false;
			arena.steamin2._visible = false;
			arena.steamin3._visible = false;
			arena.steamin4._visible = false;
			arena.steamin5._visible = false;
			arena.steamout1.gotoAndPlay(16);
			arena.steamout2.gotoAndPlay(32);
			arena.steamout3.gotoAndPlay(8);
			arena.steamout4.gotoAndPlay(24);
			arena.steamout5.gotoAndPlay(40);
		}
	}
	else if (level == 5)
	{
		if (triggers[2] == 1)
		{
			trace("Play that enemy0!!!!!");
			arena.enemy0.gotoAndPlay("loop");
			arena.enemy1.gotoAndPlay("loop");
			arena.enemy2.gotoAndPlay("loop");
		}
		else
		{
			arena.triggerlight.blink.gotoAndStop(1);
		}
	}
	else if (level == 6)
	{
		if (triggers[3] != 1)
		{
			arena.triggerlight.blink.gotoAndStop(1);
		}
		var t = 0;
		while (t < 5)
		{
			if (enemy.state == 0)
			{
				enemy.mc.shield._visible = false;
			}
			t++;
		}
	}
	_parent.statusbar.score = hero.score;
	_parent.statusbar.crates = cratesLeft;
	_parent.statusbar.fuel.needle._rotation = (hero.fuel * -0.8) + 40;
	_parent.statusbar.posx = hero.phys.pos.x;
	_parent.statusbar.posy = hero.phys.pos.y;
}
function exitLevel()
{
	saveRoomState(level);
	var i:Number = 0;
	while (i < nbHeroBullets)
	{
		bullets[i].mc._visible = false;
		bullets[i].pos.x = -10;
		bullets[i].pos.y = -10;
		bullets[i].vel.x = 0;
		bullets[i].vel.y = 0;
		bullets[i].state = 0;
		i++;
	}
	i = 0;
	while (i < enemys.length)
	{
		trace("Removing bullets for enemy number " + i);
		var j = 0;
		while (j < enemys[i].nbBullets)
		{
			enemys[i].bullets[j].mc._visible = false;
			enemys[i].bullets[j].pos.x = -10;
			enemys[i].bullets[j].pos.y = -10;
			enemys[i].bullets[j].vel.x = 0;
			enemys[i].bullets[j].vel.y = 0;
			enemys[i].bullets[j].state = 0;
			j++;
		}
		i++;
	}
}
function initEnemys()
{
	enemys = new Array();
	var t = 0;
	var enemy:o_enemy;
	while (t < 999)
	{
		var tmpEnemy = eval("arena.enemy" + t);
		if (typeof (tmpEnemy) == "undefined")
		{
			break;
		}
		else
		{
			enemy = new o_enemy();
			enemys[t] = enemy;
			enemy.id = t;
			enemy.mc = tmpEnemy;
			if (!firstTimeInRoom[level])
			{
				enemy.type = savedRoom[level].enemy.type;
			}
			else
			{
				enemy.type = arena.enemys[level][t];
			}
			trace("Initialising enemy number " + t + ". Type = \"" + enemy.type + "\"");
			enemy.phys = new o_enemyPhys();
			enemy.phys.rot = tmpEnemy._rotation;
			tt = 0;
			while (tt < enemyTypeProperties.length)
			{
				if (enemyTypeProperties[tt].type == enemy.type)
				{
					enemy.typeID = tt;
					enemy.hitpoints = enemyTypeProperties[tt].hitpoints;
					enemy.nbBullets = enemyTypeProperties[tt].nbBullets;
					enemy.bulletType = enemyTypeProperties[tt].bulletType;
					break;
				}
				tt++;
			}
			enemy.bulletNB = 0;
			enemy.lastFireFrames = 0;
			enemy.state = 1;
			enemy.mc.gotoAndPlay(1);
			enemy.mc.ship.gotoAndStop(1);
			enemy.mc._visible = true;
		}
		t++;
	}
	var t = 0;
	while (t < enemys.length)
	{
		trace("Creating bullets for enemy number " + t);
		enemy = enemys[t];
		enemy.bullets = new Array(enemy.nbBullets);
		var tt = 0;
		while (tt < enemy.nbBullets)
		{
			enemy.bullets[tt] = new o_bullet();
			arena.attachMovie(enemy.bulletType,(("enemy" + t) + "bullet") + tt,((t + 2) * 100) + tt);
			enemy.bullets[tt].mc = eval((("arena.enemy" + t) + "bullet") + tt);
			enemy.bullets[tt].mc._visible = false;
			enemy.bullets[tt].pos.x = -10;
			enemy.bullets[tt].pos.y = -10;
			enemy.bullets[tt].vel.x = 0;
			enemy.bullets[tt].vel.y = 0;
			enemy.bullets[tt].state = 0;
			tt++;
		}
		t++;
	}
}
function updateHero()
{
	with(this.hero)
	{
		if (state == "FLYING")
		{
			heroCos = Math.cos(((phys.rot - 90) * Math.PI) / 180);
			heroSin = -Math.sin(((phys.rot - 90) * Math.PI) / 180);
			var vel = phys.vel;
			phys.rot += phys.rotVel;
			vel.x *= 0.98;
			vel.y *= 0.98;
			vel.x += phys.acc * heroCos;
			vel.y += (phys.acc * heroSin) + (GRAVITY * ((weight / 2) + 1));
			
			if ((level == 4) && (pos.x < arena.blackhole0._x))
			{
				var t = 0;
				while (t < 6)
				{
					var tmpBlackholeMC = eval("arena.blackhole" + t);
					var tmpBlackvector = new Vector(0, 0);
					tmpBlackvector.x = phys.pos.x - tmpBlackholeMC._x;
					tmpBlackvector.y = phys.pos.y + tmpBlackholeMC._y;
					var dist = ((tmpBlackvector.x * tmpBlackvector.x) + (tmpBlackvector.y * tmpBlackvector.y));
					if (dist < 22500)
					{
						holepower = (dist / 22500) - 1;
						tmpBlackvector = normalizeV(tmpBlackvector.x, tmpBlackvector.y);
						if (triggers[2] != 1)
						{
							vel.x = vel.x - ((tmpBlackvector.x * holepower) * 0.3);
							vel.y = vel.y - ((tmpBlackvector.y * holepower) * 0.3);
						}
						else
						{
							vel.x = vel.x + ((tmpBlackvector.x * holepower) * 0.25);
							vel.y = vel.y + ((tmpBlackvector.y * holepower) * 0.25);
						}
					}
					t++;
				}
			}
			phys.pos.x += vel.x;
			phys.pos.y += vel.y;
			arena.heroholder._x = phys.pos.x;
			arena.heroholder._y = -phys.pos.y;
			arena.heroholder._rotation = phys.rot;
			phys.acc *= 0.9;

		}
	}
}
function checkLevelchange()
{
	if (level == 1)
	{
		if (hero.mc.center.hitTest(arena.changelevel0) == true)
		{
			changeLevel(6);
		}
		else if (hero.mc.center.hitTest(arena.changelevel1) == true)
		{
			changeLevel(2);
		}
		else if (hero.mc.center.hitTest(arena.changelevel2) == true)
		{
			changeLevel(4);
		}
		else if (hero.mc.center.hitTest(arena.changelevel3) == true)
		{
			gameCompleted();
		}
	}
	else if (level == 2)
	{

		if (hero.mc.center.hitTest(arena.changelevel0) == true)
		{
			changeLevel(3);
		}
		else if (hero.mc.center.hitTest(arena.changelevel1) == true)
		{
			changeLevel(1);
		}
	}
	else if (level == 3)
	{
		if (hero.mc.center.hitTest(arena.changelevel0) == true)
		{
			changeLevel(2);
		}
	}
	else if (level == 4)
	{
		if (hero.mc.center.hitTest(arena.changelevel0) == true)
		{
			changeLevel(1);
		}
		else if (hero.mc.center.hitTest(arena.changelevel1) == true)
		{
			changeLevel(5);
		}
	}
	else if (level == 5)
	{
		if (hero.mc.center.hitTest(arena.changelevel0) == true)
		{
			changeLevel(4);
		}
	}
	else if (level == 6)
	{
		if (doors[3].state == 1)
		{
			if (hero.mc.center.hitTest(arena.changelevel0) == true)
			{
				changeLevel(1);
			}
		}
	}
}
function changeLevel(newLevel)
{
	var _local1 = newLevel;
	trace("Level was : " + level);
	trace("Level is now : " + _local1);
	localposX = (hero.phys.pos.x + arena.offsetX[level]) - arena.offsetX[_local1];
	localposY = (hero.phys.pos.y + arena.offsetY[level]) - arena.offsetY[_local1];
	exitLevel();
	initLevel(_local1);
	placeHero();
}
function checkShipHit()
{
	var t = 0;
	while (t < 4)
	{
		var tmpHitpoint = eval("hero.mc.hit" + t);
		hero.hitpoints[t].x = tmpHitpoint._x;
		hero.hitpoints[t].y = tmpHitpoint._y;
		hero.mc.localToGlobal(hero.hitpoints[t]);
		t++;
	}
	if (hero.state == "FLYING")
	{
		var t = 0;
		while (t < NBplatforms)
		{
			tmpPlatform = eval("arena.platform" + t);
			if (hero.mc.hull.hitTest(tmpPlatform) == true)
			{
				if ((hero.mc._rotation >= -10) && (hero.mc._rotation <= 10))
				{
					if ((hero.mc._rotation == 0) && (hero.phys.vel.y > -2))
					{
						trace("The eagle has landed!");
						hero.killAll();
						hero.phys.rot = 0;
						hero.phys.acc = 0;
						hero.phys.pos.y = -(tmpPlatform._y - 14.2);
						hero.mc._y = -hero.phys.pos.y;
						hero.mc._rotation = 0;
						hero.mc.exhaust._visible = false;
						hero.state = "PARKED";
						heroCos = Math.cos(((hero.phys.rot - 90) * Math.PI) / 180);
						heroSin = -Math.sin(((hero.phys.rot - 90) * Math.PI) / 180);
						if ((level == 1) && (t == 0))
						{
							hero.fuel = 99;
							_parent.statusbar.fuel.needle._rotation = (hero.fuel * -0.8) + 40;
							_parent.statusbar.fuel.gastank.gotoAndStop("green");
							randomMessage("HOMEBASE");
							if (hero.cargo.length > 0)
							{
								unloadCrates();
							}
						}
						else
						{
							if (tmpPlatform.triggerID >= 0)
							{
								triggerActivate(tmpPlatform.triggerID);
							}
							var tt = 0;
							while (tt < NBcrates)
							{
								tmpCrate = eval("arena.crate" + tt);
								if (((tmpCrate._visible == true) && (hero.mc.hull.hitTest(tmpCrate) == true)) && ((hero.weight + tmpCrate.weight) <= hero.maxWeight))
								{
									trace("Crate");
									tmpCrate._visible = false;
									theSounds.pickup.start();
									hero.weight = hero.weight + tmpCrate.weight;
									hero.cargo[hero.cargo.length] = tmpCrate;
									cratesLeft--;
									savedRoom[level].crates[tt] = 0;
									_parent.statusbar.crates = cratesLeft;
									randomMessage("PICKUP");
									if (cratesLeft == 0)
									{
										_parent.statusbar.light3.gotoAndStop("greenon");
									}
									_parent.statusbar.cargo++;
									if (hero.weight >= hero.maxWeight)
									{
										_parent.statusbar.light4.gotoAndStop("redon");
									}
									else
									{
										_parent.statusbar.light4.gotoAndStop("greenon");
									}
								}
								tt++;
							}
							var tt = 0;
							while (tt < NBpowerups)
							{
								tmpPowerup = eval("arena.powerup" + tt);
								if ((tmpPowerup._visible == true) && (hero.mc.hull.hitTest(tmpPowerup) == true))
								{
									trace("Powerup");
									tmpPowerup._visible = false;
									theSounds.pickup.start();
									hero.powerup = tmpPowerup.powerup;
								}
								tt++;

							}
						}

					}
					else
					{
						hero.phys.vel.x = hero.phys.vel.x * 0.8;
						hero.phys.vel.y = hero.phys.vel.y * -0.8;
						hero.phys.rot = 0;
					}
				}
				else
				{
					heroDie();
				}
				return (undefined);
			}
			t++;
		}
		wasHit = false;
		var t = 0;
		while (t < 4)
		{
			var tt = 0;
			while (tt < enemys.length)
			{
				if (enemys[tt].state != 0)
				{
					if (enemys[tt].mc.hitTest(hero.hitpoints[t].x, hero.hitpoints[t].y, true) == true)
					{
						wasHit = true;
					}
				}
				tt++;
			}
			if (arena.arenahit.hitTest(hero.hitpoints[t].x, hero.hitpoints[t].y, true) == true)
			{
				wasHit = true;
			}
			t++;
		}
		if (wasHit == true)
		{
			heroDie();
		}
	}
}
function checkHeroBulletsHit()
{
	var _local3 = 0;
	while (_local3 < nbHeroBullets)
	{
		if (bullets[_local3].state == 1)
		{
			bullets[_local3].screenPos.x = bullets[_local3].pos.x;
			bullets[_local3].screenPos.y = -bullets[_local3].pos.y;
			arena.localToGlobal(bullets[_local3].screenPos);
			var _local1 = 0;
			while (_local1 < enemys.length)
			{
				if (enemys[_local1].state != 0)
				{
					if (enemys[_local1].mc.hitTest(bullets[_local3].screenPos.x, bullets[_local3].screenPos.y, true) == true)
					{
						bullets[_local3].state = 0;
						bullets[_local3].mc.play();
						if (enemys[_local1].state == 1)
						{
							enemys[_local1].hitpoints--;
						}
						if (enemys[_local1].hitpoints <= 0)
						{
							enemys[_local1].state = 0;
							enemys[_local1].mc.stop();
							enemys[_local1].mc.ship.gotoAndPlay("explode");
							hero.score = hero.score + enemyTypeProperties[enemys[_local1].typeID].points;
							_parent.statusbar.score = hero.score;
							randomMessage("SHOOTENEMY");
							if ((level == 6) && (_local1 == 0))
							{
								var _local2 = 1;
								while (_local2 < 5)
								{
									if (enemys[_local2].state != 0)
									{
										enemys[_local2].state = 0;
										enemys[_local2].mc.stop();
										enemys[_local2].mc.ship.gotoAndPlay("explode");
									}
									_local2++;
								}
								arena.arenahit.door3.play();
								doors[3].state = 1;
								doors[4].state = 1;
							}
						}
						else
						{
							theSounds.bullethitter.start();
						}
					}
				}
				_local1++;
			}
			if (arena.arenahit.hitTest(bullets[_local3].screenPos.x, bullets[_local3].screenPos.y, true) == true)
			{
				bullets[_local3].state = 0;
				bullets[_local3].mc.play();
			}
		}
		_local3++;
	}
}
function checkEnemyBulletsHit()
{
	var i = 0;
	while (i < enemys.length)
	{
		var _local1 = 0;
		while (_local1 < enemys[i].nbBullets)
		{
			if (enemys[i].bullets[_local1].state == 1)
			{
				enemys[i].bullets[_local1].screenPos.x = enemys[i].bullets[_local1].pos.x;
				enemys[i].bullets[_local1].screenPos.y = -enemys[i].bullets[_local1].pos.y;
				arena.localToGlobal(enemys[i].bullets[_local1].screenPos);
				if (arena.arenahit.hitTest(enemys[i].bullets[_local1].screenPos.x, enemys[i].bullets[_local1].screenPos.y, true) == true)
				{
					enemys[i].bullets[_local1].state = 0;
					enemys[i].bullets[_local1].mc.play();
				}
				else if (hero.mc.hull.hitTest(enemys[i].bullets[_local1].screenPos.x, enemys[i].bullets[_local1].screenPos.y, true) == true)
				{
					if (hero.state != "DYING")
					{
						enemys[i].bullets[_local1].state = 0;
						enemys[i].bullets[_local1].mc.play();
						heroDie();
					}
				}
			}
			_local1++;
		}
		i++;
	}
}
function unloadCrates()
{
	hero.state = "UNLOADING";
	if (crateIndex < hero.cargo.length)
	{
		if (dropCrateOK == true)
		{
			var tmpDropCrate = eval("arena.dropcrate" + crateIndex);
			dropCrateOK = false;
			tmpDropCrate._x = hero.mc._x;
			tmpDropCrate._y = arena.platform0._y;
			tmpDropCrate._visible = true;
			tmpDropCrate.play();
			theSounds.deliver.start();
			hero.score = hero.score + (100 * scoreMultiplier);
			scoreMultiplier = scoreMultiplier * 2;
			cratesDelivered++;
			_parent.statusbar.score = hero.score;
			_parent.statusbar.cargo--;
			if (_parent.statusbar.cargo == 0)
			{
				_parent.statusbar.light4.gotoAndStop("greenoff");
			}
			else
			{
				_parent.statusbar.light4.gotoAndStop("greenon");
			}
		}
	}
	else
	{
		scoreMultiplier = 1;
		hero.cargo.length = 0;
		crateIndex = 0;
		hero.weight = 0;
		hero.state = "PARKED";
		_parent.statusbar.light4.gotoAndStop("greenoff");
	}
}
function updateHeroBullets()
{
	var _local1 = 0;
	while (_local1 < nbHeroBullets)
	{
		if (bullets[_local1].state == 1)
		{
			bullets[_local1].pos.x = bullets[_local1].pos.x + bullets[_local1].vel.x;
			bullets[_local1].pos.y = bullets[_local1].pos.y + (bullets[_local1].vel.y + GRAVITY);
			setProperty("arena.herobullet" + _local1, _x, bullets[_local1].pos.x);
			setProperty("arena.herobullet" + _local1, _y, -bullets[_local1].pos.y);
		}
		_local1++;
	}
}
function checkEnemyFire()
{
	var _local1 = 0;
	while (_local1 < enemys.length)
	{
		if (enemys[_local1].state == 1)
		{
			enemys[_local1].lastFireFrames++;
			if (enemyTypeProperties[enemys[_local1].typeID].firerate == "ONSIGHT")
			{
				enemys[_local1].phys.rot = enemys[_local1].mc.ship._rotation;
			}
			else if (enemyTypeProperties[enemys[_local1].typeID].firerate > 1)
			{
				if (enemys[_local1].lastFireFrames >= enemyTypeProperties[enemys[_local1].typeID].firerate)
				{
					fireEnemyBullets(enemys[_local1],0);
					enemys[_local1].lastFireFrames = 0;
				}
			}
			else if (enemyTypeProperties[enemys[_local1].typeID].firerate < 1)
			{
				if (Math.random() <= enemyTypeProperties[enemys[_local1].typeID].firerate)
				{
					fireEnemyBullets(enemys[_local1],0);
					enemys[_local1].lastFireFrames = 0;
				}
			}
			else
			{
				trace("Enemy firerate not identified!!!!!!!!!! Something is weird!!!!!!!!!!!");
			}
		}
		_local1++;
	}
}
function fireEnemyBullets($enemy, gunID)
{
	var enemy = $enemy;
	if (enemy.bulletNB >= (enemy.nbBullets - 1))
	{
		enemy.bulletNB = 0;
	}
	else
	{
		enemy.bulletNB++;
	}
	var _local3 = new Vector(0, 0);
	_local3.x = enemy.mc.ship.bulletpoint0._x;
	_local3.y = enemy.mc.ship.bulletpoint0._y;
	enemy.mc.ship.localToGlobal(_local3);
	arena.globalToLocal(_local3);
	enemy.bullets[enemy.bulletNB].pos.x = _local3.x;
	enemy.bullets[enemy.bulletNB].pos.y = -_local3.y;
	
	if (enemy.type == "SEEDPOD")
	{
		var randDegree = ((Math.random() * 90) - 45);
		var aimCos = Math.cos((((enemy.phys.rot - 90) + randDegree) * Math.PI) / 180);
		var aimSin = (-Math.sin((((enemy.phys.rot - 90) + randDegree) * Math.PI) / 180));
		enemy.bullets[enemy.bulletNB].vel.x = aimCos * enemyTypeProperties[enemy.typeID].bulletVel;
		enemy.bullets[enemy.bulletNB].vel.y = aimSin * enemyTypeProperties[enemy.typeID].bulletVel;
	}
	else if (enemyTypeProperties[enemy.typeID].accuracy < 0)
	{
		var vec = new Vector();
		vec.x = hero.phys.pos.x - enemy.bullets[enemy.bulletNB].pos.x;
		vec.y = hero.phys.pos.y - enemy.bullets[enemy.bulletNB].pos.y;
		trace("  "+hero.phys.pos.y +"  "+enemy.bullets[enemy.bulletNB].pos.x)
		vec = normalizeV(vec.x, vec.y);
		var adjustDegrees = (360 * (enemyTypeProperties[enemy.typeID].accuracy + 1));
		adjustDegrees = (Math.random() * adjustDegrees) - (adjustDegrees / 2);
		var aimCos = Math.cos((adjustDegrees * Math.PI) / 180);
		var aimSin = (-Math.sin((adjustDegrees * Math.PI) / 180));
		var newX = ((vec.x * aimCos) + (vec.y * (-aimSin)));
		var newY = ((vec.x * aimSin) + (vec.y * aimCos));
		enemy.bullets[enemy.bulletNB].vel.x = newX * enemyTypeProperties[enemy.typeID].bulletVel;
		enemy.bullets[enemy.bulletNB].vel.y = newY * enemyTypeProperties[enemy.typeID].bulletVel;
	
	}
	else if (enemyTypeProperties[enemy.typeID].accuracy >= 0)
	{
		var aimCos = Math.cos((((enemyTypeProperties[enemy.typeID].accuracy + enemy.phys.rot) - 90) * Math.PI) / 180);
		var aimSin = (-Math.sin((((enemyTypeProperties[enemy.typeID].accuracy + enemy.phys.rot) - 90) * Math.PI) / 180));
		enemy.bullets[enemy.bulletNB].vel.x = aimCos * enemyTypeProperties[enemy.typeID].bulletVel;
		enemy.bullets[enemy.bulletNB].vel.y = aimSin * enemyTypeProperties[enemy.typeID].bulletVel;
	}
	enemy.bullets[enemy.bulletNB].state = 1;
	enemy.bullets[enemy.bulletNB].mc.gotoAndStop(1);
	enemy.bullets[enemy.bulletNB].mc._visible = true;
	
	if (gunID < (enemyTypeProperties[enemy.typeID].nbGuns - 1))
	{
		fireEnemyBullets(enemy,gunID + 1);
	}
	else
	{
		theSounds.heroshoot.start();
	}
}

function updateEnemyBullets()
{
	var i = 0;
	while (i < enemys.length)
	{
		var _local1 = 0;
		while (_local1 < enemys[i].nbBullets)
		{
			if (enemys[i].bullets[_local1].state == 1)
			{
				enemys[i].bullets[_local1].pos.x = enemys[i].bullets[_local1].pos.x + enemys[i].bullets[_local1].vel.x;
				enemys[i].bullets[_local1].pos.y = enemys[i].bullets[_local1].pos.y + enemys[i].bullets[_local1].vel.y;
				setProperty((("arena.enemy" + i) + "bullet") + _local1, _x, enemys[i].bullets[_local1].pos.x);
				setProperty((("arena.enemy" + i) + "bullet") + _local1, _y, -enemys[i].bullets[_local1].pos.y);
			}
			_local1++;
		}
		i++;
	}
}
function checkKeys()
{
	var _local1 = _parent;
	if (Key.isDown(38))
	{
		if (hero.fuel > 0)
		{
			_local1.statusbar.light0.gotoAndStop("greenon");
			if (hero.state == "PARKED")
			{
				hero.phys.acc = 0.5;
			}
			setAcc(hero.phys,1);
			hero.fuel = hero.fuel - 0.01;
			_local1.statusbar.fuel.needle._rotation = (hero.fuel * -0.8) + 40;
			if (hero.fuel <= 20)
			{
				if (_local1.statusbar.fuel.gastank._currentframe == 1)
				{
					_local1.statusbar.fuel.gastank.gotoAndPlay("blink");
				}
			}
			hero.mc.exhaust._visible = true;
			hero.state = "FLYING";
			if (thrusting == false)
			{
				theSounds.thrust.start(0,1000);
				thrusting = true;
			}
		}
		else
		{
			_local1.statusbar.light0.gotoAndStop("greenoff");
			hero.phys.acc = 0;
			hero.mc.exhaust._visible = false;
			theSounds.thrust.stop("thrust");
			thrusting = false;
			if (hero.state == "PARKED")
			{
				heroDie();
			}
		}
	}
	else
	{
		_local1.statusbar.light0.gotoAndStop("greenoff");
		hero.phys.acc = 0;
		hero.mc.exhaust._visible = false;
		theSounds.thrust.stop("thrust");
		thrusting = false;
	}
	if (Key.isDown(39))
	{
		_local1.statusbar.light2.gotoAndStop("greenon");
		setrotvel(hero.phys,10);
	}
	else if (Key.isDown(37))
	{
		_local1.statusbar.light1.gotoAndStop("greenon");
		setrotvel(hero.phys,-10);
	}
	else
	{
		hero.phys.rotVel = 0;
	}
	if (Key.isDown(39) == false)
	{
		_local1.statusbar.light2.gotoAndStop("greenoff");
	}
	if (Key.isDown(37) == false)
	{
		_local1.statusbar.light1.gotoAndStop("greenoff");
	}
	if (Key.isDown(17) || (Key.isDown(32)))
	{
		if (hero.powerup == "AUTOFIRE")
		{
			autofireCount++;
			if (autofireCount > 6)
			{
				FIREOK = true;
				autofireCount = 0;
			}
		}
		if (FIREOK != false)
		{
			FIREOK = false;
			fireHeroBullets();
		}
	}
	else
	{
		FIREOK = true;
	}
	if (Key.isDown(81))
	{
		hero.powerup = "AUTOFIRE";
	}
	if (Key.isDown(87))
	{
		hero.powerup = "DOUBLESHOT";
	}
	if (Key.isDown(69))
	{
		hero.powerup = "BACKFIRE";
	}
}
function heroDie()
{
	hero.state = "DYING";
	hero.killAll();
	hero.mc.gotoAndPlay("explode");
	theSounds.explode.start();
	//hero.lives--;
	hero.powerup = 0;
	randomMessage("HERODIE");
}
function heroRespawn()
{
	var _local1 = _parent;
	if (hero.lives < 0)
	{
		gameOver();
	}
	else
	{
		if (level != 1)
		{
			changeLevel(1);
		}
		trace("Spawning ship");
		hero.fuel = 99;
		_local1.statusbar.fuel.needle._rotation = (hero.fuel * -0.8) + 40;
		_local1.statusbar.fuel.gastank.gotoAndStop("green");
		hero.weight = 0;
		hero.cargo.length = 0;
		crateIndex = 0;
		_local1.statusbar.cargo = 0;
		_local1.statusbar.light4.gotoAndStop("greenoff");
		_local1.statusbar.lives.gotoAndStop(hero.lives + "L");
		FIREOK = true;
		arena.heroholder.gotoAndStop("normal");
		hero.phys.pos.x = arena.startPosX;
		hero.phys.pos.y = -arena.startPosY;
		hero.phys.vel.x = 0;
		hero.phys.vel.y = 0;
		hero.phys.rot = 0;
		heroCos = Math.cos(((rot - 90) * Math.PI) / 180);
		heroSin = -Math.sin(((rot - 90) * Math.PI) / 180);
		hero.state = "FLYING";
		hero.mc._x = hero.phys.pos.x;
		hero.mc._y = -hero.phys.pos.y;
		hero.mc._rotation = hero.phys.rot;
	}
}
function placeHero()
{
	hero.phys.pos.x = localposX;
	hero.phys.pos.y = localposY;
	hero.mc._x = hero.phys.pos.x;
	hero.mc._y = -hero.phys.pos.y;
	hero.mc._rotation = hero.phys.rot;
}
function gameCompleted()
{
	trace("Game completed. Hoooorrraayyyyy!!!");
	gameSuccess = true;
	arena.arenahit.pod.play();
	hero.score = hero.score + Math.round(600000 / timeSpent);
	gameState = "OUTRO";
}
function gameOver()
{
	trace("Game Over man. Game Over!!!");
	trace("and the time was : timeSpent : " + timeSpent);
	theSounds.thrust.stop("thrust");
	gameState = "GAMEOVER";
	if (gameSuccess == true)
	{
		if (cratesDelivered == NBcratesAll)
		{
			_parent._parent._parent._parent.gotoAndPlay("success");
		}
		else
		{
			_parent._parent._parent._parent.gotoAndPlay("limitedsuccess");
		}
	}
	else if (gameSuccess == "QUIT")
	{
		_parent._parent._parent._parent.gotoAndPlay("aborted");
	}
	else
	{
		_parent._parent._parent._parent.gotoAndPlay("failure");
	}
	exitLevel();
	_parent._parent._parent.dataholder.playerScore = hero.score;
	trace("DATAHOLDER : " + eval(_parent._parent._parent.dataholder));
	this._quality = _parent._parent._parent.dataholder.menuQuality;
}
function outroPilot(physObj)
{
	with (physObj)
	{
		setAcc(physObj,1);
		heroCos = Math.cos((rot - 90) * Math.PI / 180);
		heroSin = -Math.sin((rot - 90) * Math.PI / 180);
		rot = rot + rotVel;
		vel.x = vel.x * 0.98;
		vel.y = vel.y * 0.98;
		vel.x = vel.x + (acc * heroCos);
		vel.y = vel.y + ((acc * heroSin) + (GRAVITY * ((hero.weight / 2) + 1)));
		pos.x = pos.x + vel.x;
		pos.y = pos.y + vel.y;
		arena.heroholder._x = pos.x;
		arena.heroholder._y = -pos.y;
		arena.heroholder._rotation = rot;
		acc = acc * 0.9;
	}
}
function abortGame()
{
	trace("Game aborted. WUZZZZZZZZZZZZZZ!!!");
	gameSuccess = "QUIT";
	hero.score = 0;
	gameOver();
}
function randomMessage(type)
{
	#include "randomMessage.txt"
}

function setAcc(phys, val)
{
	with (phys)
	{
		acc = acc + (val * 0.06);
		if (acc > maxAcc)
		{
			acc = maxAcc;
		}
		else if (acc < minAcc)
		{
			acc = minAcc;
		}
	}
}
function setrotvel(phys, val)
{
	with (phys)
	{
		rotVel = val;
	}
}
function fireHeroBullets()
{
	if (hero.powerup == "DOUBLESHOT")
	{
		fireOne(2,0);
		fireOne(3,0);
	}
	else if (hero.powerup == "BACKFIRE")
	{
		fireOne(0,0);
		fireOne(1,180);
	}
	else
	{
		fireOne(0,0);
	}
	theSounds.heroshoot.start();
}
function fireOne(gunID, angle)
{
	if (bulletNB >= (nbHeroBullets - 1))
	{
		bulletNB = 0;
	}
	else
	{
		bulletNB++;
	}
	var tmpGun = eval("hero.mc.bulletpoint" + gunID);
	bullets[bulletNB].pos.x = (hero.phys.pos.x + (tmpGun._x * heroSin)) + ((-tmpGun._y) * heroCos);
	bullets[bulletNB].pos.y = (hero.phys.pos.y + ((-tmpGun._x) * heroCos)) + ((-tmpGun._y) * heroSin);
	bullets[bulletNB].vel.x = (hero.phys.vel.x / 4) + (10 * heroCos);
	bullets[bulletNB].vel.y = (hero.phys.vel.y / 4) + (10 * heroSin);
	var bulletCos = Math.cos((angle * Math.PI) / 180);
	var bulletSin = (-Math.sin((angle * Math.PI) / 180));
	
	var NewX = ((bullets[bulletNB].vel.x * bulletCos) + (bullets[bulletNB].vel.y * (-bulletSin)));
	var NewY = ((bullets[bulletNB].vel.x * bulletSin) + (bullets[bulletNB].vel.y * bulletCos));
	bullets[bulletNB].vel.x = NewX;
	bullets[bulletNB].vel.y = NewY;
	
	bullets[bulletNB].state = 1;
	bullets[bulletNB].mc._visible = true;
}
function triggerActivate(triggerID)
{
	var _local1 = triggerID;
	trace("Det var da vist en trigger!!!");
	if (_local1 == 0)
	{
		if (triggers[0] != 1)
		{
			triggers[0] = 1;
			arena.triggerlight.blink.play();
			arena.arenahit.door0.play();
			theSounds.door.start();
			doors[0].state = 1;
			randomMessage("TRIGGER");
		}
	}
	else if (_local1 == 1)
	{
		if (triggers[1] != 1)
		{
			triggers[1] = 1;
			arena.triggerlight.blink.play();
			theSounds.door.setVolume(75);
			theSounds.door.start();
			doors[1].state = 1;
			doors[2].state = 1;
			randomMessage("TRIGGER");
			savedRoom[2].enemys[0].state = 1;
			savedRoom[2].enemys[1].state = 1;
			savedRoom[2].enemys[2].state = 1;
			savedRoom[2].enemys[3].state = 1;
			savedRoom[2].enemys[4].state = 1;
			savedRoom[2].enemys[5].state = 1;
		}
	}
	else if (_local1 == 2)
	{
		if (triggers[2] != 1)
		{
			triggers[2] = 1;
			arena.triggerlight.blink.play();
			theSounds.door.setVolume(50);
			theSounds.door.start();
			doors[3].state = 1;
			randomMessage("TRIGGER");
			enemys[0].state = 1;
			arena.enemy0.play();
			enemys[1].state = 1;
			arena.enemy1.play();
			enemys[2].state = 1;
			arena.enemy2.play();
		}
	}
	else if (_local1 == 3)
	{
		if (triggers[3] != 1)
		{
			triggers[3] = 1;
			arena.triggerlight.blink.play();
			arena.arenahit.door3.play();
			theSounds.door.start();
			doors[3].state = 0;
			randomMessage("TRIGGER");
			enemys[0].state = 1;
			enemys[1].state = 1;
			enemys[2].state = 1;
			enemys[3].state = 1;
			enemys[4].state = 1;
		}
	}
}
function saveRoomState(roomID)
{
	var _local2 = roomID;
	trace("Saving room state");
	var _local1 = 0;
	while (_local1 < enemys.length)
	{
		savedRoom[_local2].enemys[_local1] = new o_savedEnemy();
		savedRoom[_local2].enemys[_local1].state = enemys[_local1].state;
		savedRoom[_local2].enemys[_local1].hitpoints = enemys[_local1].hitpoints;
		savedRoom[_local2].enemys[_local1].type = enemys[_local1].type;
		_local1++;
	}
}
function loadRoomState(roomID)
{

	var _local2 = roomID;
	trace("Loading room state");
	var _local1 = 0;
	while (_local1 < enemys.length)
	{

		enemys[_local1].state = savedRoom[_local2].enemys[_local1].state;
		enemys[_local1].hitpoints = savedRoom[_local2].enemys[_local1].hitpoints;
		enemys[_local1].type = savedRoom[_local2].enemys[_local1].type;
		trace((("Enemy id : " + _local1) + "   State : ") + savedRoom[_local2].enemys[_local1].state);
		if (enemys[_local1].state == 0)
		{
			enemys[_local1].mc.stop();
			enemys[_local1].mc.ship.gotoAndStop("dead");
		}
		_local1++;
	}
	_local1 = 0;
	while (_local1 < nbCrates)
	{
		if (savedRoom[_local2].crates[_local1] == 0)
		{
			setProperty("arena.crate" + _local1, _visible, false);
		}
		_local1++;
	}
}
function updateCamera()
{
	if (arena.frame._width > 800)
	{
		camX = -(hero.phys.pos.x - 400);
		if (camX > arena.frame._x)
		{
			camX = arena.frame._x;
		}
		else if (camX < (-((arena.frame._width + arena.frame._x) - 800)))
		{
			camX = -((arena.frame._width + arena.frame._x) - 800);
		}
		arena._x = camX;
	}
	else
	{
		arena._x = 400 - (arena.frame._width / 2);
	}
	if (arena.frame._height > 600)
	{
		camY = hero.phys.pos.y + 300;
		if (camY > (-arena.frame._y))
		{
			camY = -arena.frame._y;
		}
		else if (camY < (-(((arena.frame._height + arena.frame._y) - 600) + 55)))
		{
			camY = -(((arena.frame._height + arena.frame._y) - 600) + 55);
		}
		arena._y = camY;
	}
	else
	{
		arena._y = 300 - (arena.frame._height / 2);
	}
}
function createShip(color)
{
	trace("creating Ship object");
	var ship:OShip = new OShip();
	ship.color = color;
	return ship;
}
function initSound()
{
	var _local1 = this;
	theSounds = new o_sounds();
	theSounds.heroshoot = new Sound(_local1);
	theSounds.heroshoot.attachSound("heroshoot");
	theSounds.bullethitter = new Sound(_local1);
	theSounds.bullethitter.attachSound("bullethitter");
	theSounds.explode = new Sound(_local1);
	theSounds.explode.attachSound("explode");
	theSounds.explodeshort = new Sound(_local1);
	theSounds.explodeshort.attachSound("explodeshort");
	theSounds.gameover = new Sound(_local1);
	theSounds.gameover.attachSound("gameover");
	theSounds.levelcompleted = new Sound(_local1);
	theSounds.levelcompleted.attachSound("levelcompleted");
	theSounds.pickup = new Sound(_local1);
	theSounds.pickup.attachSound("pickup");
	theSounds.deliver = new Sound(_local1);
	theSounds.deliver.attachSound("deliver");
	theSounds.thrust = new Sound(_local1);
	theSounds.thrust.attachSound("thrust");
	theSounds.door = new Sound(_local1);
	theSounds.door.attachSound("door");
	theSounds.door.onSoundComplete = function()
	{
		theSounds.door.setVolume(100);
	};
}
function turnOffSound()
{
	trace("Turning sound off!!!");
	theSounds.heroshoot.setVolume(0);
}
function initTimer()
{
	timeStarted = getTimer();
}
function updateTimer()
{
	timeSpent = Math.floor((getTimer() - timeStarted) / 1000);
	var _local2 = Math.floor(timeSpent / 60);
	var _local1 = timeSpent - (_local2 * 60);
	if (_local1 < 10)
	{
		_local1 = "0" + _local1;
	}
	var _local3 = (_local2 + ":") + _local1;
	_parent.statusbar.time = _local3;
	lastMessage++;
	if (lastMessage > 450)
	{
		randomMessage("IDLE");
	}
}
function protKillAll()
{
	var _local1 = this;
	var _local2 = _parent;
	_local1.phys.vel.x = 0;
	_local1.phys.vel.y = 0;
	_local1.phys.acc = 0;
	_local1.phys.rotVel = 0;
	_local2.statusbar.light0.gotoAndStop("greenoff");
	_local2.statusbar.light1.gotoAndStop("greenoff");
	_local2.statusbar.light2.gotoAndStop("greenoff");
	theSounds.thrust.stop("thrust");
	thrusting = false;
}


function o_enemyPhys(rot)
{
	var _local1 = this;
	_local1.rot = rot;
}
function o_savedRoom(enemys, crates, triggers)
{
	var _local1 = this;
	_local1.enemys = new Array();
	_local1.crates = new Array();
	_local1.triggers = new Array();
}
function o_savedEnemy(state, hitpoints, type)
{
	var _local1 = this;
	_local1.state = state;
	_local1.hitpoints = hitpoints;
	_local1.type = type;
}
function o_door(state)
{
	this.state = 0;
}
function o_sounds(heroshoot, bullethitter, explode, gameover, levelcompleted, pickup, deliver, thrust, door)
{
	var _local1 = this;
	_local1.heroshoot = heroshoot;
	_local1.bullethitter = bullethitter;
	_local1.explode = explode;
	_local1.gameover = gameover;
	_local1.levelcompleted = levelcompleted;
	_local1.pickup = pickup;
	_local1.deliver = deliver;
	_local1.thrust = thrust;
	_local1.door = door;
}
function distPoints(x1, y1, x2, y2)
{
	var _local3 = (x1 - x2) * (x1 - x2);
	var _local1 = (y1 - y2) * (y1 - y2);
	var _local2 = Math.sqrt(_local3 + _local1);
	return (_local2);
	return (_local3);
}
function normalizeV(x, y)
{
	var r = new Vector();
	var dis = Math.sqrt(x * x + y * y);
	r.x = x / dis;
	r.y = y / dis;
	return r;
}
function normalV(v)
{
	result = new Vector();
	result.X = v.Y;
	result.Y = -v.X;
	return (result);
}
function dotV(Avec, Bvec)
{
	result = (Avec.X * Avec.Y) + (Bvec.X * Bvec.Y);
	return (result);
}
function crossV(Avec, Bvec)
{
}
function subtractV(Avec, Bvec)
{
	Result = new O_vector();
	Result.x = Avec.x - Bvec.x;
	Result.y = Avec.y - Bvec.y;
	return (Result);
}
function addV(Avec, Bvec)
{
	Result = new O_vector();
	Result.x = Avec.x + Bvec.x;
	Result.y = Avec.y + Bvec.y;
	return (Result);
}
function lengthV(v)
{
	var _local1 = v;
	var _local2 = Math.sqrt((_local1.x * _local1.x) + (_local1.y * _local1.y));
	return (_local2);
}
trace("main : " + this);
trace("2d math loaded");
//}