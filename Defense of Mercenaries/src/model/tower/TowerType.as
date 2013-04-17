package model.tower
{
	
	import starling.display.Quad;
	
	public class TowerType
	{
		private var typeName:String;
		private var purchaseCost:int;
		private var upgradeModifier:int;
		private var damage:int;
		private var range:int;
		private var attackFrequency:int;
		private var influenceRange:int;
		private var shape:Quad; //Placeholder graphics variable
		
		public function TowerType(typeName:String, purchaseCost:int, upgradeModifier:int, damage:int, range:int, attackFrequency:int, influenceRange:int, shape:Quad)
		{
			this.typeName = typeName;
			this.purchaseCost = purchaseCost;
			this.upgradeModifier = upgradeModifier;
			this.damage = damage;
			this.range = range;
			this.attackFrequency = attackFrequency;
			this.influenceRange = influenceRange;
			this.shape = shape;
		}
		
		public function getUpgradeModifier():int
		{
			return this.upgradeModifier;
		}
		
		//Placeholder graphics get method
		public function getShape():Quad
		{
			return this.shape;
		}
	}
}