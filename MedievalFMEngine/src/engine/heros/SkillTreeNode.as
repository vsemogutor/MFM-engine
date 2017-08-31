package engine.heros
{
	import __AS3__.vec.Vector;
	
	public final class SkillTreeNode
	{
		public var value:Skill;
		public var parent:SkillTreeNode;
		public var children:Vector.<SkillTreeNode> = new Vector.<SkillTreeNode>();
		
		public function SkillTreeNode(value:Skill = null, parent:SkillTreeNode = null)
		{
			this.value = value;
			this.parent = parent;
		}
	}
}