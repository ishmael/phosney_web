(function () {
	
		var Event = YAHOO.util.Event,
			Dom = YAHOO.util.Dom;	

		Event.onContentReady("users_div", function () {

				var oSelectButtonLanguage= new YAHOO.widget.Button({  
						                    id: "localebutton", 
						                    type: "menu",   
						                    menu: "user_locale",
											lazyloadmenu: false, 
											container: "locale_container"
						});


				var onSelectedMenuItemChangeLanguage = function (event) {

							var oMenuItem = event.newValue;

							this.set("label", ("<em class=\"yui-button-label\">" + 
										oMenuItem.cfg.getProperty("text") + "</em>"));

						};
			  var onLanguageRender = function (type, args, button) { 
							 button.set("selectedMenuItem", this.getItem(button.get("selectedMenuItem").index) ); 
			};				
		    oSelectButtonLanguage.on("selectedMenuItemChange", onSelectedMenuItemChangeLanguage);
			var oMenuButtonLanguage = oSelectButtonLanguage.getMenu();		
			oMenuButtonLanguage.subscribe("render", onLanguageRender, oSelectButtonLanguage);
		
		});
		
}());