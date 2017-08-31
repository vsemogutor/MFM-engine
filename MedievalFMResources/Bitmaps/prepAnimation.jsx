var folder = new Folder("D:\\Projects\\Graphics\\Units");
folder = folder.selectDlg ("Select images folder");

if (!folder.exists)  {
	throw new Error ("Wrong folder");
}

var files = folder.getFiles ("*.png");
if (files.length == 0) {
	throw new Error ("Empty folder");
}


var settings = prompt ("Input width and height separated by space and anim type - (s) (a) (m) (r) (f)", "", "Settings");
var settingsArray = settings.split(" ");
var width = parseInt (settingsArray[0]);
var height = parseInt (settingsArray[1]);
var type = settingsArray[2].toLowerCase();

var action = "Stand";
var docWidth = width;
if (type != "s") {
	docWidth = 15 * width;
	if (type == "a") action = "Attack";
	else if (type == "m") action = "Move";
	else if (type == "r") action = "Move";
	else if (type == "f") action = "Move";
	else throw new Error("Unknown action type");
}

var newDocumentRef = app.documents.add(docWidth+"px", (height*8) + "px", 72.0, "spriteUnit" + action +"_" + width + "_" + height, NewDocumentMode.RGB,  DocumentFill.TRANSPARENT);
setRulers(width);
RegExp.ignoreCase = true;
RegExp.global = true;

var regex;

if (type == "s") regex = new RegExp ("(stopped|steht)+");
else if (type == "m") regex = new RegExp ("(walking|uft|kriecht)+");
else if (type == "a") regex = new RegExp ("(attack|shooting|spit)+");
else if (type == "r") regex = new RegExp ("(running|rent)+");
else if (type == "f") regex = new RegExp ("^(flying)+");

for (var i = 0; i < files.length; ++i) {	 
	if (!files[i].name.match(regex))  continue;
	
	var indx = -1;
	try {
		if (files[i].name.slice(-8,-4).match(/^\d+$/gi)) {
			var strIndx = files[i].name.slice(-6,-2);

			indx = parseInt(strIndx);
		}
	} catch (error) {
	
	}
	var docRef = open(files[i]);
	
	var xOffset = 0;
	var yOffsett = 0;
	
	if (type == "s") {
		if (indx == -1 || isNaN(indx)) {
			var dir = files[i].name.slice(-6, -4).toLowerCase();
			if (dir.charAt(0) != "e" && dir.charAt(0) != "n" && dir.charAt(0) != "w" && dir.charAt(0) != "s") dir = dir.charAt(1);
			if (dir.charAt(1) != "e" && dir.charAt(1) != "n" && dir.charAt(1) != "w" && dir.charAt(1) != "s") dir = dir.charAt(0);
			
			if (dir == "e")	yOffsett = 0;
			else if (dir == "ne") yOffsett = 1;
			else if (dir == "n") yOffsett = 2;
			else if (dir == "nw") yOffsett = 3;
			else if (dir == "w") yOffsett = 4;		
			else if (dir == "sw") yOffsett = 5;		
			else if (dir == "s") yOffsett = 6;	
			else if (dir == "se") yOffsett = 7;
		} else {	
			if (indx < 7) {
				yOffsett = 6 - indx;
			} else {
				yOffsett = indx;
			}
		}
	} else {
		if (indx >= 15) continue;
		xOffset = indx;
		
		var dir = files[i].name.slice(-10,-8).toLowerCase();
		if (dir.charAt(0) != "e" && dir.charAt(0) != "n" && dir.charAt(0) != "w" && dir.charAt(0) != "s") dir = dir.charAt(1);
		if (dir.charAt(1) != "e" && dir.charAt(1) != "n" && dir.charAt(1) != "w" && dir.charAt(1) != "s") dir = dir.charAt(0);
		
		if (dir == "e")	yOffsett = 0;
		else if (dir == "ne") yOffsett = 1;
		else if (dir == "n") yOffsett = 2;
		else if (dir == "nw") yOffsett = 3;
		else if (dir == "w") yOffsett = 4;		
		else if (dir == "sw") yOffsett = 5;		
		else if (dir == "s") yOffsett = 6;	
		else if (dir == "se") yOffsett = 7;		
	}

	activeDocument = docRef;
	selectAll();
	fill(0, 0);	
	copy();
	activeDocument = newDocumentRef;
	selectArea(xOffset * width,  yOffsett * height, width, height);
	paste();
	selectColorRange();
	deleteC();
	
	docRef.close(SaveOptions.DONOTSAVECHANGES);
}

activeDocument = newDocumentRef;
mergeVisible();

function selectAll() {
var id195 = charIDToTypeID( "setd" );
    var desc41 = new ActionDescriptor();
    var id196 = charIDToTypeID( "null" );
        var ref18 = new ActionReference();
        var id197 = charIDToTypeID( "Chnl" );
        var id198 = charIDToTypeID( "fsel" );
        ref18.putProperty( id197, id198 );
    desc41.putReference( id196, ref18 );
    var id199 = charIDToTypeID( "T   " );
    var id200 = charIDToTypeID( "Ordn" );
    var id201 = charIDToTypeID( "Al  " );
    desc41.putEnumerated( id199, id200, id201 );
executeAction( id195, desc41, DialogModes.NO );	
}

function copy() {
var id202 = charIDToTypeID( "copy" );
executeAction( id202, undefined, DialogModes.NO );	
}

function selectArea(x, y, width, height) {
var id206 = charIDToTypeID( "setd" );
    var desc43 = new ActionDescriptor();
    var id207 = charIDToTypeID( "null" );
        var ref20 = new ActionReference();
        var id208 = charIDToTypeID( "Chnl" );
        var id209 = charIDToTypeID( "fsel" );
        ref20.putProperty( id208, id209 );
    desc43.putReference( id207, ref20 );
    var id210 = charIDToTypeID( "T   " );
        var desc44 = new ActionDescriptor();
        var id211 = charIDToTypeID( "Top " );
        var id212 = charIDToTypeID( "#Pxl" );
        desc44.putUnitDouble( id211, id212, y );
        var id213 = charIDToTypeID( "Left" );
        var id214 = charIDToTypeID( "#Pxl" );
        desc44.putUnitDouble( id213, id214, x );
        var id215 = charIDToTypeID( "Btom" );
        var id216 = charIDToTypeID( "#Pxl" );
        desc44.putUnitDouble( id215, id216, y +  height );
        var id217 = charIDToTypeID( "Rght" );
        var id218 = charIDToTypeID( "#Pxl" );
        desc44.putUnitDouble( id217, id218, x + width );
    var id219 = charIDToTypeID( "Rctn" );
    desc43.putObject( id210, id219, desc44 );
executeAction( id206, desc43, DialogModes.NO );	
}

function fill(x, y) {
// =======================================================
var idsetd = charIDToTypeID( "setd" );
    var desc148 = new ActionDescriptor();
    var idnull = charIDToTypeID( "null" );
        var ref69 = new ActionReference();
        var idClr = charIDToTypeID( "Clr " );
        var idFrgC = charIDToTypeID( "FrgC" );
        ref69.putProperty( idClr, idFrgC );
    desc148.putReference( idnull, ref69 );
    var idT = charIDToTypeID( "T   " );
        var desc149 = new ActionDescriptor();
        var idRd = charIDToTypeID( "Rd  " );
        desc149.putDouble( idRd, 255.000000 );
        var idGrn = charIDToTypeID( "Grn " );
        desc149.putDouble( idGrn, 84.000003 );
        var idBl = charIDToTypeID( "Bl  " );
        desc149.putDouble( idBl, 255.000000 );
    var idRGBC = charIDToTypeID( "RGBC" );
    desc148.putObject( idT, idRGBC, desc149 );
executeAction( idsetd, desc148, DialogModes.NO );

// =======================================================
var idFl = charIDToTypeID( "Fl  " );
    var desc150 = new ActionDescriptor();
    var idFrom = charIDToTypeID( "From" );
        var desc151 = new ActionDescriptor();
        var idHrzn = charIDToTypeID( "Hrzn" );
        var idPxl = charIDToTypeID( "#Pxl" );
        desc151.putUnitDouble( idHrzn, idPxl, x );
        var idVrtc = charIDToTypeID( "Vrtc" );
        var idPxl = charIDToTypeID( "#Pxl" );
        desc151.putUnitDouble( idVrtc, idPxl, y );
    var idPnt = charIDToTypeID( "Pnt " );
    desc150.putObject( idFrom, idPnt, desc151 );
    var idTlrn = charIDToTypeID( "Tlrn" );
    desc150.putInteger( idTlrn, 0 );
    var idAntA = charIDToTypeID( "AntA" );
    desc150.putBoolean( idAntA, false );
    var idUsng = charIDToTypeID( "Usng" );
    var idFlCn = charIDToTypeID( "FlCn" );
    var idFrgC = charIDToTypeID( "FrgC" );
    desc150.putEnumerated( idUsng, idFlCn, idFrgC );
executeAction( idFl, desc150, DialogModes.NO );

}

function selectColorRange() {
var idClrR = charIDToTypeID( "ClrR" );
    var desc155 = new ActionDescriptor();
    var idFzns = charIDToTypeID( "Fzns" );
    desc155.putInteger( idFzns, 0 );
    var idMnm = charIDToTypeID( "Mnm " );
        var desc156 = new ActionDescriptor();
        var idLmnc = charIDToTypeID( "Lmnc" );
        desc156.putDouble( idLmnc, 65.610000 );
        var idA = charIDToTypeID( "A   " );
        desc156.putDouble( idA, 78.410000 );
        var idB = charIDToTypeID( "B   " );
        desc156.putDouble( idB, -51.890000 );
    var idLbCl = charIDToTypeID( "LbCl" );
    desc155.putObject( idMnm, idLbCl, desc156 );
    var idMxm = charIDToTypeID( "Mxm " );
        var desc157 = new ActionDescriptor();
        var idLmnc = charIDToTypeID( "Lmnc" );
        desc157.putDouble( idLmnc, 65.610000 );
        var idA = charIDToTypeID( "A   " );
        desc157.putDouble( idA, 78.410000 );
        var idB = charIDToTypeID( "B   " );
        desc157.putDouble( idB, -51.890000 );
    var idLbCl = charIDToTypeID( "LbCl" );
    desc155.putObject( idMxm, idLbCl, desc157 );
    var idcolorModel = stringIDToTypeID( "colorModel" );
    desc155.putInteger( idcolorModel, 0 );
executeAction( idClrR, desc155, DialogModes.NO );
}

function deleteC() {
	var idDlt = charIDToTypeID( "Dlt " );
	executeAction( idDlt, undefined, DialogModes.NO );
}


function paste() {
var id220 = charIDToTypeID( "past" );
    var desc45 = new ActionDescriptor();
    var id221 = charIDToTypeID( "AntA" );
    var id222 = charIDToTypeID( "Annt" );
    var id223 = charIDToTypeID( "Anno" );
    desc45.putEnumerated( id221, id222, id223 );
executeAction( id220, desc45, DialogModes.NO );	
}

function setRulers(interval) {
var id317 = charIDToTypeID( "setd" );
    var desc64 = new ActionDescriptor();
    var id318 = charIDToTypeID( "null" );
        var ref30 = new ActionReference();
        var id319 = charIDToTypeID( "Prpr" );
        var id320 = charIDToTypeID( "GdPr" );
        ref30.putProperty( id319, id320 );
        var id321 = charIDToTypeID( "capp" );
        var id322 = charIDToTypeID( "Ordn" );
        var id323 = charIDToTypeID( "Trgt" );
        ref30.putEnumerated( id321, id322, id323 );
    desc64.putReference( id318, ref30 );
    var id324 = charIDToTypeID( "T   " );
        var desc65 = new ActionDescriptor();
        var id325 = charIDToTypeID( "GrdM" );
        desc65.putDouble( id325, interval );
        var id326 = charIDToTypeID( "Grdt" );
        var id327 = charIDToTypeID( "RlrU" );
        var id328 = charIDToTypeID( "RrPx" );
        desc65.putEnumerated( id326, id327, id328 );
    var id329 = charIDToTypeID( "GdPr" );
    desc64.putObject( id324, id329, desc65 );
executeAction( id317, desc64, DialogModes.NO );	
}

function mergeVisible() {
	var id376 = charIDToTypeID( "MrgV" );
executeAction( id376, undefined, DialogModes.NO );
}

function moveRight() {
	var id377 = charIDToTypeID( "cut " );
    var desc73 = new ActionDescriptor();
    var id378 = charIDToTypeID( "null" );
        var ref35 = new ActionReference();
        var id379 = charIDToTypeID( "Chnl" );
        var id380 = charIDToTypeID( "fsel" );
        ref35.putProperty( id379, id380 );
    desc73.putReference( id378, ref35 );
    var id381 = charIDToTypeID( "T   " );
        var desc74 = new ActionDescriptor();
        var id382 = charIDToTypeID( "Hrzn" );
        var id383 = charIDToTypeID( "#Pxl" );
        desc74.putUnitDouble( id382, id383, 4.000000 );
        var id384 = charIDToTypeID( "Vrtc" );
        var id385 = charIDToTypeID( "#Pxl" );
        desc74.putUnitDouble( id384, id385, 0.000000 );
    var id386 = charIDToTypeID( "Ofst" );
    desc73.putObject( id381, id386, desc74 );
executeAction( id377, desc73, DialogModes.NO );
}