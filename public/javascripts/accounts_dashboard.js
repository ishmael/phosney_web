(function () {
	YUI().use('yui2-tabview', function(Y) {
	var YAHOO = Y.YUI2;
		var Event = YAHOO.util.Event;

		Event.onContentReady("charts", function () {

			var tabView = new YAHOO.widget.TabView('charts'); 	
		
		});
		});	
}());