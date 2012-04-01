package  {
	
	/*
	this is the class that you create your war bot in
	
	Add your own disclaimer here...
	
	Created by lnsiu for Kirupa battle. v1 - 1
	Free for all usage
	
	
	PiggyBack bot will try to conserve energy, go so close that it can't be hurt by the opponents bullets, 
	and if there are other oppenents. Let the "piggy" take the fall. If the Piggy has an advantage to reach food. Shot the food. 
	*/
	
	public class lnsiu_AIBot_04 
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
		public var skinColor:String = "0xdc00b0";
		public var botName:String = "mrPiggyBack";
		
		//OPPONENTS
		public var botArray:Array = new Array();
		
		//ENERGYSTORAGES ie FOOD
		public var foodArray:Array = new Array();
		
		// constructor code
		public function lnsiu_AIBot_04() {
			//nothing here yet...
		}
		
		//all botlogic will be updated from this function.
		public function updateBot():void
		{
			myAiFunc();
		}
		
		//=== vvv code your implementation below vvv
		
		private function myAiFunc():void
		{
			
			//BOT motion
			var botIndex:Array = findClosestBot();
			
			//get coordinates closests bot
			var x1:Number = botArray[botIndex[0]].x;
			var y1:Number = botArray[botIndex[0]].y;
			
			//closest bot
			movex = 1.4*(x1 -myx)/botIndex[1];
			movey = 1.4*(y1 -myy)/botIndex[1];
			
			//BOT fire
			if (foodArray.length != 0) 
			{
				//there is food. shot it.
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
				//fire half the time
				doFire = !doFire;
				
				fireDirX = foodArray[closestfoodIndex].x;
				fireDirY = foodArray[closestfoodIndex].y;
			}else{
				doFire = false;
			}
		}
		
		private function findClosestBot():Array
		{
			//this function returns the index in botarray for closest bot and the closests dist
			
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
			return([botIndex,closestDist]);
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
