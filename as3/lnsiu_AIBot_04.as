package  {
	
	/*
	this is the class that you create your war bot in
	
	Add your own disclaimer here...
	
	Created by lnsiu for Kirupa battle. v1 - 1
	Free for all usage
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
			
			
			doFire = true;
			fireDirX = botArray[0].x;
			fireDirY = botArray[0].y;
			
			//trace("updating");
			if (foodArray.length != 0) 
			{
				if(foodArray[0].x > myx )
				{
					movex =1;
				}
				else
				{
					movex =-1;
				}
				
				if(foodArray[0].y > myy)
				{
					movey = 1;
				}
				else
				{
					movey = -1;
				}
			}
			else
			{
				movex = Math.random()-Math.random();
				movey = Math.random()-Math.random();
			}
			
		}
		
	}
	
}
