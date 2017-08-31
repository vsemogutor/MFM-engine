@Echo Off
cd /d %~dp0
ECHO 	[Embed(source="../Bitmaps/%1%2")] >> %3
ECHO 	private static var _%1Class:Class; >> %3
ECHO 	public static var %1:Bitmap = new _%1Class(); >> %3
ECHO. >> %3

IF EXIST %4 (
ECHO 	,"%1":%1.bitmapData >> %4
) ELSE (
ECHO 	"%1":%1.bitmapData >> %4
)