package common
{
	import engine.game.Game;
	import engine.objects.ObjectType;
	
	public class ObjectsRepository
	{
		public var Banner1:ObjectType;
		public var Banner2:ObjectType;		
		public var Barrel:ObjectType;
		public var Basket1:ObjectType;
		public var Bush1:ObjectType;
		public var Bush2:ObjectType;
		public var Bush3:ObjectType;
		public var Bush4:ObjectType;
		public var Bush5:ObjectType;
		public var Bush6:ObjectType;
		public var Bush7:ObjectType;
		public var Bush8:ObjectType;
		public var BushEmpty2:ObjectType;
		public var Chest1:ObjectType;
		public var Claudron1:ObjectType;
		public var Column1:ObjectType;
		public var Crate1:ObjectType;
		public var Crystal1:ObjectType;
		public var Crystal2:ObjectType;
		public var Crystal4:ObjectType;
		public var FirePlace1:ObjectType;
		public var Flowers1:ObjectType;
		public var Flowers2:ObjectType;
		public var Flowers3:ObjectType;
		public var Flowers4:ObjectType;
		public var Grain1:ObjectType;
		public var Grass1:ObjectType;
		public var HeyStack:ObjectType;
		public var IronWagon:ObjectType;
		public var LampPost:ObjectType;
		public var LandCircle:ObjectType;
		public var PostSign:ObjectType;
		public var Ruin2:ObjectType;
		public var Ruin3:ObjectType;
		public var Stone1:ObjectType;
		public var Stone2:ObjectType;
		public var Stone3:ObjectType;
		public var Stone4:ObjectType;
		public var Stone5:ObjectType;
		public var Tree1:ObjectType;
		public var Tree2:ObjectType;
		public var Tree3:ObjectType;
		public var Tree4:ObjectType;
		public var Tree5:ObjectType;
		public var Tree6:ObjectType;
		public var Tree7:ObjectType;
		public var Tree8:ObjectType;
		public var TreeBurned1:ObjectType;
		public var TreeCut:ObjectType;
		public var TreeEmpty1:ObjectType;
		public var TreeEmpty2:ObjectType;
		public var TreeEmpty3:ObjectType;
		public var TreeFur1:ObjectType;
		public var TreeFur2:ObjectType;
		public var TreeFur3:ObjectType;
		public var TreeFur4:ObjectType;
		public var TreeFur5:ObjectType;
		public var WaterPlant1:ObjectType;
		public var Well1:ObjectType;
		public var WoodStack:ObjectType;
		public var WoodWagon:ObjectType;
		public var LandVar1:ObjectType;
		public var LandVar2:ObjectType;		
		public var LandVar3:ObjectType;
		public var LandVar4:ObjectType;	
		public var LandVar1Green:ObjectType;
		public var LandVar2Green:ObjectType;		
				
		public function init():void {
			var game:Game = Game.instance();

			Banner1 = new ObjectType();
			Banner1.name = "ObjectBanner1";
			Banner1.model = game.spriteRepository.getByName("ObjectBanner1");
			game.objectManager.addObjectType(Banner1);

			Barrel = new ObjectType();
			Barrel.name = "ObjectBarrel";
			Barrel.model = game.spriteRepository.getByName("ObjectBarrel");
			game.objectManager.addObjectType(Barrel);

			Basket1 = new ObjectType();
			Basket1.name = "ObjectBasket1";
			Basket1.model = game.spriteRepository.getByName("ObjectBasket1");
			game.objectManager.addObjectType(Basket1);

			Bush1 = new ObjectType();
			Bush1.name = "ObjectBush1";
			Bush1.model = game.spriteRepository.getByName("ObjectBush1");
			game.objectManager.addObjectType(Bush1);

			Bush2 = new ObjectType();
			Bush2.name = "ObjectBush2";
			Bush2.model = game.spriteRepository.getByName("ObjectBush2");
			game.objectManager.addObjectType(Bush2);

			Bush3 = new ObjectType();
			Bush3.name = "ObjectBush3";
			Bush3.model = game.spriteRepository.getByName("ObjectBush3");
			game.objectManager.addObjectType(Bush3);

			Bush4 = new ObjectType();
			Bush4.name = "ObjectBush4";
			Bush4.model = game.spriteRepository.getByName("ObjectBush4");
			game.objectManager.addObjectType(Bush4);

			Bush5 = new ObjectType();
			Bush5.name = "ObjectBush5";
			Bush5.model = game.spriteRepository.getByName("ObjectBush5");
			game.objectManager.addObjectType(Bush5);

			Bush6 = new ObjectType();
			Bush6.name = "ObjectBush6";
			Bush6.model = game.spriteRepository.getByName("ObjectBush6");
			game.objectManager.addObjectType(Bush6);

			Bush7 = new ObjectType();
			Bush7.name = "ObjectBush7";
			Bush7.model = game.spriteRepository.getByName("ObjectBush7");
			game.objectManager.addObjectType(Bush7);

			Bush8 = new ObjectType();
			Bush8.name = "ObjectBush8";
			Bush8.model = game.spriteRepository.getByName("ObjectBush8");
			game.objectManager.addObjectType(Bush8);

			BushEmpty2 = new ObjectType();
			BushEmpty2.name = "ObjectBushEmpty2";
			BushEmpty2.model = game.spriteRepository.getByName("ObjectBushEmpty2");
			game.objectManager.addObjectType(BushEmpty2);

			Chest1 = new ObjectType();
			Chest1.name = "ObjectChest1";
			Chest1.model = game.spriteRepository.getByName("ObjectChest1");
			game.objectManager.addObjectType(Chest1);

			Claudron1 = new ObjectType();
			Claudron1.name = "ObjectClaudron1";
			Claudron1.model = game.spriteRepository.getByName("ObjectClaudron1");
			game.objectManager.addObjectType(Claudron1);

			Column1 = new ObjectType();
			Column1.name = "ObjectColumn1";
			Column1.model = game.spriteRepository.getByName("ObjectColumn1");
			game.objectManager.addObjectType(Column1);

			Crate1 = new ObjectType();
			Crate1.name = "ObjectCrate1";
			Crate1.model = game.spriteRepository.getByName("ObjectCrate1");
			game.objectManager.addObjectType(Crate1);

			Crystal1 = new ObjectType();
			Crystal1.name = "ObjectCrystal1";
			Crystal1.model = game.spriteRepository.getByName("ObjectCrystal1");
			game.objectManager.addObjectType(Crystal1);

			Crystal2 = new ObjectType();
			Crystal2.name = "ObjectCrystal2";
			Crystal2.model = game.spriteRepository.getByName("ObjectCrystal2");
			game.objectManager.addObjectType(Crystal2);

			Crystal4 = new ObjectType();
			Crystal4.name = "ObjectCrystal4";
			Crystal4.model = game.spriteRepository.getByName("ObjectCrystal4");
			game.objectManager.addObjectType(Crystal4);

			FirePlace1 = new ObjectType();
			FirePlace1.name = "ObjectFirePlace1";
			FirePlace1.model = game.spriteRepository.getByName("ObjectFirePlace1");
			game.objectManager.addObjectType(FirePlace1);

			Flowers1 = new ObjectType();
			Flowers1.name = "ObjectFlowers1";
			Flowers1.model = game.spriteRepository.getByName("ObjectFlowers1");
			game.objectManager.addObjectType(Flowers1);

			Flowers2 = new ObjectType();
			Flowers2.name = "ObjectFlowers2";
			Flowers2.model = game.spriteRepository.getByName("ObjectFlowers2");
			game.objectManager.addObjectType(Flowers2);

			Flowers3 = new ObjectType();
			Flowers3.name = "ObjectFlowers3";
			Flowers3.model = game.spriteRepository.getByName("ObjectFlowers3");
			Flowers3.xLength = 2;
			game.objectManager.addObjectType(Flowers3);		
			
			Flowers4 = new ObjectType();
			Flowers4.name = "ObjectFlowers4";
			Flowers4.model = game.spriteRepository.getByName("ObjectFlowers4");
			Flowers4.yLength = 2;
			game.objectManager.addObjectType(Flowers4);

			Grain1 = new ObjectType();
			Grain1.name = "ObjectGrain1";
			Grain1.model = game.spriteRepository.getByName("ObjectGrain1");
			game.objectManager.addObjectType(Grain1);

			Grass1 = new ObjectType();
			Grass1.name = "ObjectGrass1";
			Grass1.model = game.spriteRepository.getByName("ObjectGrass1");
			game.objectManager.addObjectType(Grass1);

			HeyStack = new ObjectType();
			HeyStack.name = "ObjectHeyStack";
			HeyStack.model = game.spriteRepository.getByName("ObjectHeyStack");
			game.objectManager.addObjectType(HeyStack);

			IronWagon = new ObjectType();
			IronWagon.name = "ObjectIronWagon";
			IronWagon.model = game.spriteRepository.getByName("ObjectIronWagon");
			game.objectManager.addObjectType(IronWagon);

			LampPost = new ObjectType();
			LampPost.name = "ObjectLampPost";
			LampPost.model = game.spriteRepository.getByName("ObjectLampPost");
			game.objectManager.addObjectType(LampPost);

			LandCircle = new ObjectType();
			LandCircle.name = "ObjectLandCircle";
			LandCircle.model = game.spriteRepository.getByName("ObjectLandCircle");
			LandCircle.xLength = 3;
			LandCircle.yLength = 3;
			LandCircle.passable = true;
			game.objectManager.addObjectType(LandCircle);

			PostSign = new ObjectType();
			PostSign.name = "ObjectPostSign";
			PostSign.model = game.spriteRepository.getByName("ObjectPostSign");
			game.objectManager.addObjectType(PostSign);

			Ruin2 = new ObjectType();
			Ruin2.name = "ObjectRuin2";
			Ruin2.xLength = 2;
			Ruin2.yLength = 2;			
			Ruin2.model = game.spriteRepository.getByName("ObjectRuin2");
			game.objectManager.addObjectType(Ruin2);

			Ruin3 = new ObjectType();
			Ruin3.name = "ObjectRuin3";			
			Ruin3.model = game.spriteRepository.getByName("ObjectRuin3");
			game.objectManager.addObjectType(Ruin3);

			Stone1 = new ObjectType();
			Stone1.name = "ObjectStone1";
			Stone1.model = game.spriteRepository.getByName("ObjectStone1");
			game.objectManager.addObjectType(Stone1);

			Stone2 = new ObjectType();
			Stone2.name = "ObjectStone2";
			Stone2.model = game.spriteRepository.getByName("ObjectStone2");
			game.objectManager.addObjectType(Stone2);

			Stone3 = new ObjectType();
			Stone3.name = "ObjectStone3";
			Stone3.model = game.spriteRepository.getByName("ObjectStone3");
			game.objectManager.addObjectType(Stone3);

			Stone4 = new ObjectType();
			Stone4.name = "ObjectStone4";
			Stone4.model = game.spriteRepository.getByName("ObjectStone4");
			game.objectManager.addObjectType(Stone4);

			Stone5 = new ObjectType();
			Stone5.name = "ObjectStone5";
			Stone5.model = game.spriteRepository.getByName("ObjectStone5");
			game.objectManager.addObjectType(Stone5);

			Tree1 = new ObjectType();
			Tree1.name = "ObjectTree1";
			Tree1.model = game.spriteRepository.getByName("ObjectTree1");
			game.objectManager.addObjectType(Tree1);

			Tree2 = new ObjectType();
			Tree2.name = "ObjectTree2";
			Tree2.model = game.spriteRepository.getByName("ObjectTree2");
			game.objectManager.addObjectType(Tree2);

			Tree3 = new ObjectType();
			Tree3.name = "ObjectTree3";
			Tree3.model = game.spriteRepository.getByName("ObjectTree3");
			game.objectManager.addObjectType(Tree3);

			Tree4 = new ObjectType();
			Tree4.name = "ObjectTree4";
			Tree4.model = game.spriteRepository.getByName("ObjectTree4");
			game.objectManager.addObjectType(Tree4);

			Tree5 = new ObjectType();
			Tree5.name = "ObjectTree5";
			Tree5.model = game.spriteRepository.getByName("ObjectTree5");
			game.objectManager.addObjectType(Tree5);

			Tree6 = new ObjectType();
			Tree6.name = "ObjectTree6";
			Tree6.model = game.spriteRepository.getByName("ObjectTree6");
			game.objectManager.addObjectType(Tree6);

			Tree7 = new ObjectType();
			Tree7.name = "ObjectTree7";
			Tree7.model = game.spriteRepository.getByName("ObjectTree7");
			game.objectManager.addObjectType(Tree7);

			Tree8 = new ObjectType();
			Tree8.name = "ObjectTree8";
			Tree8.model = game.spriteRepository.getByName("ObjectTree8");
			game.objectManager.addObjectType(Tree8);

			TreeBurned1 = new ObjectType();
			TreeBurned1.name = "ObjectTreeBurned1";
			TreeBurned1.model = game.spriteRepository.getByName("ObjectTreeBurned1");
			game.objectManager.addObjectType(TreeBurned1);

			TreeCut = new ObjectType();
			TreeCut.name = "ObjectTreeCut";
			TreeCut.model = game.spriteRepository.getByName("ObjectTreeCut");
			game.objectManager.addObjectType(TreeCut);

			TreeEmpty1 = new ObjectType();
			TreeEmpty1.name = "ObjectTreeEmpty1";
			TreeEmpty1.model = game.spriteRepository.getByName("ObjectTreeEmpty1");
			game.objectManager.addObjectType(TreeEmpty1);

			TreeEmpty2 = new ObjectType();
			TreeEmpty2.name = "ObjectTreeEmpty2";
			TreeEmpty2.model = game.spriteRepository.getByName("ObjectTreeEmpty2");
			game.objectManager.addObjectType(TreeEmpty2);

			TreeEmpty3 = new ObjectType();
			TreeEmpty3.name = "ObjectTreeEmpty3";
			TreeEmpty3.model = game.spriteRepository.getByName("ObjectTreeEmpty3");
			game.objectManager.addObjectType(TreeEmpty3);

			TreeFur1 = new ObjectType();
			TreeFur1.name = "ObjectTreeFur1";
			TreeFur1.model = game.spriteRepository.getByName("ObjectTreeFur1");
			game.objectManager.addObjectType(TreeFur1);

			TreeFur2 = new ObjectType();
			TreeFur2.name = "ObjectTreeFur2";
			TreeFur2.model = game.spriteRepository.getByName("ObjectTreeFur2");
			game.objectManager.addObjectType(TreeFur2);

			TreeFur3 = new ObjectType();
			TreeFur3.name = "ObjectTreeFur3";
			TreeFur3.model = game.spriteRepository.getByName("ObjectTreeFur3");
			game.objectManager.addObjectType(TreeFur3);

			TreeFur4 = new ObjectType();
			TreeFur4.name = "ObjectTreeFur4";
			TreeFur4.model = game.spriteRepository.getByName("ObjectTreeFur4");
			game.objectManager.addObjectType(TreeFur4);

			TreeFur5 = new ObjectType();
			TreeFur5.name = "ObjectTreeFur5";
			TreeFur5.model = game.spriteRepository.getByName("ObjectTreeFur5");
			game.objectManager.addObjectType(TreeFur5);

			WaterPlant1 = new ObjectType();
			WaterPlant1.name = "ObjectWaterPlant1";
			WaterPlant1.model = game.spriteRepository.getByName("ObjectWaterPlant1");
			game.objectManager.addObjectType(WaterPlant1);

			Well1 = new ObjectType();
			Well1.name = "ObjectWell1";
			Well1.model = game.spriteRepository.getByName("ObjectWell1");
			game.objectManager.addObjectType(Well1);

			WoodStack = new ObjectType();
			WoodStack.name = "ObjectWoodStack";
			WoodStack.model = game.spriteRepository.getByName("ObjectWoodStack");
			WoodStack.xLength = 2;
			game.objectManager.addObjectType(WoodStack);

			WoodWagon = new ObjectType();
			WoodWagon.name = "ObjectWoodWagon";
			WoodWagon.model = game.spriteRepository.getByName("ObjectWoodWagon");
			game.objectManager.addObjectType(WoodWagon);

			LandVar1 = new ObjectType();
			LandVar1.name = "ObjectLandVar1";
			LandVar1.passable = true;
			LandVar1.model = game.spriteRepository.getByName("ObjectLandVar1");
			game.objectManager.addObjectType(LandVar1);

			LandVar2 = new ObjectType();
			LandVar2.name = "ObjectLandVar2";
			LandVar2.passable = true;
			LandVar2.model = game.spriteRepository.getByName("ObjectLandVar2");
			game.objectManager.addObjectType(LandVar2);
			
			LandVar3 = new ObjectType();
			LandVar3.name = "ObjectLandVar3";
			LandVar3.passable = true;
			LandVar3.model = game.spriteRepository.getByName("ObjectLandVar3");
			game.objectManager.addObjectType(LandVar3);

			LandVar4 = new ObjectType();
			LandVar4.name = "ObjectLandVar4";
			LandVar4.passable = true;
			LandVar4.model = game.spriteRepository.getByName("ObjectLandVar4");
			game.objectManager.addObjectType(LandVar4);	
			
			LandVar1Green = new ObjectType();
			LandVar1Green.name = "ObjectLandVar1Green";
			LandVar1Green.passable = true;
			LandVar1Green.model = game.spriteRepository.getByName("ObjectLandVar1Green");
			game.objectManager.addObjectType(LandVar1Green);

			LandVar2Green = new ObjectType();
			LandVar2Green.name = "ObjectLandVar2Green";
			LandVar2Green.passable = true;
			LandVar2Green.model = game.spriteRepository.getByName("ObjectLandVar2Green");
			game.objectManager.addObjectType(LandVar2Green);
			
			Banner2 = new ObjectType();
			Banner2.name = "ObjectBannerBlue";
			Banner2.model = game.spriteRepository.getByName("ObjectBannerBlue");
			game.objectManager.addObjectType(Banner2);								
		}
	}
}