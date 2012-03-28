package  {
	
	/*
	this is the class that you create your war bot in
	
	Add your own disclaimer here...
	
	Created by lnsiu for Kirupa battle. v1 - 1
	Free for all usage
	*/
	
	public class lnsiu_AIBot_03 
	{
		
		//POSITION
		//these are the variables for your x and y position, do not touch these,
		public var myx:Number;
		public var myy:Number;
		
		//MOTION
		//these are the variables for your x and y move, max 1 unit allowed in each direction, 
		public var movex:Number = 0;
		public var movey:Number = 0;
		
		//ENERGY
		//this is the amount of energy you have
		public var myEnergy:Number;
		
		//FIRE
		//fire variables, fire one bullet  cost 10 units, one hit makes damages for 200 units on opponent.
		public var doFire:Boolean = false;
		public var fireDirX:Number;
		public var fireDirY:Number;
		public var refire:Number;
		public var reloadCountDown:Number;
		
		//SKINNING
		//add your color and name for your Bot
		public var skinColor:String = "0xcc0000";
		public var botName:String = "mrPink";
		
		//OPPONENTS, all opponents except oneself
		public var botArray:Array = new Array();
		
		//ENERGYSTORAGES ie FOOD
		public var foodArray:Array = new Array();
		
		// constructor code
		public function lnsiu_AIBot_03() {
			//nothing here yet...
		}
		
		//all botlogic will be updated from this function.
		public function updateBot():void
		{
			myAiFunc();
		}
		
		//=== vvv code your implementation below vvv
		
		private var counter:Number = 0;
		private var easeInCirc:Array = [0,0,0.001,0.001,0.001,0.002,0.002,0.003,0.004,0.005,0.006,0.007,0.008,0.009,0.01,0.012,0.013,0.015,0.016,0.018,0.02,0.022,0.024,0.026,0.029,0.031,0.033,0.036,0.039,0.042,0.045,0.048,0.051,0.054,0.058,0.062,0.065,0.069,0.074,0.078,0.082,0.087,0.091,0.096,0.101,0.107,0.112,0.117,0.123,0.128,0.133,0.139,0.144,0.15,0.157,0.163,0.169,0.176,0.183,0.19,0.198,0.205,0.213,0.221,0.229,0.238,0.247,0.256,0.265,0.275,0.285,0.295,0.305,0.316,0.327,0.339,0.351,0.363,0.376,0.389,0.402,0.416,0.43,0.445,0.459,0.474,0.489,0.505,0.523,0.541,0.561,0.582,0.605,0.63,0.658,0.689,0.724,0.764,0.814,0.88];

		private var circCounter:Number = 0;
		private var dir:Number = 1;
		private var oldpos:Array = [0,0];
		
		private function myAiFunc():void
		{
			
			var fireRand:Number = Math.random();
			
			if(fireRand<0.90)
			{
				
				//trace(botArray);
				var botIndex:Number = findClosestBot();
				
				var botDistance:Number = pointDistance(myx,botArray[botIndex].x, myy, botArray[botIndex].y);
				if(botDistance>200)
				{
					doFire = false;
				}
				else if(myEnergy<150)
				{
					doFire = true;	
				}
				else
				{
					doFire = true;
				}
				
				var oldvelx:Number = (botArray[botIndex].x - oldpos[0]);
				var oldvely:Number = (botArray[botIndex].y - oldpos[1]);
				
				
				var fireSpread:Number = botDistance/10;
				fireDirX = botArray[botIndex].x + 10*oldvelx + (Math.random()-Math.random())*fireSpread;
				fireDirY = botArray[botIndex].y + 10*oldvely + (Math.random()-Math.random())*fireSpread;
				
				oldpos = [botArray[botIndex].x,botArray[botIndex].y];
				
			}
			else
			{
				doFire = false;
			}
			
			if (foodArray.length != 0) 
				{
				var dist:Number = 1;
				
				var closestfoodIndex:Number = 0;
				var closestfood:Number = 1000;
				
				for (var i:int = 0; i < foodArray.length; i++) 
				{
					var distance:Number = pointDistance(myx, foodArray[i].x , myy, foodArray[i].y);
					if(distance < closestfood)
					{
						closestfoodIndex = i;
						closestfood = distance;
					}
				}
				
				//move maximum distance.
				var x1:Number = foodArray[closestfoodIndex].x;
				var y1:Number = foodArray[closestfoodIndex].y;
				
				//closestfood
				movex = 1.4*(x1 -myx)/closestfood;
				movey = 1.4*(y1 -myy)/closestfood;
				
			}
			else
			{ 
				//no food, do stupid stuff
				if(circCounter == easeInCirc.length)
				{
					circCounter = 0;
					dir *=-1;
				}
				movex = dir * (easeInCirc[circCounter]);
				movey = dir * (1 - easeInCirc[circCounter]);
				circCounter++;
			}
			
		}
		
		private function findClosestBot():Number
		{
			if(botArray.length == 1)
			{
				//trace("only one bot alive to kill");
				return(0);
			}
			else
			{
				var closestDist:Number = 1000;
				var botIndex:Number = 0;
				for (var i:int = 0; i < botArray.length; i++) 
				{
					var dist:Number = pointDistance(myx, botArray[i].x, myy, botArray[i].y);
					if(dist<closestDist)
					{
						closestDist = dist;
						botIndex = i;
					}
				}
				return(botIndex);
			}
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
	}
}
