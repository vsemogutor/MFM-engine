package utils
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	public class FileUtil
	{
		public static const DEFAULT_FILE_EXT:String = ".xml";
		
		 public static function saveFile(content:String, name:String):void
		 {
		 	try
		 	{
		 		if (name.indexOf(".") == -1)
		 		{
		 			name = name + DEFAULT_FILE_EXT;
		 		}
		 		
	            var file:File = File.applicationDirectory.resolvePath(name);
	            file.browseForSave("Save");
	            file.addEventListener(Event.SELECT, saveData);
	            
	            function saveData(event:Event):void 
				{
				    var newFile:File = event.target as File;
				    if (!newFile.exists)
				    {
				        var stream:FileStream = new FileStream();
				        stream.open(newFile, FileMode.WRITE);
				        stream.writeUTFBytes(content);
				        stream.close();
				    }
				}
		
   			}
   			catch (error:Error)
   			{
   				trace("Failed:", error.message);
   			}
		 }
	}
}