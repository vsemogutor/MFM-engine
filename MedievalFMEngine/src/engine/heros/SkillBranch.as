package engine.heros
{
	public final class SkillBranch
	{
		private var _skills:Vector.<Skill> = new Vector.<Skill>();
		
		private var _head:SkillTreeNode; 
		public var name:String;
		
		public function get head():SkillTreeNode{
			return _head;
		}		
		
		public function get skills():Vector.<Skill>{
			return _skills;
		}
		
		public function add(skill:Skill, parent:Skill = null):void
		{
			if (find(skill))
				return;
			
			_skills.push(skill);
			
			var parentNode:SkillTreeNode = find(parent);
			var newNode:SkillTreeNode = new SkillTreeNode(skill, parentNode);
			if (parentNode)
			{
				parentNode.children.push(newNode);
			}
			else
			{
				_head = newNode;
			}
		}
		
		public function find(skill:Skill):SkillTreeNode
		{
			if (_head == null)
				return null;
				
			return findInternal(skill, _head);
		}
		
		public function findInternal(skill:Skill, parent:SkillTreeNode):SkillTreeNode
		{
			if (parent.value == skill)
			{
				return parent;
			}
			else
			{
				for (var i:int = 0; i < parent.children.length; ++i)
				{
					var node:SkillTreeNode = findInternal(skill, parent.children[i]);
					if (node) return node;
				}
			}
			
			return null;
		}
		
		public function get maxDepth():int
		{
			if (_head == null)
				return 0;
			
			return getMaxDepthInternal(_head, 0);
		}
		
		private function getMaxDepthInternal(parent:SkillTreeNode, curDepth:int):int
		{
			var depth:int = curDepth;
			
			for (var i:int = 0; i < parent.children.length; ++i)
			{
				var newDepth:int = getMaxDepthInternal(parent.children[i], curDepth);
				if (newDepth > depth)
					depth = newDepth;
			}
			
			return depth + 1;
		}		
	}
}