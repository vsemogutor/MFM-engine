package engine.sound
{
	import com.greensock.TweenMax;
	import com.greensock.data.TweenMaxVars;
	import com.greensock.easing.Linear;
	import com.greensock.events.TweenEvent;
	
	import computers.utils.Utils;
	
	import engine.area.Area;
	import engine.core.events.EngineEvents;
	import engine.core.events.GameEvent;
	import engine.core.isometric.IsoTile;
	import engine.game.Game;
	import engine.game.GameManager;
	import engine.game.GameOptions;
	import engine.units.Unit;
	import engine.util.TileUtil;
	import engine.util.Util;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;
	
	import mx.core.SoundAsset;
	
	public final class SoundManager extends EventDispatcher
	{
		private static var _instance:SoundManager = new SoundManager();
		
		private var _backgroundMusic:SoundChannel;
		private var _backgroundPlayList:Array = [];
		private var _ambientList:Array = [];
		private var _playRandom:Boolean;
		private var _currentPlayListIndx:int;
		private var _ambientDelay:int = 0;
		private var _soundPlaying:Dictionary = new Dictionary();
		private var _soundInit:Dictionary = new Dictionary();
		private var _areaAmbient:Dictionary = new Dictionary();
		private var _options:GameOptions;
		
		public function get backgroundMusic():SoundChannel {
			return _backgroundMusic;
		}
		
		public static function instance():SoundManager
		{
			return _instance;
		}
		
		public function SoundManager()
		{
			GameManager.instance().addEventListener(EngineEvents.MUSIC_VOLUME_CHANGED, onMusicVolumeChanged);
			_options = GameManager.instance().options;
		}
		
		public function playSoundOnUnit(unit:Unit, sound:SoundAsset, repeat:int=0, vol:Number=1):void
		{
			if (!unit) return;
			
			playSoundAtPosiion(	unit.tile, sound, repeat, vol);
		}
		
		public function playSoundAtPosiion(tile:IsoTile, sound:SoundAsset, repeat:int=0, vol:Number=1):void
		{
			if (!sound || !tile)
				return;
				
			var gt:int = Game.instance().gameTime.value;
			var channelDesc:Object = _soundPlaying[sound];
			if (channelDesc && channelDesc.time + Util.secToFrames((sound.length/4000)) > gt)
			{
				return;
			}
			
			var dist:int = TileUtil.getTileDist(tile, Game.instance().world.centerTile);
			var visibleDist:int = Game.instance().sceneManager.visibleAreaTileWidth;
			var maxDist:Number =  visibleDist + visibleDist/2;
			
			if (dist > maxDist)
				return;
	
			var soundVolume:Number = _options.soundVolume;
			var volume:Number = soundVolume - ((dist - visibleDist/2)/visibleDist)*0.8;
			
			if (volume > soundVolume)
				volume = soundVolume * vol;
			else if (volume <= 0)
				volume = soundVolume > 0 ? 0.1 : 0;
			
			var channel:SoundChannel = sound.play(0, repeat, new SoundTransform(volume - Utils.rand(-1, 2)/10.0));
			_soundPlaying[sound] = {channel: channel, time:gt};
			
			if (!_soundInit[sound])
			{
				sound.addEventListener(Event.SOUND_COMPLETE, function (evt:Event):void 
				{
					_soundPlaying[sound] = null;
				});
				_soundInit[sound] = true;
			}
		}
					
		public function playSound(sound:SoundAsset, vol:Number=0):void
		{
			var volume:Number = _options.soundVolume;
			if (vol) volume *= vol;
			
			sound.play(0, 0, new SoundTransform(volume));
		}		

		public function loopSound(sound:SoundAsset, vol:Number, repeat:int=int.MAX_VALUE):void
		{
			var volume:Number = _options.soundVolume;
			if (vol) volume *= vol;
			
			sound.play(0, repeat, new SoundTransform(volume));
		}
				
		public function clickSound():void
		{
			playBuildInSound(BuildInSounds.MOUSE_CLICK);
		}

		public function playBuildInSound(sound:int):void
		{
			if (Game.instance())
				Game.instance().eventManager.dispatchEvent(new GameEvent(EngineEvents.PLAY_BUILD_IN_SOUND, {sound:sound}));
		}
				
		public function playMusic(sound:SoundAsset, loops:int = int.MAX_VALUE, fadeInTime:int=0):void
		{
			if (!sound)
				return;
			
			stopMusic();
					
			var vol:Number = _options.musicVolume;
			var sndTransform:SoundTransform;
			if (fadeInTime)
				sndTransform = new SoundTransform(0);
			else
				sndTransform = new SoundTransform(vol);
				
			_backgroundMusic = sound.play(0, loops, sndTransform);
			 if (_backgroundMusic)
			 {
				 if (fadeInTime)
				 {
					var params:TweenMaxVars = new TweenMaxVars({volume:vol,ease:Linear});
					params.onUpdateListener(function(evt:TweenEvent):void 
						{
							if (_backgroundMusic)
								_backgroundMusic.soundTransform = sndTransform;
						});
					TweenMax.to(sndTransform, fadeInTime, params);
				 }
				
				_backgroundMusic.addEventListener(Event.SOUND_COMPLETE, musicComplete);
			 }
		}
		
		public function playMusicPlayList(playList:Array, random:Boolean = false):void
		{
			_playRandom = random;
			_backgroundPlayList = playList;
			_currentPlayListIndx = -1;
			playNexMusicOnPlayList();
		}
		
		public function playNexMusicOnPlayList(random:Boolean = false):void
		{
			if (!_backgroundPlayList || _backgroundPlayList.length == 0)
				return;
		
			if (random)
				_currentPlayListIndx = Utils.rand(0, _backgroundPlayList.length - 1);
			else
				++_currentPlayListIndx;
				
			if (_currentPlayListIndx >= _backgroundPlayList.length)
				_currentPlayListIndx = 0;
				
			playMusic(_backgroundPlayList[_currentPlayListIndx], 0);
		}
	
		public function stopAll():void
		{
			stopMusic();
			SoundMixer.stopAll();
			_ambientList = [];
			_backgroundPlayList = [];
			_soundPlaying = new Dictionary();
		}
		
		public function stopMusic():void
		{
			if (_backgroundMusic)
			{
				_backgroundMusic.stop();
				TweenMax.killTweensOf(_backgroundMusic);
				_backgroundMusic.removeEventListener(Event.SOUND_COMPLETE, musicComplete);
				_backgroundMusic = null;
			}
		}
		
		public function setAmbientList(playList:Array):void
		{
			_ambientList = playList;
			_ambientList = _ambientList.concat(_ambientList);
		}

		public function setAmbientLoopAreaList(areaPlayList:Array):void
		{
			for (var i:int = 0; i < areaPlayList.length; ++i)
			{
				_areaAmbient[areaPlayList[i].area] = areaPlayList[i].sound;
			}
		}
		
		public function playRandomAmbient():void
		{
			var centerTile:IsoTile = Game.instance().world.centerTile;
			if (Utils.rand(0, 300) > 280  && _ambientDelay <= 0)
			{
				if (_ambientList && _ambientList.length)
				{
					var indx:int = Utils.rand(0, _ambientList.length - 1);
					if (_ambientList[indx] is Sound)
						playSound(_ambientList[indx], 0.60);
					else if (_ambientList[indx].area.contains(centerTile.xindex, centerTile.yindex))
						playSound(_ambientList[indx].sound, 0.60);
				}
				_ambientDelay = Util.secToFrames(15);
			}
			--_ambientDelay;
			
			var volume:Number = _options.soundVolume;
			for (var key:Object in _areaAmbient)
			{
				var area:Area = key as Area;
				var sound:SoundAsset = _areaAmbient[area];
				var channel:SoundChannel = _soundPlaying[sound];
				if (area.contains(centerTile.xindex, centerTile.yindex))
				{
					if (!channel)
					{
						channel = sound.play(Utils.rand(0, sound.length/15), int.MAX_VALUE, new SoundTransform(volume*0.42));
						_soundPlaying[sound] = channel;
					}
				}
				else if (channel)
				{
					channel.stop(); 
					_soundPlaying[sound] = null;
				}
			}
		}
		
		private function musicComplete(evt:Event):void
		{
			_backgroundMusic.removeEventListener(Event.SOUND_COMPLETE, musicComplete);
			playNexMusicOnPlayList(_playRandom);
		}
		
		private function onMusicVolumeChanged(evt:GameEvent):void
		{
			if (_backgroundMusic)
				_backgroundMusic.soundTransform = new SoundTransform(evt.properties.volume);
		}
	}
}