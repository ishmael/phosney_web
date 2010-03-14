(function () {
	
		var Event = YAHOO.util.Event,
			Dom = YAHOO.util.Dom;	

		Event.onContentReady("category_div", function () {
				document.getElementById("category_parent_id")[0].value = 0;
				var oSelectButtonCategory = new YAHOO.widget.Button({  
						                    id: "categorybutton", 
						                    type: "menu",   
						                    menu: "category_parent_id",
											lazyloadmenu: false, 
											container: "category_container"
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
	}());