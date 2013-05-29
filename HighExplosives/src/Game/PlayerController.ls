package HighExplosives.Game
{

	import cocos2d.CCPoint;

	import Loom.GameFramework.TickedComponent;
	
	import com.rmc.data.types.GestureManagerOptions;
    import com.rmc.managers.GestureManager;
    import com.rmc.data.types.GestureDelegateData;
    import com.rmc.applications.AbstractLoomDemo;
	
	public class PlayerController extends Controller {
		
  		public var gestureManager:GestureManager;
  		
		public function PlayerController(level_:HiExLevel, e_:DynamicEntity, gestureManager_:GestureManager) 
		{
			super(level_, e_);
			
			gestureManager = gestureManager_;
			gestureManager.onGestureSwipe += onGestureSwipe;
			gestureManager.onGestureDoubleTap += onGestureDoubleTap;
		}
		
		override public function update() 
		{
		}
	
		
        public function onGestureSwipe(data:GestureDelegateData)
        {
			var point:CCPoint = data.positionDelta.deltaPoint;
			Console.print ("swipe: " + "(" + point.x + "," + point.y + ")");
        }
        
        public function onGestureDoubleTap(data:GestureDelegateData)
        {
			var point:CCPoint = data.positionDelta.toPoint;
			Console.print ("tap: " + "(" + point.x + "," + point.y + ")");
			e.setTarget(point.x, point.y);
        }
        
	}

}