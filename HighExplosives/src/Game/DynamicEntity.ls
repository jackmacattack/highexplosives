package HighExplosives.Game
{
	import Loom.GameFramework.LoomComponent;
	import Loom.GameFramework.TimeManager;
	import Loom.Animation.Tween;
	import Loom.Animation.EaseType;
	
	import cocos2d.CCSprite;
    import cocos2d.*;
    import cocos2d.CCNode;
	
	public class DynamicEntity extends Entity {
   		
   		public static final var TOLERANCE:Number = 4;
   		public static final var ANGULAR_TOLERANCE:Number = Math.PI / 24;
   		public static final var MIN_SPEED:Number = 4;
   		
   		public var moving:boolean = false;
   		public var decel:boolean = false;
   		public var turning:boolean = false;
   		
		//The acceleration index of the entity
		public var accel:Number;
		
		//The agility of the entity 
		public var agility:Number;
		
		//The maximum speed of the entity
		public var maxSpeed:Number;
		
		//The current velocity of the entity
		public var speed:Number;
		
		public var angle:Number;
		
		//The position of the current target
		public var targetX:Number;
		public var targetY:Number;
		
		public function DynamicEntity(level:HiExLevel, x:Number, y:Number, renderer:Renderer, accel_:Number, agility_:Number, maxSpeed_:Number, speed_:Number = 0, angle_:Number = 0)	
		{
			super(level, x, y, renderer);
			accel = accel_;
			agility = agility_;
			maxSpeed = maxSpeed_;
			speed = speed_;
			moving = speed != 0;
			angle = angle_;
		}
		
		public function setTarget(newX:Number, newY:Number)
		{
			targetX = newX; 
			targetY = newY;
			
			decel = true;
			turning = true;
		}
		
		private function distanceToTarget():Number
		{
			return (x-targetX)*(x-targetX)+(y-targetY)*(y-targetY);
		}
		
		public function inRangeOfTarget():boolean 
		{
			return distanceToTarget() <= DynamicEntity.TOLERANCE;
		}
		/*
			Returns true if object2's corners are inside of object1's box
		*/
		public function isCollidingWithDynamic(object_1:DynamicEntity):boolean
		{
			var object_1Box:CCRect=object_1.renderer.sprite.boundingBox();
			var object_2Box:CCRect=this.renderer.sprite.boundingBox();
			
			return object_1Box.intersectsRect(object_2Box);
		}
		
		override public function update(dt:Number) {
			move(dt);
		}
		
		public function move(dt:Number)
		{
			var targetAngle:Number = Utils.calculateAngle(targetX, targetY, x, y);
			
			if(turning) {
				if(Math.abs(targetAngle - angle) > Math.PI) {
					targetAngle -= 2 * Math.PI;
				}
				var snap:boolean = false;
				
				if(!moving) {
					snap = true;
				}
				else {
					angle = angle * (1 - agility) + targetAngle * agility;
					
					if(angle < 0) {
						angle += 2 * Math.PI;
					}
					
					if(Math.abs(angle - targetAngle) < DynamicEntity.ANGULAR_TOLERANCE) {
						snap = true;
					}
				}
				
				if(snap) {
					angle = targetAngle;
					turning = false;
					decel = false;
					moving = true;
					
					renderer.rotation = angle;
				}
			}
			else {
			
				//angle = targetAngle;
				
			}
			
			if(!moving) {
				return;
			}
			
			if(!decel) {
				var check:Number = (speed / (accel + agility - accel * agility) ) * dt;
				decel = distanceToTarget() < check * check;
			}
			
			if(decel) {
				speed = speed * (1 - accel) * (1 - agility);
			}
			else {
				speed = speed * (1 - accel) + maxSpeed * accel;
			}
			
			var dx:Number = speed * Math.cos(angle);
			var dy:Number = speed * Math.sin(angle);
			
			var newX:Number = x + dx * dt;
			var newY:Number = y + dy * dt;
			
			if(!level.isCollidingWithWorld(newX, newY)) {
			 
				setX(newX);
				setY(newY);
				
			}
			else {
			
				targetX = x;
				targetY = y;
			
			}
			
			if(inRangeOfTarget() || speed < DynamicEntity.MIN_SPEED) {
				speed = 0;
				moving = false;
				decel = false;
			}
			
		}
			
	}
	public class MonsterEntity extends DynamicEntity{
		
		public function MonsterEntity(level:HiExLevel, x:Number, y:Number, renderer:Renderer)	
		{
		
			super(level, x, y, renderer, .25, .25, 200, 0, 0);
	
		}
	
	}
	
}
