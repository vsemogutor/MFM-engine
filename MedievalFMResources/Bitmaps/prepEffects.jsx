var folder = Folder.current;

if (!folder.exists)  {
	throw new Error ("Wrong folder");
}

var files = folder.getFiles ("*.png");
if (files.length == 0) {
	throw new Error ("Empty folder");
}

RegExp.global = true;
RegExp.ignoreCase = true;
var regex = new RegExp ("spriteEffect(.*)_.*_.*");

var file = new File("effectsDefinitions.txt");
file.open("w");
		
var objectsClass = "\tpublic class EffectTypesRepository\r\n"
						+ "\t\{\r\n";

var initMethod = "\t\tpublic function init(game:Game, typesRepository:TypesRepository):void {\r\n";

for (var i = 0; i < files.length; ++i) {	 
	var names = files[i].name.match(regex);
		
	try {
			if (names) {
				var name = names[1];
				var typeName = "Effect" + name;
				initMethod += "\t\t\t" + name + " = new SpecialEffectType();\r\n";
				initMethod += "\t\t\t" + name + ".name = \"" + typeName + "\";\r\n";
				initMethod += "\t\t\t" + name + ".model = game.spriteRepository.getByName(\"" + typeName + "\");\r\n";	
				if (name == "UnitDeath") {
					initMethod += "\t\t\tgame.effectManager.addEffectType(" + name +  ", SpecialEffects.Death);\r\n\r\n";
				} else {
					initMethod += "\t\t\tgame.effectManager.addEffectType(" + name +  ");\r\n\r\n";	
				}
				
				objectsClass += "\t\tpublic var " + name + ":SpecialEffectType;\r\n";
			}
	} catch (error) {
		alert(error);
	}
}

initMethod += "\t\t\}\r\n";
objectsClass += "\r\n" + initMethod;
objectsClass += "\t}";

file.write(objectsClass);
file.close();
alert("done");