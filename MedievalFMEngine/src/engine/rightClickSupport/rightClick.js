var RightClick = {
	init: function () {
		try {
			this.FlashObjectID = '[id]';
			this.FlashObject = document.getElementById(this.FlashObjectID);
			
			try {
				if (this.FlashObject.tagName == 'object') {
					var param = documentcreateElement('param');
					param.setAttribute('name', 'wmode');
					param.setAttribute('value', 'opaque');				
					this.FlashObject.appendChild(param);
				} else {
					this.FlashObject.setAttribute('wmode', 'opaque');
				}
			} catch (error) {
				//alert(error);
			}
			
			this.Cache = this.FlashObjectID;
			if(window.addEventListener){
				 window.addEventListener('mousedown', this.onGeckoMouse(), true);
			} else {
				this.FlashObject.onmouseup = function() { RightClick.FlashObject.parentNode.releaseCapture(); }
				document.oncontextmenu = function(){ if(window.event.srcElement.id == RightClick.FlashObjectID) { return false; } else { RightClick.Cache = 'nan'; }}
				this.FlashObject.onmousedown = RightClick.onIEMouse;
			}
		} catch (error) {
			//alert(error);
		}
	},
	UnInit: function () { 			
		if(window.RemoveEventListener){		
			window.addEventListener('mousedown', null, true);
			window.RemoveEventListener('mousedown',this.onGeckoMouse(),true);
		} else {							
			this.FlashObject.parentNode.onmouseup = '' ;
			document.oncontextmenu = '';
			this.FlashObject.parentNode.onmousedown = '';
		}
	},
	killEvents: function(eventObject) {
		if(eventObject) {
			if (eventObject.stopPropagation) eventObject.stopPropagation();
			if (eventObject.preventDefault) eventObject.preventDefault();
			if (eventObject.preventCapture) eventObject.preventCapture();
	   		if (eventObject.preventBubble) eventObject.preventBubble();
		}
	},
	onGeckoMouse: function(ev) {
	  	return function(ev) {
	    if (ev.button != 0) {
			RightClick.killEvents(ev);
			if(ev.target.id == RightClick.FlashObjectID && RightClick.Cache == RightClick.FlashObjectID) {
	    		RightClick.call();
			}
			RightClick.Cache = ev.target.id;
		}
	  }
	},
	onIEMouse: function() {
	  	if (event.button > 1) {
	  		
			if(window.event.srcElement.id == RightClick.FlashObjectID && RightClick.Cache == RightClick.FlashObjectID) {
				RightClick.call(); 
			}
			//RightClick.FlashObject.parentNode.setCapture();
			if(window.event.srcElement.id)
				RightClick.Cache = window.event.srcElement.id;
				
			event.cancelBubble = true;
			event.returnValue = false;
			throw new Error("Throwing error to prevent IE from propagating click to Flash player. This is part of right click support and is by design, please ignore.");
		}
	},
	call: function() {
		document.getElementById(this.FlashObjectID).rightClick();
	}
}

RightClick.init();