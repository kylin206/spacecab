class Main extends MovieClip
{
	var hero:OShip;
	var bullets:Array;
	var startTime:Number = 0;
	var endTime:Number = 0;
	var gameState;
	var arena;
	var _quality;
	var GRAVITY:Number = -0.15;
	var enemyTypeProperties:Array;
	var level:Number = 0;
	var bulletNB:Number = 0;
	var dropCrateOK:Boolean = false;
	var savedRoom:Array = [];
	var doors:Array = [];
	var triggers:Array = [];
	var enemys:Array = [];
	var heroSin:Number = 0;
	var heroCos:Number = 0;
	var firstTimeInRoom = [];
	var gameSuccess = false;
	var nbLevels = 0;
	var nbCratesAll = 0;
	var cratesLeft = 0;
	var cratesDelivered = 0;
	var scoreMultiplier = 1;
	var tmpPlatform;
	var localposX:Number = 0;
	var localposY:Number = 0;
	var NBcrates:Number = 0;
	var NBplatforms:Number = 0;
	var NBpowerups:Number = 0;
	var NBcratesAll:Number = 0;
	var enemy;
	var wasHit;
	var theSounds;
	var thrusting;
	var autofireCount;
	var FIREOK;
	var rot;
	var timeSpent;
	var camX;
	var camY;
	var lastMessage;
	var nbCrates;
	var timeStarted;
	var state;
	var messagecontrol;

	function Main()
	{
		trace(0);
		this.loadLevels();
	}

	function onEnterFrame()
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
	}
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
		var etp0:OEnemyTypeProperties = new OEnemyTypeProperties();
		var etp1:OEnemyTypeProperties = new OEnemyTypeProperties();
		var etp2:OEnemyTypeProperties = new OEnemyTypeProperties();
		var etp3:OEnemyTypeProperties = new OEnemyTypeProperties();
		var etp4:OEnemyTypeProperties = new OEnemyTypeProperties();
		var etp5:OEnemyTypeProperties = new OEnemyTypeProperties();
		var etp6:OEnemyTypeProperties = new OEnemyTypeProperties();
		var etp7:OEnemyTypeProperties = new OEnemyTypeProperties();
		enemyTypeProperties.push(etp0);
		enemyTypeProperties.push(etp1);
		enemyTypeProperties.push(etp2);
		enemyTypeProperties.push(etp3);
		enemyTypeProperties.push(etp4);
		enemyTypeProperties.push(etp5);
		enemyTypeProperties.push(etp6);
		enemyTypeProperties.push(etp7);
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
		
		hero.mc = arena.heroholder;
		hero.mc.exhaust._visible = false;
		trace("Creating bullets");
		hero.initBullets(arena);
		bullets = hero.bullets;
		
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
			savedRoom[t] = new OSavedRoom();
			t++;
		}
		doors = new Array();
		var t = 0;
		while (t < 5)
		{
			doors[t] = new ODoor();
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
			var tmpPlatform = this.arena["platform" + t];

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
			var tmpCrate = this.arena["crate" + t];
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
			var tmpPowerup = this.arena["powerup" + t];
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
				var tmpDoor:MovieClip = this.arena.arenahit["door" + t];
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
		this._clearHeroBullets();
		this._clearEnemyBullets();
	}

	function _clearHeroBullets():Void
	{
		hero.clearBullets();
	}

	function _clearEnemyBullets():Void
	{
		var i:Number = 0;
		while (i < this.enemys.length)
		{
			this.enemys[i].clearBullets();
			i++;
		}
	}

	function initEnemys()
	{
		enemys = new Array();
		var t:Number = 0;
		var enemy:OEnemy;
		while (t < 999)
		{
			var tmpEnemy:MovieClip = this.arena["enemy" + t];
			if (typeof (tmpEnemy) == "undefined")
			{
				break;
			}
			else
			{
				enemy = new OEnemy(tmpEnemy);
				enemys[t] = enemy;
				enemy.id = t;
				if (!firstTimeInRoom[level])
				{
					enemy.type = savedRoom[level].enemy.type;
				}
				else
				{
					enemy.type = arena.enemys[level][t];
					trace("initEnemys"+enemy.type +"_____"+arena.enemys[level][t])
				}
				trace("Initialising enemy number " + t + ". Type = \"" + enemy.type + "\"");
				var tt = 0;
				while (tt < enemyTypeProperties.length)
				{
					if (enemyTypeProperties[tt].type == enemy.type)
					{
						enemy.typeID = tt;
						enemy.setProp(enemyTypeProperties[tt]);
						break;
					}
					tt++;
				}
			}
			t++;
		}
		t = 0;
		while (t < enemys.length)
		{
			trace("Creating bullets for enemy number " + t);
			enemy = enemys[t];
			enemy.initBullets(arena);
			t++;
		}
	}
	function updateHero()
	{
		this.hero.update(arena, level, triggers, GRAVITY);
		this.heroCos = this.hero.heroCos;
		this.heroSin = this.hero.heroSin;
	}
	function checkLevelchange()
	{
		if (level == 1)
		{
			if (hero.mc.center.hitTest(arena.changelevel0))
			{
				changeLevel(6);
			}
			else if (hero.mc.center.hitTest(arena.changelevel1))
			{
				changeLevel(2);
			}
			else if (hero.mc.center.hitTest(arena.changelevel2))
			{
				changeLevel(4);
			}
			else if (hero.mc.center.hitTest(arena.changelevel3))
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
			//if (doors[3].state == 1)
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
			var tmpHitpoint = hero.mc["hit" + t];
			hero.hitpoints[t].x = tmpHitpoint._x;
			hero.hitpoints[t].y = tmpHitpoint._y;
			hero.mc.localToGlobal(hero.hitpoints[t]);
			t++;
		}

		if (hero.state == "FLYING")
		{
			var t = 0;
			var tmpCrate;
			while (t < NBplatforms)
			{
				tmpPlatform = this.arena["platform" + t];
				if (hero.mc.hull.hitTest(tmpPlatform))
				{
					//小角度自动校正
					//if ((hero.mc._rotation >= -10) && (hero.mc._rotation <= 10))
					if ((hero.mc._rotation >= -40) && (hero.mc._rotation <= 40))
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
									tmpCrate = this.arena["crate" + tt];
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
									var tmpPowerup = this.arena["powerup" + tt];
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
						if (enemys[tt].mc.hitTest(hero.hitpoints[t].x, hero.hitpoints[t].y, true))
						{
							wasHit = true;
						}
					}
					tt++;
				}
				if (arena.arenahit.hitTest(hero.hitpoints[t].x, hero.hitpoints[t].y, true))
				{
					wasHit = true;
				}
				t++;
			}
			if (wasHit)
			{
				//撞墙
				//heroDie();
				hero.phys.vel.x *=-1;//撞墙不死反弹
				hero.phys.vel.y *=-1;
			}
		}
	}
	function checkHeroBulletsHit()
	{
		var i:Number = 0;
		while (i < hero.nbBullets)
		{
			if (bullets[i].state == 1)
			{
				bullets[i].screenPos.x = bullets[i].pos.x;
				bullets[i].screenPos.y = -bullets[i].pos.y;
				arena.localToGlobal(bullets[i].screenPos);
				var j = 0;
				while (j < enemys.length)
				{
					if (enemys[j].state != 0)
					{
						if (enemys[j].mc.hitTest(bullets[i].screenPos.x, bullets[i].screenPos.y, true) == true)
						{
							bullets[i].state = 0;
							bullets[i].mc.play();
							if (enemys[j].state == 1)
							{
								enemys[j].hitpoints--;
								
								
								trace("hp:"+enemys[j].hitpoints)
							}
							if (enemys[j].hitpoints <= 0)
							{
								enemys[j].state = 0;
								enemys[j].mc.stop();
								enemys[j].mc.ship.gotoAndPlay("explode");
								hero.score = hero.score + enemyTypeProperties[enemys[j].typeID].points;
								_parent.statusbar.score = hero.score;
								randomMessage("SHOOTENEMY");
								if ((level == 6) && (j == 0))
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
					j++;
				}
				if (arena.arenahit.hitTest(bullets[i].screenPos.x, bullets[i].screenPos.y, true) == true)
				{
					bullets[i].state = 0;
					bullets[i].mc.play();
				}
			}
			i++;
		}
	}
	function checkEnemyBulletsHit()
	{
		var i:Number = 0;
		var bullet:OBullet;
		while (i < enemys.length)
		{
			var j:Number = 0;
			while (j < enemys[i].nbBullets)
			{
				bullet = enemys[i].bullets[j];
				if (bullet.state == 1)
				{
					bullet.screenPos.x = bullet.pos.x;
					bullet.screenPos.y = -bullet.pos.y;
					arena.localToGlobal(bullet.screenPos);
					//打到墙壁
					if (arena.arenahit.hitTest(bullet.screenPos.x, bullet.screenPos.y, true))
					{
						bullet.state = 0;
						bullet.mc.play();
					}
					//打到主角
					else if (hero.mc.hull.hitTest(bullet.screenPos.x, bullet.screenPos.y, true))
					{
						if (hero.state != "DYING")
						{
							bullet.state = 0;
							bullet.mc.play();
							//heroDie();//测试屏蔽不怕子弹
						}
					}
				}
				j++;
			}
			i++;
		}
	}
	//卸货
	function unloadCrates()
	{
		hero.state = "UNLOADING";
		var crateIndex:Number = 0;
		if (crateIndex < hero.cargo.length)
		{
			if (dropCrateOK == true)
			{
				var tmpDropCrate = this.arena["dropcrate" + crateIndex];
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
		var i:Number = 0;
		var bullet:OBullet;
		while (i < hero.nbBullets)
		{
			bullet = bullets[i];
			bullet.update();
			i++;
		}
	}
	function checkEnemyFire()
	{
		var i:Number = 0;
		var enemy:OEnemy;
		while (i < enemys.length)
		{
			enemy = this.enemys[i];
			if (enemy.checkFire())
			{
				this.fireEnemyBullets(enemy,0);
			}
			i++;
		}
	}
	function fireEnemyBullets($enemy, gunID)
	{
		var enemy:OEnemy = $enemy;
		if (enemy.bulletI >= (enemy.nbBullets - 1))
		{
			enemy.bulletI = 0;
		}
		else
		{
			enemy.bulletI++;
		}
		var _local3 = new Vector(0, 0);
		_local3.x = enemy.mc.ship.bulletpoint0._x;
		_local3.y = enemy.mc.ship.bulletpoint0._y;
		enemy.mc.ship.localToGlobal(_local3);
		arena.globalToLocal(_local3);
		enemy.bullets[enemy.bulletI].pos.x = _local3.x;
		enemy.bullets[enemy.bulletI].pos.y = -_local3.y;

		if (enemy.type == "SEEDPOD")
		{
			var randDegree:Number = ((Math.random() * 90) - 45);
			var aimCos:Number = Math.cos((enemy.phys.rot - 90 + randDegree) * Math.PI / 180);
			var aimSin:Number = -Math.sin((enemy.phys.rot - 90 + randDegree) * Math.PI / 180);
			enemy.bullets[enemy.bulletI].vel.x = aimCos * enemy.propertie.bulletVel;
			enemy.bullets[enemy.bulletI].vel.y = aimSin * enemy.propertie.bulletVel;
		}
		else if (enemy.propertie.accuracy < 0)
		{
			var vec:Vector = new Vector();
			vec.x = hero.phys.pos.x - enemy.bullets[enemy.bulletI].pos.x;
			vec.y = hero.phys.pos.y - enemy.bullets[enemy.bulletI].pos.y;
			vec.normalize();
			var adjustDegrees = (360 * (enemy.propertie.accuracy + 1));
			adjustDegrees = (Math.random() * adjustDegrees) - (adjustDegrees / 2);
			var aimCos = Math.cos((adjustDegrees * Math.PI) / 180);
			var aimSin = (-Math.sin((adjustDegrees * Math.PI) / 180));
			var newX = ((vec.x * aimCos) + (vec.y * (-aimSin)));
			var newY = ((vec.x * aimSin) + (vec.y * aimCos));
			enemy.bullets[enemy.bulletI].vel.x = newX * enemy.propertie.bulletVel;
			enemy.bullets[enemy.bulletI].vel.y = newY * enemy.propertie.bulletVel;

		}
		else if (enemy.propertie.accuracy >= 0)
		{
			var aimCos = Math.cos(((enemy.propertie.accuracy + enemy.phys.rot - 90) * Math.PI) / 180);
			var aimSin = -Math.sin(((enemy.propertie.accuracy + enemy.phys.rot - 90) * Math.PI) / 180);
			enemy.bullets[enemy.bulletI].vel.x = aimCos * enemy.propertie.bulletVel;
			enemy.bullets[enemy.bulletI].vel.y = aimSin * enemy.propertie.bulletVel;
		}
		enemy.bullets[enemy.bulletI].state = 1;
		enemy.bullets[enemy.bulletI].mc.gotoAndStop(1);
		enemy.bullets[enemy.bulletI].mc._visible = true;

		if (gunID < (enemy.propertie.nbGuns - 1))
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
		var enemy:OEnemy;
		while (i < enemys.length)
		{
			enemy = enemys[i];
			enemy.updateBullets();
			i++;
		}
	}

	function checkKeys()
	{
		var _local1 = _parent;
		if (Key.isDown(Key.UP))
		{
			if (hero.fuel > 0)
			{
				_local1.statusbar.light0.gotoAndStop("greenon");
				if (hero.state == "PARKED")
				{
					hero.phys.acc = 0.5;
				}
				setAcc(hero.phys,1);
				hero.fuel -= 0.01;
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
		if (Key.isDown(39))//right
		{
			_local1.statusbar.light2.gotoAndStop("greenon");
			setrotvel(hero.phys,10);
		}
		else if (Key.isDown(37))//Left
		{
			_local1.statusbar.light1.gotoAndStop("greenon");
			setrotvel(hero.phys,-10);
		}
		else
		{
			setrotvel(hero.phys,0);
		}
		if (!Key.isDown(39))//right
		{
			_local1.statusbar.light2.gotoAndStop("greenoff");
		}
		if (!Key.isDown(37))//! Left
		{
			_local1.statusbar.light1.gotoAndStop("greenoff");
		}
		if (Key.isDown(17) || Key.isDown(32))//Ctrl or Space
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
		if (Key.isDown(81))//Q
		{
			hero.powerup = "AUTOFIRE";
		}
		if (Key.isDown(87))//W
		{
			hero.powerup = "DOUBLESHOT";
		}
		if (Key.isDown(69))//E
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
		theSounds.explode.setVolume(15);
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
			var crateIndex = 0;
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
		this._quality = _parent._parent._parent.dataholder.menuQuality;
	}
	function outroPilot(physObj:OPhys)
	{
		setAcc(physObj,1);
		heroCos = Math.cos((rot - 90) * Math.PI / 180);
		heroSin = -Math.sin((rot - 90) * Math.PI / 180);
		physObj.rot += physObj.rotVel;
		physObj.vel.x *= 0.98;
		physObj.vel.y *= 0.98;
		physObj.vel.x += physObj.acc * heroCos;
		physObj.vel.y += ((physObj.acc * heroSin) + (GRAVITY * ((hero.weight / 2) + 1)));
		physObj.pos.x += physObj.vel.x;
		physObj.pos.y += physObj.vel.y;
		arena.heroholder._x = physObj.pos.x;
		arena.heroholder._y = -physObj.pos.y;
		arena.heroholder._rotation = rot;
		physObj.acc *= 0.9;

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

	function setAcc(phys:OPhys, val)
	{
		phys.acc += (val * 0.06);
		if (phys.acc > phys.maxAcc)
		{
			phys.acc = phys.maxAcc;
		}
		else if (phys.acc < phys.minAcc)
		{
			phys.acc = phys.minAcc;
		}

	}

	function setrotvel(phys:OPhys, val)
	{
		phys.rotVel = val;
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
		if (bulletNB >= (hero.nbBullets - 1))
		{
			bulletNB = 0;
		}
		else
		{
			bulletNB++;
		}
		var tmpGun = this.hero.mc["bulletpoint" + gunID];
		var bullet=bullets[bulletNB];

		bullet.pos.x = (hero.phys.pos.x + (tmpGun._x * heroSin)) + ((-tmpGun._y) * heroCos);
		bullet.pos.y = (hero.phys.pos.y + ((-tmpGun._x) * heroCos)) + ((-tmpGun._y) * heroSin);

		bullet.vel.x = (hero.phys.vel.x / 4) + (10 * heroCos);
		bullet.vel.y = (hero.phys.vel.y / 4) + (10 * heroSin);

		var bulletCos = Math.cos((angle * Math.PI) / 180);
		var bulletSin = (-Math.sin((angle * Math.PI) / 180));

		var NewX:Number = (bullet.vel.x * bulletCos) + (bullet.vel.y * (-bulletSin));
		var NewY:Number = (bullet.vel.x * bulletSin) + (bullet.vel.y * bulletCos);

		bullet.vel.x = NewX;
		bullet.vel.y = NewY;
		bullet.state = 1;
		bullet.mc._visible = true;
	}
	function triggerActivate(triggerID:Number)
	{
		var _local1:Number = triggerID;
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
	function saveRoomState(roomID:Number)
	{
		var roomI:Number = roomID;
		trace("Saving room state");
		var j:Number = 0;
		var savedEnemy:OSavedEnemy;
		var enemy:OEnemy;
		while (j < enemys.length)
		{
			savedEnemy = new OSavedEnemy();
			savedRoom[roomI].enemys[j] = savedEnemy;
			enemy = enemys[j];
			savedEnemy.save(enemy);
			j++;
		}
	}
	function loadRoomState(roomID:Number)
	{
		var roomI:Number = roomID;
		trace("Loading room state");
		var i:Number = 0;
		var enemy:OEnemy;
		while (i < enemys.length)
		{
			enemy = enemys[i];
			enemy.load( savedRoom[roomI].enemys[i]);
			i++;
		}
		i = 0;
		while (i < nbCrates)
		{
			if (savedRoom[roomI].crates[i] == 0)
			{
				this.arena["crate" + i]. _visible = false;
			}
			i++;
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

}