package  {
	
	/*
	this is the class that you create your war bot in
	
	Add your own disclaimer here...
	
	Created by lnsiu for Kirupa battle. v1 - 1
	Free for all usage
	*/
	
	public class lnsiu_AIBot_02 
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
		public var skinColor:String = "0x00cc00";
		public var botName:String = "mrGreen";
		
		//OPPONENTS, all opponents except oneself
		public var botArray:Array = new Array();
		
		//ENERGYSTORAGES ie FOOD
		public var foodArray:Array = new Array();
		
		// constructor code
		public function lnsiu_AIBot_02() {
			//nothing here yet...
		}
		
		//all botlogic will be updated from this function.
		public function updateBot():void
		{
			myAiFunc();
		}
		
		//=== vvv code your implementation below vvv
		
		private var counter:Number = 0;
		private var easeInCirc:Array = [0,0.001,0.003,0.006,0.009,0.014,0.02,0.027,0.035,0.045,0.056,0.068,0.082,0.098,0.116,0.133,0.152,0.174,0.198,0.224,0.253,0.285,0.32,0.359,0.402,0.45,0.5,0.561,0.639,0.75];
		private var circCounter:Number  =0;
		private var dir:Number = 1;
		
		private function myAiFunc():void
		{
			
			var fireRand:Number = Math.random();
			
			if(fireRand<0.90)
			{
				doFire = true;
				//trace(botArray);
				var fireSpread:Number = pointDistance(myx,botArray[0].x, myy, botArray[0].y)/4;
				fireDirX = botArray[0].x + (Math.random()-Math.random())*fireSpread;
				fireDirY = botArray[0].y + (Math.random()-Math.random())*fireSpread;
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
			
			
				if(foodArray[closestfoodIndex].x > myx )
				{
					movex = dist;
				}
				else
				{
					movex =-dist;
				}
				
				if(foodArray[closestfoodIndex].y > myy)
				{
					movey = dist;
				}
				else
				{
					movey = -dist;
				}
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
