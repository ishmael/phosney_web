(function () {
	var loader = new YAHOO.util.YUILoader({
	    require: ['colorpicker'], // what components?
	    base: '/javascripts/yui/',//where do they live?
		// The default skin, which is automatically applied if not
		        // overriden by a component-specific skin definition.
		        // Change this in to apply a different skin globally 

	    // should a failure occur, the onFailure function will be executed

		onFailure: function(o) {
	        alert("error: " + YAHOO.lang.dump(o));
	    },
	
		onSuccess: function() {
		var Event = YAHOO.util.Event,
			Dom = YAHOO.util.Dom;	

		Event.onContentReady("currency_container", function () {

				var oSelectButtonCurrency = new YAHOO.widget.Button({  
						                    id: "currencybutton", 
						                    type: "menu",   
						                    menu: "account_currency",
											lazyloadmenu: false, 
											container: "currency_container"
						});


				var onSelectedMenuItemChangeCurrency = function (event) {

							var oMenuItem = event.newValue;

							this.set("label", ("<em class=\"yui-button-label\">" + 
										oMenuItem.cfg.getProperty("text") + "</em>"));

						};
			  var onCurrencyRender = function (type, args, button) { 
							 button.set("selectedMenuItem", this.getItem(button.get("selectedMenuItem").index) ); 
			};				
		    oSelectButtonCurrency.on("selectedMenuItemChange", onSelectedMenuItemChangeCurrency);
			var oMenuButtonCurrency = oSelectButtonCurrency.getMenu();		
			oMenuButtonCurrency.subscribe("render", onCurrencyRender, oSelectButtonCurrency);
		
		
		
		});
		
		YAHOO.util.Event.onContentReady("color_container", function () {
					cor = document.getElementById("color_value").value;
		        function onButtonOption() {

		            /*
		                 Create a new ColorPicker instance, placing it inside the body 
		                 element of the Menu instance.
		            */

		            var oColorPicker = new YAHOO.widget.ColorPicker(oColorPickerMenu.body.id, {
		                                    showcontrols: false,
		                                    images: {
		                                        PICKER_THUMB: "/javascripts/yui/colorpicker/assets/picker_thumb.png",
		                                        HUE_THUMB: "/javascripts/yui/colorpicker/assets/hue_thumb.png"
		                                    }
		                                });

					
		            /*
		                Add a listener for the ColorPicker instance's "rgbChange" event
		                to update the background color and text of the Button's 
		                label to reflect the change in the value of the ColorPicker.
		            */

		            oColorPicker.on("rgbChange", function (p_oEvent) {

		                var sColor = "#" + this.get("hex");

		                oButton.set("value", sColor);

		                YAHOO.util.Dom.setStyle("current-color", "backgroundColor", sColor);
		                YAHOO.util.Dom.get("current-color").innerHTML = "Current color is " + sColor;
						document.getElementById("color_value").value = this.get("hex");
		            });


		            // Remove this event listener so that this code runs only once

		            this.unsubscribe("option", onButtonOption);

		        }


		        // Create a Menu instance to house the ColorPicker instance

		        var oColorPickerMenu = new YAHOO.widget.Menu("color-picker-menu");


		        // Create a Button instance of type "split"

		        var oButton = new YAHOO.widget.Button({ 
		                                            type: "split",
		                                            id: "color-picker-button", 
		                                            label: "<em id=\"current-color\">Current color is #FFFFFF.</em>", 
		                                            menu: oColorPickerMenu, 
		                                            container: "color_container" });


		        oButton.on("appendTo", function () {

					/*
						Create an empty body element for the Menu instance in order to 
						reserve space to render the ColorPicker instance into.
					*/

					oColorPickerMenu.setBody("&#32;");

					oColorPickerMenu.body.id = "color-picker-container";

					YAHOO.util.Dom.setStyle("current-color", "backgroundColor","#" + cor);

					// Render the Menu into the Button instance's parent element

					oColorPickerMenu.render(this.get("container"));

		        });


		        /*
		            Add a listener for the "option" event.  This listener will be
		            used to defer the creation the ColorPicker instance until the 
		            first time the Button's Menu instance is requested to be displayed
		            by the user.
		        */

		        oButton.on("option", onButtonOption);


				/*
					Add a listener for the "click" event.  This listener will be used to apply the 
					the background color to the photo.
				*/

		        oButton.on("click", function () {

		        

		        });

		    });		
				}

			});
			loader.insert();	
		}());