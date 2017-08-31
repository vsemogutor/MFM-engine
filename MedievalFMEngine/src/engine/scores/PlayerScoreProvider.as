package engine.scores
{
	import Playtomic.Leaderboards;
	import Playtomic.Log;
	import Playtomic.PlayerScore;
	
	import flash.utils.setTimeout;
	
	import mx.core.Application;
	
	public class PlayerScoreProvider
	{
		private static const SCORE_TABLE:String = "highscores";
		private static const SWFID:int = 7188;
		private static const GUID:String = "";
		private static const APIKEY:String = "";
				
		public static function init():void
		{
			var application:Application = Application.application as Application;
			Log.View(SWFID, GUID, APIKEY, application.loaderInfo.loaderURL);
		}
		
		public static function submitScore(playerName:String, score:int, levelName:String):void
		{
		    var advanced_score:PlayerScore = new PlayerScore();
		    advanced_score.Name = playerName;
		    advanced_score.Points = score;
		    advanced_score.CustomData["level"] = levelName;
		
		    Leaderboards.Save(advanced_score, SCORE_TABLE, submitComplete);
		}
		
		private static function submitComplete(response:Object):void
		{
		    if (response.Success)
		    {
				trace("Score saving success!");	
		    }
		    else
		    {
		        trace("Score saving failed!");	
		    }
		}
		
		public static function getScoresAsync(callback:Function):void
		{
		    Leaderboards.List(SCORE_TABLE, callback, {perpage: 12});
		}
	}
}