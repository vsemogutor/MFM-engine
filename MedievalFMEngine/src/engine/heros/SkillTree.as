package engine.heros
{
	import __AS3__.vec.Vector;
	
	import de.polygonal.ds.HashMap;
	
	import engine.units.UnitType;
	
	public final class SkillTree
	{
		private var _unitTypes:HashMap = new HashMap();
		private var _skillsBranches:Vector.<SkillBranch> = new Vector.<SkillBranch>();		
		
		public function get skillsBranches():Vector.<SkillBranch>{
			return _skillsBranches;
		}
		
		public function getSkillsBranchByName(name:String):SkillBranch{
			for (var i:int = 0; i < _skillsBranches.length; ++i)
			{
				if (_skillsBranches[i].name == name)
					return _skillsBranches[i];
			}
			
			return null;
		}		
		
		public function getTreeForHero(heroType:UnitType):SkillTree
		{
			if (_unitTypes.get(heroType.id) == null)
				_unitTypes.set(heroType.id, new SkillTree());
			
			return _unitTypes.get(heroType.id) as SkillTree;
		}
	}
}