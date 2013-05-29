package
{
    import Loom.GameFramework.*;
    import cocos2d.*;
    import Loom.GameFramework.TimeManager;
    
    import HighExplosives.*;
    
    import HighExplosives.View.*;
   
    import UI.Label;
	
	


    public class HighExplosives extends Cocos2DGame
    {
    
    	[Inject]
    	public var timeManager:TimeManager;
    
        override public function run():void
        {
            
            super.run();
            
        	this.mainMenu(layer);
        	
        }
        
        public function mainMenu(layer:CCScaledLayer)
        {
       		
          	layer.removeAllChildrenWithCleanup (true);
       		
       		 var test:MainMenu = new MainMenu(this);
        	test.start(this.layer);
        
        }
        
        
        public function selectLevel(layer:CCScaledLayer)
        {
        
        
        	layer.removeAllChildrenWithCleanup (true);
        
        	var selectLevelManu:SelectLevelView=new SelectLevelView(this);
        	selectLevelManu.start(this.layer);
        
        }
        /*
        public function otherLayers/levels()
        {
        
        }
        */
        public function gameView(layer:CCScaledLayer, numLevel:int):void
        {
        	layer.removeAllChildrenWithCleanup (true);
        
        	var gameview:GameView=new GameView(this,timeManager);
        	gameview.start(this.layer);
        	
        
        }
        
        	 
    }
}
