﻿class Main extends MovieClip
{
	var hero:OShip;
	var bullets:Array;
	var startTime:Number = 0;
	var endTime:Number = 0;
	var gameState;
	var arena;
	var _quality;
	var GRAVITY:Number = -0.15;
	var enemyTypeProperties:EnemyTypeProperties;
	var level:Number = 0;
	var dropCrateOK:Boolean = false;
	var savedRooms:Array = [];
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
		this.enemyTypeProperties = new EnemyTypeProperties();

		this.hero.initMC(arena.heroholder);
		trace("Creating bullets");
		hero.initBullets(arena);
		bullets = hero.bullets;

		initSound();
		level = 1;
		dropCrateOK = true;
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
		savedRooms = new Array();
		var t = 1;
		while (t <= nbLevels)
		{
			firstTimeInRoom[t] = true;
			savedRooms[t] = new OSavedRoom();
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

		_global.arena = arena;
		_global.theSounds = theSounds;
	}

	function initLevel(newLevel)
	{
		trace("Next level");
		this.level = newLevel;
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
				trace("found platform" + t)
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
		if (!firstTimeInRoom[level])
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
			if ((savedRooms[6].enemys[0].state != 0) && (triggers[2] == 1))
			{
				triggers[3] = 0;
				doors[3].state = 1;
				arena.arenahit.door3.gotoAndStop("open");
				savedRooms[6].enemys[0].state = 2;
				if (savedRooms[6].enemys[1].state != 0)
				{
					savedRooms[6].enemys[1].state = 2;
				}
				if (savedRooms[6].enemys[2].state != 0)
				{
					savedRooms[6].enemys[2].state = 2;
				}
				if (savedRooms[6].enemys[3].state != 0)
				{
					savedRooms[6].enemys[3].state = 2;
				}
				if (savedRooms[6].enemys[4].state != 0)
				{
					savedRooms[6].enemys[4].state = 2;
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
					enemy.type = savedRooms[level].enemy.type;
				}
				else
				{
					enemy.type = arena.enemys[level][t];
					trace("initEnemys"+enemy.type +"_____"+arena.enemys[level][t])
				}
				trace("Initialising enemy number " + t + ". Type = \"" + enemy.type + "\"");
				var tt = 0;
				var prop:OEnemyTypeProperties;
				while (tt < this.enemyTypeProperties.counts)
				{
					prop = this.enemyTypeProperties.getPropertie(tt);
					if (prop.type == enemy.type)
					{
						enemy.typeID = tt;
						enemy.setProp(prop);
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
		this.hero.update(level, triggers, GRAVITY);
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

			if (hero.mc.center.hitTest(arena.changelevel0))
			{
				changeLevel(3);
			}
			else if (hero.mc.center.hitTest(arena.changelevel1))
			{
				changeLevel(1);
			}
		}
		else if (level == 3)
		{
			if (hero.mc.center.hitTest(arena.changelevel0))
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
				if (hero.mc.center.hitTest(arena.changelevel0))
				{
					changeLevel(1);
				}
			}
		}
	}
	function changeLevel(newLevel)
	{
		trace("Level was : " + level);
		trace("Level is now : " + newLevel);

		localposX = (hero.phys.pos.x + arena.offsetX[level]) - arena.offsetX[newLevel];
		localposY = (hero.phys.pos.y + arena.offsetY[level]) - arena.offsetY[newLevel];

		trace("offsetX " + level + "   " + arena.offsetX[level])
		trace("offsetY " + level + "   " + arena.offsetY[level])

		trace("offsetX " + newLevel + "   " + arena.offsetX[newLevel])
		trace("offsetY " + newLevel + "   " + arena.offsetY[newLevel])

		trace(localposX+":"+localposY)

		exitLevel();
		initLevel(newLevel);
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
										savedRooms[level].crates[tt] = 0;
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
								hero.score = hero.score + this.enemyTypeProperties.getPropertie(enemys[j].typeID).points;
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
				enemy.fireEnemyBullets(0,hero);
			}
			i++;
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

	function setAcc(phys:OPhys, val:Number):Void
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

	function setrotvel(phys:OPhys, val:Number):Void
	{
		phys.rotVel = val;
	}

	function fireHeroBullets()
	{
		if (hero.powerup == "DOUBLESHOT")
		{
			hero.fireOne(2,0);
			hero.fireOne(3,0);
		}
		else if (hero.powerup == "BACKFIRE")
		{
			hero.fireOne(0,0);
			hero.fireOne(1,180);
		}
		else
		{
			hero.fireOne(0,0);
		}
		theSounds.heroshoot.start();
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
				savedRooms[2].enemys[0].state = 1;
				savedRooms[2].enemys[1].state = 1;
				savedRooms[2].enemys[2].state = 1;
				savedRooms[2].enemys[3].state = 1;
				savedRooms[2].enemys[4].state = 1;
				savedRooms[2].enemys[5].state = 1;
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
		var savedRoom:OSavedRoom = this.savedRooms[roomID];
		trace("Saving room state");
		savedRoom.save(this.enemys);
	}
	function loadRoomState(roomID:Number)
	{
		var roomI:Number = roomID;
		trace("Loading room state");
		var i:Number = 0;
		var enemy:OEnemy;
		var _savedRoom:OSavedRoom;
		while (i < enemys.length)
		{
			_savedRoom = this.savedRooms[roomI];
			enemy = enemys[i];
			enemy.load(_savedRoom.getSavedEnemy(i));
			i++;
		}
		i = 0;
		while (i < nbCrates)
		{
			_savedRoom = savedRooms[roomI];
			if (_savedRoom.crates[i] == 0)
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
		theSounds = new o_sounds(this);
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

}