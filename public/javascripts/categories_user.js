(function () {
	YUI().use('yui2-button','yui2-menu', function(Y) {
		var YAHOO = Y.YUI2;	
		var Event = YAHOO.util.Event,
			Dom = YAHOO.util.Dom;	

		Event.onContentReady("shared_category_container", function () {
				var oSelectButtonCategory = new YAHOO.widget.Button({  
						                    id: "sharedcategorybutton", 
						                    type: "menu",   
						                    menu: "shared_category",
											lazyloadmenu: false, 
											container: "shared_category_container"
						});


				var onSelectedMenuItemChangeCategory = function (event) {

							var oMenuItem = event.newValue;

							this.set("label", ("<em class=\"yui-button-label\">" + 
										oMenuItem.cfg.getProperty("text") + "</em>"));

						};
							
							
				var onCategoryRender = function (type, args, button) { 
								 button.set("selectedMenuItem", this.getItem(button.get("selectedMenuItem").index) ); 
				};			

			var oMenuButtonCategoryMenu = oSelectButtonCategory.getMenu();		
			oMenuButtonCategoryMenu.subscribe("render", onCategoryRender, oSelectButtonCategory);		
		    oSelectButtonCategory.on("selectedMenuItemChange", onSelectedMenuItemChangeCategory);
		});
		
			});
	}());