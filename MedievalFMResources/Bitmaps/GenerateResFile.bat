cd /d %~dp0
del bitmaps.txt \y
del bitmapsList.txt \y
del bitmapResources.txt \y
for /f %%a IN ('dir /b *.png,*.gif,*.jpg') DO CALL ResFileTemplate.bat %%~na %%~xa bitmaps.txt bitmapsList.txt

ECHO //This file is autogenerated. Do not modify. >> bitmapResources.txt
ECHO public final class BitmapResources >> bitmapResources.txt
ECHO { >> bitmapResources.txt
type bitmaps.txt >> bitmapResources.txt
ECHO. >> bitmapResources.txt
ECHO 	public static const bitmaps:Object = { >> bitmapResources.txt
type bitmapsList.txt >> bitmapResources.txt
ECHO 	}; >> bitmapResources.txt
ECHO } >> bitmapResources.txt

del bitmaps.txt \y
del bitmapsList.txt \y