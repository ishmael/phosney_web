(function () {
	
		var Event = YAHOO.util.Event,
			Dom = YAHOO.util.Dom;	

		Event.onContentReady("category_div", function () {

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
							
		    oSelectButtonCategory.on("selectedMenuItemChange", onSelectedMenuItemChangeCategory);
		});
	}());