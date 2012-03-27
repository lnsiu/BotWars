package  {
	
	/*
	This is the "bot wars arena" Class that updates the bots
	
	Created by lnsiu for Kirupa battle. v1 - 1, 
	
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
		//var theFrameRate:Number 	= 60;
		public var theStageWidth:Number 	= 500;
		public var theStageHeight:Number 	= 500;
		public var loopCounter:Number = 0;
		
		//Gamesettings
		public var fireCost:Number 	= 15;
		public var damageCost:Number = 150;
		public var foodDamageCost:Number = 25;
		public var maxTotalmove:Number = 2;		
		
		//Food settings
		public var initialFood:Number = 10000;
		public var placeFoodAfterNmbFrames:Number = 200;
		public var foodEnergyValue:Number = 1000;
		public var foodArray:Array = new Array();
				
		//Bots
		public var botClassRef:Array = [new lnsiu_AIBot_01(),new lnsiu_AIBot_02()];
		public var displayBots:Array = new Array(botClassRef.length);
		public var offsetInitBotPlacement:Number = 10;
		public var startPositions:Array = [[offsetInitBotPlacement,offsetInitBotPlacement],[theStageWidth-offsetInitBotPlacement,theStageHeight-offsetInitBotPlacement]];
		
		//bullets
		public var reloadCount:Number = 10;
		public var bulletsArr:Array = new Array();
		
		
		public function FlashBots():void
		{
			// constructor code
			initBots();
			foodArray[foodArray.length] = placeFood(theStageWidth/2,theStageHeight/2);
			
			//activate onEnterLoop and
			this.addEventListener(Event.ENTER_FRAME,bulletTime);
		}
		
		private function bulletTime(e:Event):void 
		{
			//for fairness reason, reverse the botClass array
			botClassRef.reverse();
			displayBots.reverse();
			
			//update each update function
			for(var i:uint = 0; i< botClassRef.length; i++)
			{
				//update each bot ai
				botClassRef[i].updateBot();
				
				//check if allowed to fire
				if(botClassRef[i].reloadCountDown <= 0)
				{
					
					//fire bullets
					if(botClassRef[i].doFire && botClassRef[i].myEnergy >= 10)
					{
						botClassRef[i].myEnergy -= fireCost;
							
						var orgx:Number = botClassRef[i].myx;
						var orgy:Number = botClassRef[i].myy;
						var dirx:Number = botClassRef[i].fireDirX;
						var diry:Number = botClassRef[i].fireDirY;
						var bullet:MovieClip = bulletsArr[bulletsArr.length] = fireBullet(orgx, orgy, dirx, diry);
						
						//add name flag for bots to distinguis between their own and hostile bullets
						bullet.nameflag = botClassRef[i].botName;
						
						//fast forward bullet outside mc
						bullet.x += Math.cos(bullet.rotation)*12;
						bullet.y += Math.sin(bullet.rotation)*12;
						
						botClassRef[i].reloadCountDown = reloadCount;
					}
				}else{
					botClassRef[i].reloadCountDown -=1;
				}
				
				//move bots
				var movebotx:Number = botClassRef[i].movex;
				var moveboty:Number = botClassRef[i].movey;
				//var moveDist:Number = Math.abs(movebotx)+Math.abs(moveboty);
				
				var theDist:Number = pointDistance(displayBots[i].x,displayBots[i].x + movebotx,displayBots[i].y, displayBots[i].y + moveboty);
				trace(theDist);
				if(theDist <=2 && botClassRef[i].myEnergy > theDist)
				{
					botClassRef[i].myx += movebotx;
					botClassRef[i].myy += moveboty;
				}
				
				//check bounds and move a bot to stage if he is wondering of
				checkBotArenaBounds(botClassRef[i]);
				
				//update foodArray in bot
				botClassRef[i].foodArray = foodArray
				
				//remove move energy
				botClassRef[i].myEnergy -= theDist;
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
		
		private function updateAllBullets():void
		{
			for (var i:int = 0; i < bulletsArr.length; i++) 
			{
				var bulletArrRef:MovieClip = bulletsArr[i];
				
				for (var j:int = 0; j < 5; j++) 
				{
					bulletArrRef.x += Math.cos(bulletArrRef.rotation)*0.5;
					bulletArrRef.y += Math.sin(bulletArrRef.rotation)*0.5;
					
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
							foodArray[i2].foodEnergy -= damageCost;
							
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
					
				}
				
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
					trace("removed bullet");
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
				if(botClassRef[i].myEnergy < 0)
				{
					//atleast one is dead
					//terminate loop
					
					removeEventListener(Event.ENTER_FRAME,bulletTime);
					
					//announce score
					var scoreString:String = "Game Over!\n";
					for (var j:int = 0; j < botClassRef.length; j++) 
					{
						scoreString += botClassRef[j].botName + " - energy left: " + Math.round(botClassRef[j].myEnergy) + "\n";
					}
					createScreenText(scoreString);
					return;					
				}
			}
			
		}

		private function createScreenText(theString:String):void
		{
			var myText:TextField = new TextField();
			myText.multiline = true;
			myText.text = theString;
			myText.x = 10;
			myText.y = 10;
			myText.width = myText.textWidth + 10; 
			addChild(myText);
		}
		
		private function fireBullet(orgx:Number,orgy:Number,dirx:Number, diry:Number):MovieClip
		{
			//create bullet
			var bullet:MovieClip = filledCircle("0x000000",1);
			addChild(bullet);
			
			bullet.x = orgx;
			bullet.y = orgy;
			
			var rot:Number = Math.atan2( orgy - diry, orgx - dirx) / Math.PI * 180 -90;
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
