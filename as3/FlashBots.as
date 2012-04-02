package  {
	
	/*
	This is the "bot wars arena" Class that updates the bots
	
	Created by lnsiu for Kirupa battle. v1 - 1,
	http://www.kirupa.com/forum/showthread.php?371555-BOT-wars!
	
	/lnsiu 2012
	
	mmmmmmmNNNNmdddddhhhhhhhhhyhdmNNNNNNNNNNNNNNmdhhhdddddhhhhhhddmNNNmmmmNNNNNmmdhhhdhhhhhhhhhhhddmmNNNNNNNNNNNmdysyyyyyyyhhhhyyhmNNNNNNNNNmmNmmhysyyyyyyyyyysyydmNNNNNNNNNNNNmdhysyyyyyyyyyysyhmNNNmmdysoo
	mmmNN+//////:::::/ohhhhhhhhhdmmms+/----/+ymNNmdhhhhh:--------:::////dNNNNNNNNmmdhhhhhhhyyhhhhhdmNNNh////+NNNm::---ohhy+----/yydmNNNNNm//////+mdyysyyyyyyy:----://///++smNNNNNmhyyyo/:-....-/odmNNNNmhsss
	NNNNN.             .yhhhhhhddh:            :dNmdhyyh                yNNNNNNNNNNmhyhhhhhyyyyyyhdmmNNm     mNN:     `yyy`    +yyyhmNNNN:       smdyssyyyyyy`              sNNNNNmhy.     `     .hmNNNmdhyy
	NNNNN.    /dmdy`    /hhhhhhhs     :oyyo:     hNmdyyy//++/.    `++ossmNNNNNNNNNNNdhyyhhyyyhyyyyyhdmNN/    sNh       :yo    `yyysyhmNNs    `    dmhyssyyyyy`    -yhdh:     NNNNNNm/    `sys`  ``:mNNNNmmdd
	mmmNN.    -sss+    -yhhhhhhh`    :NNNNNN/    .NNmdhyyyyyh:    `yhdmNNNNNNNNNNNNNmmhyhhyyyyyyyyyhhmNNd    `N.   `    s-    /yyyyyyhmd    .d    .mmhysyyyyy`    -syhy:    .NNNNNNNy      ..:/+syyhdNNNNmmm
	hhhdm.            .+yhhhhhhh     smNNNNNy     mNNNmhyyyyy:    `yyhdmNNNNNNdddddddmmhyyyyyyyyyyyyyhdNN:    +    d.   -    `yyyyyysyh.    yN/    /Nmdhysyyy`            `+mNNNNmNNNy/`         .oyhdmNNNmm
	hhyyy`    -syyy+    `yhhhhhh`    +hdmNNNo    `mNNNmdhyyyy:    `yyyhdmNNNNN       NNmhyyyyyyyyyyyyyydmh        /Ny        :yyyyyyyy:    `hhy     yNNdhsyyy`    .:.    -hNNNNNNmmmNNmds+/:-`     sshmNNNNm
	hhyyy`    :hdmms     ohhyyyy/     +hdmNy     +mmmmNmmdhyy:    `yyyyhdmNNNN-------NNNmhyyyyyyyyyyyyyyhm.       mNN.       syyyyyyy+              `mNNmhysy`    :yy/     +NNNNNmmd```  oysyo     +syhmNNNN
	dhhhd.              -ddhhhyyy/      ``      +mmmNNNNNNdhy:    `yyyyhhdmNNNNNNNNNNNNNNmdhyyyyyyyyyyyyyho      +mmNh      -yyyyyyys`    -/////.    -NNNmhyy`    :yyy+     :mNNNNNN+     .--`    -yyyyhdmNN
	ddhhh.          `.:sNNmdhhhhyys/-`      `:omNNNNNNNNNNNdh:    `yyyyyhhdmmNNNNNNNNNNNNNNdhyyyyyyyyyyyyyh`    `mmNNN:     yyyyyyyy.    `ydNNNNh     oNNNmdy`    :yyyyo`    -mNNNmmmy/.       `:oyyyyyyyhdm
	hhyyyyhhdddmmmNNNNNNNNNNdhhhhhhhhhhsssshdNNNNNNNNNNmmmNNmhhyyyyyyyyyhhhhhmmNNNNNNNNNNNNmdhyyyyyyyyyyyyyhdmNNmmmNNNNNNNNNdhysyyyyyyyyyyshdNNNNNNNNNNNNNNmdyysyyyyyyyysyhdmNNNNNmmNNNNNmdhssyyyyyyyyyyyyyy
	hhyyyyyssyhdmNNNNNNNNNNNNdhyhhhhhhhhhyyyhdmNNNNNNNmmmmNNNmmhyyyyyyyyyyyyydmNNNNmNNNNNNNNmdhyyyyyyyyyyyyyhdmNmmmmNNNNNNNNmdysyyyyyyyyyysyhmNNNmmmmmmNNNNNmdhsyyyyyyyyyyyhmNNNNNNNNNNNNNNmdhyyyyyyyyyyyyyy
	
	*/
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.*;
	import flash.utils.*;
	
	//import lnsiu_AIBot_01.*;
		
	//set stageSize and framerate
	[SWF(backgroundColor="0xCCCCCC" , width="500" , height="500", frameRate="60", pageTitle="BotWars")]
	
	public class FlashBots extends MovieClip {
		
		//Stage
		public var theStageWidth:Number 	= 500;
		public var theStageHeight:Number 	= 500;
		public var loopCounter:Number = 0;
		
		//Gamesettings
		public var fireCost:Number 	= 15;
		public var damageCost:Number = 150;
		public var foodDamageCost:Number = 35;
		public var maxTotalmove:Number = 2;		
		
		//Food settings
		public var initialFood:Number = 10000;
		public var placeFoodAfterNmbFrames:Number = 200;
		public var foodEnergyValue:Number = 1000;
		public var foodArray:Array = new Array();
				
		//Bots
		public var botClassRef:Array = [new lnsiu_AIBot_01(),new lnsiu_AIBot_02(),new lnsiu_AIBot_03(),new lnsiu_AIBot_04()];
		//public var botClassRef:Array = [new lnsiu_AIBot_04(),new lnsiu_AIBot_03()];
		public var displayBots:Array = new Array(botClassRef.length);
		public var offsetInitBotPlacement:Number = 10;
		public var startPositions:Array = [
			[offsetInitBotPlacement,offsetInitBotPlacement],
			[theStageWidth-offsetInitBotPlacement,theStageHeight-offsetInitBotPlacement],
			[offsetInitBotPlacement, theStageHeight-offsetInitBotPlacement],
			[theStageWidth-offsetInitBotPlacement, offsetInitBotPlacement]
		];
		
		//bullets
		public var reloadCount:Number = 10;
		public var bulletsArr:Array = new Array();
		
		//user interface
		public var screenText:TextField = new TextField();
		
		//timers
		public var updateTimeStamp:int;// = getTimer();
		//updateTimeStamp.start();
		
		
		public function FlashBots():void
		{
			//trace("FlashBots called")
			//set Arena color
			stage.color = 0xe8e8e8;
			// constructor code
			initBots();
			createScreenText();
			foodArray[foodArray.length] = placeFood(theStageWidth/2,theStageHeight/2);
			
			//activate onEnterLoop and
			this.addEventListener(Event.ENTER_FRAME,bulletTime);
		}
		
		private function bulletTime(e:Event):void 
		{
			//for fairness reason, rotate the botClass array, needs to be rotated if more than two players
			rotateArray([botClassRef,displayBots]);
			
			//update each update function
			for(var i:uint = 0; i< botClassRef.length; i++)
			{
				var botRef:Object = botClassRef[i];
				
				updateBot(botRef);
				
				//check if allowed to fire
				if(botRef.reloadCountDown <= 0)
				{
					
					//fire bullets
					if(botRef.doFire && botRef.myEnergy >= 10)
					{
						botRef.myEnergy -= fireCost;
							
						var orgx:Number = botRef.myx;
						var orgy:Number = botRef.myy;
						var dirx:Number = botRef.fireDirX;
						var diry:Number = botRef.fireDirY;
						var bullet:MovieClip = bulletsArr[bulletsArr.length] = fireBullet(orgx, orgy, dirx, diry);
						
						//add name flag for bots to distinguis between their own and hostile bullets
						bullet.nameflag = botRef.botName;
						
						//fast forward bullet outside mc
						bullet.x += Math.cos(bullet.rotation)*12;
						bullet.y += Math.sin(bullet.rotation)*12;
						
						botRef.reloadCountDown = reloadCount;
					}
				}else{
					botRef.reloadCountDown -=1;
				}
				
				//move bots
				var movebotx:Number = botRef.movex;
				var moveboty:Number = botRef.movey;
				//var moveDist:Number = Math.abs(movebotx)+Math.abs(moveboty);
				
				var theDist:Number = pointDistance(displayBots[i].x,displayBots[i].x + movebotx,displayBots[i].y, displayBots[i].y + moveboty);
				//trace(theDist);
				if(theDist <=2 && botRef.myEnergy > theDist)
				{
					botRef.myx += movebotx;
					botRef.myy += moveboty;
				}
				
				//check bounds and move a bot to stage if he is wondering of
				checkBotArenaBounds(botRef);
				
				//update foodArray in bot
				botRef.foodArray = foodArray
				
				//remove move energy
				botRef.myEnergy -= theDist;
			}
			
			
			updateDisplay();
			
			loopCounter++;
			if(loopCounter >= placeFoodAfterNmbFrames)
			{
				placeFood(Math.random()*theStageWidth,Math.random()*theStageHeight);
				loopCounter =0;
			}
			
			//update all bullets.
			updateAllBullets();
			
			//check if someone is dead, name winner
			checkIfSomeoneIsDead();
			
			//check if food is found
			checkIfFoodFound();
		}
		
		private function updateBot(botRef:Object):void
		{
			//update each bot ai
			//wrapp the update and take the execution cost into account.
			//the purpose of this is to equal out long exectuion time from short and promote code that execute fast.
			updateTimeStamp = getTimer();
			
			botRef.updateBot();
			
			var timeDiff:Number = getTimer() - updateTimeStamp;
			botRef.myEnergy -= timeDiff/10;
		}
		
		private function updateAllBullets():void
		{
			for (var i:int = 0; i < bulletsArr.length; i++) 
			{
				var bulletArrRef:MovieClip = bulletsArr[i];
				
				
				//for (var j:int = 0; j < 1; j++) 
				//{
					bulletArrRef.x += Math.cos(bulletArrRef.rotation)*2.5;
					bulletArrRef.y += Math.sin(bulletArrRef.rotation)*2.5;
					
					//check if bullet hits bot
					for (var k:int = 0; k < displayBots.length; k++) 
					{
						if(bulletArrRef.hitTestObject(displayBots[k]))
						{
							botClassRef[k].myEnergy -= damageCost;
							
							//remove bullet
							var bullRef:MovieClip = bulletArrRef;
							bulletsArr.splice(i,1);
							removeChild(bullRef);
							return;
						}
					}
					
					//check if bullet hits food
					for (var i2:int = 0; i2 < foodArray.length; i2++) 
					{
						if(bulletArrRef.hitTestObject(foodArray[i2]))
						{
							foodArray[i2].foodEnergy -= foodDamageCost;
							
							//if food is zero, remove food
							if(foodArray[i2].foodEnergy < 0 )
							{
								var foodRef:MovieClip = foodArray[i2];
								foodArray.splice(i2,1);
								removeChild(foodRef);								
							}							
							
							//remove bullet
							var bullRef2:MovieClip = bulletArrRef;
							bulletsArr.splice(i,1);
							removeChild(bullRef2);
							return;
						}
					}
				//}
				
				var removeBull:Boolean = false;
				if(bulletArrRef.x < 0 )
				{
					removeBull = true;
				}
				if(bulletArrRef.y < 0 )
				{
					removeBull = true;
				}
				if(bulletArrRef.x > 500 )
				{
					removeBull = true;
				}
				if(bulletArrRef.y > 500 )
				{
					removeBull = true;
				}
				if(removeBull)
				{
					//trace("removed bullet");
					var buller:MovieClip = bulletArrRef;
					bulletsArr.splice(i,1);
					removeChild(buller);
				}
			}
		}
		
		private function checkIfSomeoneIsDead():void
		{
			
			for (var i:int = 0; i < botClassRef.length; i++) 
			{
				//is someone dead? if not do nothing.
				if(botClassRef[i].myEnergy < 0)
				{
					//atleast one bot is dead
					//who has the lowest score?
					var lowestScore:Number = 0;
					var botIndex:Number = 0;
					for (var k:int = 0; k < botClassRef.length; k++) 
					{
						var energy:Number = botClassRef[k].myEnergy;
						if(energy < lowestScore)
						{
							lowestScore = energy;
							botIndex = k;
						}
					}
					
					//set string for announcing score
					var scoreString:String;
					if(botClassRef.length == 2 )
					{
						scoreString = "Game Over!\n";
					}else{
						scoreString = "One Down!\n";
					}
					
					for (var j:int = 0; j < botClassRef.length; j++) 
					{
						scoreString += botClassRef[j].botName + " - energy left: " + Math.round(botClassRef[j].myEnergy) + "\n";
					}
					
					//announce 
					updateScreenText(scoreString);
					
					//replace dead bot with food and remove from arrays.
					deadBotManagement(botIndex);
										
					//update botlist
					updateBotClassRefBotArray();
					
					//terminate loop if there is only one bot left
					if(botClassRef.length == 1)
					{
						removeEventListener(Event.ENTER_FRAME,bulletTime);
					}					
					
					return;					
				}
			}
		}
		
		private function deadBotManagement(botIndex:Number):void
		{
			//this is part of multiplayer gameplay, not so much one on one.
			//replacing a bot with food wont help in duell mode.
			// so, check if there is more than one bot left i.e array length of three before array elimination
			if(displayBots.length >=3)
			{
				var x:Number = displayBots[botIndex].x;
				var y:Number = displayBots[botIndex].y;
				
				//place food on bot location
				placeFood(x,y);
				
				//remove the dead bot on stage
				removeChild(displayBots[botIndex]);
				
			}
			
			//remove the lowest scoring bot from the display list and the classref list
			displayBots.splice(botIndex, 1);
			botClassRef.splice(botIndex, 1);
			
		}		
		
		private function createScreenText():void
		{
			screenText.multiline = true;
			screenText.x = 10;
			screenText.y = 10;
			addChild(screenText);
		}

		private function updateScreenText(theString:String):void
		{
			screenText.text = theString;			
			screenText.width = screenText.textWidth + 10; 
		}
		
		private function fireBullet(orgx:Number,orgy:Number,dirx:Number, diry:Number):MovieClip
		{
			//create bullet
			var bullet:MovieClip = filledCircle("0x000000",1);
			addChild(bullet);
			
			bullet.x = orgx;
			bullet.y = orgy;
			
			var rot:Number = Math.atan2( orgy - diry, orgx - dirx) / Math.PI * 180 - 90;
			bullet.rotation = (rot - 90)* Math.PI/180;
			
			//bullet manages itself.
			return(bullet);
		}
		
		private function checkIfFoodFound():void
		{
			//compare bots array with food array
			var botslength:Number = displayBots.length;
			var foodlength:Number = foodArray.length;
			
			for(var i:uint = 0; i<botslength; i++)
			{
				for(var j:uint = 0; j< foodlength;j++)
				{
					if(displayBots[i].hitTestObject(foodArray[j]))
					{
						
						var mcRef:MovieClip = foodArray[j];
						foodArray.splice(j,1);
						
						removeChild(mcRef);
						
						//add energy to bot 
						botClassRef[i].myEnergy += foodEnergyValue;
						
						//found food
						return;
					}
				}
			}
		}
		
		private function checkBotArenaBounds(obj:Object):void
		{
			if(obj.myx < 0){ obj.myx = 0;}
			if(obj.myx > theStageWidth){ obj.myx = theStageWidth;}
			if(obj.myy < 0){ obj.myy = 0;}
			if(obj.myy > theStageHeight){ obj.myy = theStageHeight;}
		}
		
		private function rotateArray(Arr:Array):void
		{
			//takes an array of arrays and rotates each array
			for (var i:int = 0; i < Arr.length; i++) 
			{
				var tempval:Object = Arr[i].shift();
				Arr[i].push(tempval);
			}
		}
		
		private function initBots():void
		{
			//Set up bots 
			for(var i:uint = 0; i< botClassRef.length; i++)
			{
				var botRef:Object = botClassRef[i];
				
				// set bots position
				botRef.myx = startPositions[i][0];
				botRef.myy = startPositions[i][1];
				
				//set bots initial energy
				botClassRef[i].myEnergy = initialFood;
				
				//set up firevars 
				botRef.refire = 0;
				botRef.reloadCountDown = reloadCount;
				
				//set displayObject for Bot
				displayBots[i] = filledCircle(botRef.skinColor);
				displayBots[i].x = botRef.myx;
				displayBots[i].y = botRef.myy;
			}
			
			updateBotClassRefBotArray();
		}
		
		private function updateBotClassRefBotArray():void
		{
			//this function updates the botArray of each bot to reflect all opponents
			for (var z:int = 0; z < botClassRef.length; z++) 
			{
				var tempArr:Array = new Array();
				tempArr = [];
				for (var j:int = 0; j < botClassRef.length; j++) 
				{
					if(j != z )
					{
						tempArr[tempArr.length] = displayBots[j];
					}
				}
				
				botClassRef[z].botArray = tempArr;	
			}
		}
		
		private function placeFood(x:Number,y:Number):MovieClip
		{
			var placementx:Number = x;
			var placementy:Number = y;
			var food:MovieClip = filledCircle("0x629632");
			food.x = x;
			food.y = y;
			food.foodEnergy = foodEnergyValue;
			
			//add food to foodArray
			foodArray[foodArray.length] = food;
			
			return(food);
		}
		
		private function pointDistance( x1:Number,x2:Number, y1:Number, y2:Number ):Number
		{
			var xs:Number = 0;
			var ys:Number = 0;
			
			xs = x2 - x1;
			xs = xs * xs;
			
			ys = y2 - y1;
			ys = ys * ys;
			
			return Math.sqrt( xs + ys );
		}
		
		private function updateDisplay():void
		{
			for(var i:uint = 0; i< botClassRef.length; i++)
			{
				displayBots[i].x = botClassRef[i].myx;
				displayBots[i].y = botClassRef[i].myy;
			}
		}
		
		private function filledCircle(SkinColor:String, size:Number=5):MovieClip 
		{
			var circle:MovieClip = new MovieClip();
			circle.graphics.beginFill(uint(SkinColor));
			circle.graphics.drawCircle(0, 0, size);
			circle.graphics.endFill();
			addChild(circle);
			return(circle);
		}
	}
}
