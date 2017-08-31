package engine.dashboard
{
	import engine.core.ManagerBase;
	import engine.core.events.GameEvent;
	import engine.core.events.GameEvents;
	import engine.game.Game;
	
	public final class DashboardManager extends ManagerBase
	{
		private var _infoPanel:Dashboard = new Dashboard("infopanel", "", DashboardType.INFO_PANEL);
		private var _dashboards:Array = new Array();
		
		public function get infoPanel():Dashboard {
			return _infoPanel;
		}
	
		public function addDashboard(name:String, caption:String, type:int=0):Dashboard
		{
			var dashboard:Dashboard = getDashboard(name);
			if (dashboard)
				return dashboard;
				
			if (type == DashboardType.SIMPLE)
			{
				dashboard = new Dashboard(name, caption);
				_dashboards.push(dashboard);
				eventManager.dispatch(new GameEvent(GameEvents.ADD_DASHBOARD, {dashboard:dashboard}));
				return dashboard;
			}
			
			return null;
		}
		
		public function removeDashboad(dashboard:Dashboard):void
		{
			var indx:int = _dashboards.indexOf(dashboard);
			var dashboard:Dashboard;
			if (indx != - 1)
			{
				dashboard = _dashboards[indx];
				_dashboards.splice(indx, 1);
				eventManager.dispatch(new GameEvent(GameEvents.REMOVE_DASHBOARD, {dashboard:dashboard}));
			}
		}
	
		public function getDashboard(name:String):Dashboard
		{
			for (var i:int = 0; i < _dashboards.length; ++i)
			{
				if (_dashboards[i].name == name)
					return _dashboards[i];
			}
			
			return null;
		}
	}
}