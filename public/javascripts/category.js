(function () {
		YUI().use('yui2-button','yui2-menu', function(Y) {
			window.YAHOO = window.YAHOO || Y.YUI2;
			var Event = YAHOO.util.Event,
				Dom = YAHOO.util.Dom;	

			Event.onContentReady("category_div", function () {
					document.getElementById("category_parent_id")[0].value = 0;
					var oSelectButtonParentCategory = new YAHOO.widget.Button({  
							                    id: "categorybutton", 
							                    type: "menu",   
							                    menu: "category_parent_id",
												lazyloadmenu: false, 
												container: "category_container"
							});


					var onSelectedMenuItemChangeParentCategory = function (event) {

								var oMenuItem = event.newValue;
								
								this.set("label", ("<em class=\"yui-button-label\">" + 
											oMenuItem.cfg.getProperty("text") + "</em>"));

							};
							
							
					var onParentCategoryRender = function (type, args, button) { 
									 button.set("selectedMenuItem", this.getItem(button.get("selectedMenuItem").index) ); 
					};			

				var oMenuButtonParentCategoryMenu = oSelectButtonParentCategory.getMenu();	
				
				oMenuButtonParentCategoryMenu.subscribe("render", onParentCategoryRender, oSelectButtonParentCategory);		
			    oSelectButtonParentCategory.on("selectedMenuItemChange", onSelectedMenuItemChangeParentCategory);
			});
		});
	}());