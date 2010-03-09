(function () {
	
		var Event = YAHOO.util.Event,
			Dom = YAHOO.util.Dom;	

		Event.onContentReady("users_div", function () {

				var oSelectButtonCategory = new YAHOO.widget.Button({  
						                    id: "localebutton", 
						                    type: "menu",   
						                    menu: "user_locale",
											lazyloadmenu: false, 
											container: "locale_container"
						});


				var onSelectedMenuItemChangeCategory = function (event) {

							var oMenuItem = event.newValue;

							this.set("label", ("<em class=\"yui-button-label\">" + 
										oMenuItem.cfg.getProperty("text") + "</em>"));

						};
							
		    oSelectButtonCategory.on("selectedMenuItemChange", onSelectedMenuItemChangeCategory);
		});
		
}());