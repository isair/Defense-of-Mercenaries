package model.filter
{
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Program3D;
	
	import starling.filters.FragmentFilter;
	import starling.textures.Texture;

	public class NormalMapFilter extends FragmentFilter
	{
		private var shader:Program3D;
		private var normalMap:Texture;
		private var lightPosition:Vector.<Number> = new <Number>[0, 0, 10, 1];
		private var lightColor:Vector.<Number> = new <Number>[1, 1, 1, 1];
		
		public function NormalMapFilter(normalMap:Texture)
		{
			super();
			this.normalMap = normalMap;
		}
		
		public override function dispose():void
		{
			if (shader) shader.dispose();
			
			super.dispose();
		}
		
		protected override function createPrograms():void
		{
			shader = assembleAgal("tex ft0, v0, fs0 <2d, linear, nomip>\n" +
								  "tex ft1, v0, fs1 <2d, linear, nomip>\n" +
								  "mov ft2.x, fc1.w\n" +
								  "add ft2.x, ft2.x, ft2.x\n" +
								  "mul ft1, ft1, ft2.x\n" +
								  "sub ft1, ft1, fc1.www\n" +
								  "nrm ft1.xyz, ft1.xyz\n" +
								  "mov ft2.z, ft1.w\n" +
								  "sub ft2.xy, fc0.xy, v0.xy s\n" +
								  "mov ft2.xy, fc0.xy\n" +
								  "dp3 ft2.w, ft2.xyz, ft1.xyz\n" +
								  "mul ft1.xyz, ft2.www, ft0.xyz\n" +
								  "mul ft1.xyz, ft1.xyz, fc1.xyz\n" +
								  "mov oc, ft1");
		}
		
		protected override function activate(pass:int, context:Context3D, texture:Texture):void
		{
			context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, lightPosition);
			context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 1, lightColor);
			context.setTextureAt(1, normalMap.base);
			context.setProgram(shader);
		}
		
		protected override function deactivate(pass:int, context:Context3D, texture:Texture):void
		{
			context.setTextureAt(1, null);
		}
		
		public function sendLightPosition(x:Number, y:Number):void
		{
			lightPosition[0] = x;
			lightPosition[1] = y;
		}
		
		public function sendLightColor(r:Number, g:Number, b:Number):void
		{
			lightColor[0] = r;
			lightColor[1] = g;
			lightColor[2] = b;
		}
	}
}