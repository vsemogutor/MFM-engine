
var folder = new Folder("D:\\Projects\\Graphics\\Units");
folder = folder.selectDlg ("Select images folder");

if (!folder.exists)  {
	throw new Error ("Wrong folder")
}

var processedFolder = new Folder(folder.fullName.toString() + "\\processed");
processedFolder.create();

var settings = prompt ("Input width and height separated by space", "", "Settings");
var settingsArray = settings.split(" ");
var width = parseInt (settingsArray[0]);
var height = parseInt (settingsArray[1]);

var files = folder.getFiles ("*.bmp");

if (files.length == 0) {
	throw new Error ("Empty folder");
}

for (var i = 0; i < files.length; ++i) {
	var docRef = open(files[i]);
	setTransparentBkgr();
	resize(width, height);
	save(processedFolder.fullName.toString() + "\\" + files[i].name.slice(0, -4) );
	docRef.close(SaveOptions.DONOTSAVECHANGES);
}
 
 function setTransparentBkgr() {
	 var id5 = charIDToTypeID( "setd" );
    var desc3 = new ActionDescriptor();
    var id6 = charIDToTypeID( "null" );
        var ref1 = new ActionReference();
        var id7 = charIDToTypeID( "Lyr " );
        var id8 = charIDToTypeID( "Bckg" );
        ref1.putProperty( id7, id8 );
    desc3.putReference( id6, ref1 );
    var id9 = charIDToTypeID( "T   " );
        var desc4 = new ActionDescriptor();
        var id10 = charIDToTypeID( "Opct" );
        var id11 = charIDToTypeID( "#Prc" );
        desc4.putUnitDouble( id10, id11, 100.000000 );
        var id12 = charIDToTypeID( "Md  " );
        var id13 = charIDToTypeID( "BlnM" );
        var id14 = charIDToTypeID( "Nrml" );
        desc4.putEnumerated( id12, id13, id14 );
    var id15 = charIDToTypeID( "Lyr " );
    desc3.putObject( id9, id15, desc4 );
executeAction( id5, desc3, DialogModes.NO );

// =======================================================
var id16 = charIDToTypeID( "setd" );
    var desc5 = new ActionDescriptor();
    var id17 = charIDToTypeID( "null" );
        var ref2 = new ActionReference();
        var id18 = charIDToTypeID( "Chnl" );
        var id19 = charIDToTypeID( "fsel" );
        ref2.putProperty( id18, id19 );
    desc5.putReference( id17, ref2 );
    var id20 = charIDToTypeID( "T   " );
        var desc6 = new ActionDescriptor();
        var id21 = charIDToTypeID( "Hrzn" );
        var id22 = charIDToTypeID( "#Pxl" );
        desc6.putUnitDouble( id21, id22, 1.000000 );
        var id23 = charIDToTypeID( "Vrtc" );
        var id24 = charIDToTypeID( "#Pxl" );
        desc6.putUnitDouble( id23, id24, 1.000000 );
    var id25 = charIDToTypeID( "Pnt " );
    desc5.putObject( id20, id25, desc6 );
    var id26 = charIDToTypeID( "Tlrn" );
    desc5.putInteger( id26, 0 );
    var id27 = charIDToTypeID( "Cntg" );
    desc5.putBoolean( id27, false );
executeAction( id16, desc5, DialogModes.NO );

// =======================================================
var id28 = charIDToTypeID( "Dlt " );
executeAction( id28, undefined, DialogModes.NO );

// =======================================================
}

function resize(width, height) {
var id29 = charIDToTypeID( "ImgS" );
    var desc7 = new ActionDescriptor();
    var id30 = charIDToTypeID( "Wdth" );
    var id31 = charIDToTypeID( "#Pxl" );
    desc7.putUnitDouble( id30, id31, width );
    var id32 = charIDToTypeID( "Hght" );
    var id33 = charIDToTypeID( "#Pxl" );
    desc7.putUnitDouble( id32, id33, height );
    var id34 = charIDToTypeID( "Intr" );
    var id35 = charIDToTypeID( "Intp" );
    var id36 = charIDToTypeID( "Bcbc" );
    desc7.putEnumerated( id34, id35, id36 );
executeAction( id29, desc7, DialogModes.NO );	
}

function save(name) {
	var id37 = charIDToTypeID( "save" );
    var desc8 = new ActionDescriptor();
    var id38 = charIDToTypeID( "As  " );
        var desc9 = new ActionDescriptor();
        var id39 = charIDToTypeID( "PGIT" );
        var id40 = charIDToTypeID( "PGIT" );
        var id41 = charIDToTypeID( "PGIN" );
        desc9.putEnumerated( id39, id40, id41 );
        var id42 = charIDToTypeID( "PNGf" );
        var id43 = charIDToTypeID( "PNGf" );
        var id44 = charIDToTypeID( "PGAd" );
        desc9.putEnumerated( id42, id43, id44 );
    var id45 = charIDToTypeID( "PNGF" );
    desc8.putObject( id38, id45, desc9 );
    var id46 = charIDToTypeID( "In  " );
    desc8.putPath( id46, new File( name ) );
    var id47 = charIDToTypeID( "Cpy " );
    desc8.putBoolean( id47, true );
 executeAction( id37, desc8, DialogModes.NO );
}