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
var regex = new RegExp ("spriteObject(.*)_.*_.*");

var file = new File("objectDefinitions.txt");
file.open("w");
		
var objectsClass = "\tpublic class ObjectsRepository\r\n"
						+ "\t\{\r\n";

var initMethod = "\t\tpublic function init():void {\r\n"
						+ "\t\t\tvar game:Game = Game.instance();\r\n\r\n";

for (var i = 0; i < files.length; ++i) {	 
	var names = files[i].name.match(regex);
		
	try {
			if (names) {
				var name = names[1];
				var typeName = "Object" + name;
				initMethod += "\t\t\t" + name + " = new ObjectType();\r\n";
				initMethod += "\t\t\t" + name + ".name = \"" + typeName + "\";\r\n";
				initMethod += "\t\t\t" + name + ".model = game.spriteRepository.getByName(\"" + typeName + "\");\r\n";	
				initMethod += "\t\t\tgame.objectManager.addObjectType(" + name +  ");\r\n\r\n";	
				
				objectsClass += "\t\tpublic var " + name + ":ObjectType;\r\n";
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