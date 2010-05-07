(function () {
	
		var Event = YAHOO.util.Event,
			Dom = YAHOO.util.Dom;	
		Event.onContentReady("movement_type_bgroup", function () {
		   var mov_type = document.getElementById("movement_mov_type");
           var oButtonGroupQM = new YAHOO.widget.ButtonGroup("movement_type_bgroup");

		   if (mov_type.value == "-1")
			oButtonGroupQM.check(0);
		   else 
		   oButtonGroupQM.check(1);

		   oButtonGroupQM.on("checkedButtonChange", onCheckedButtonChange);
        });

		 var onCheckedButtonChange = function (p_oEvent) {
			var mov_type = document.getElementById("movement_mov_type");

            if(p_oEvent.newValue.get("id") == "mov_debit") {
				mov_type.value = "-1";      
            }
            if(p_oEvent.newValue.get("id") == "mov_credit") {
				mov_type.value = "1";
            }

        };

		Event.onContentReady("movements_div", function () {
				document.getElementById("movement_category_id")[0].value = 0;

				var oSelectButtonCategory = new YAHOO.widget.Button({
					  						id: "categorybutton",
											name:"categorybutton",
						                    type: "menu",   
						                    menu: "movement_category_id",										
											lazyloadmenu: false,
											container: "mov_category_container"
						});
	
				
				var oMenuButtonCategoryMenu = oSelectButtonCategory.getMenu();
				
				var onSelectedMenuItemChangeCategory = function (event) {
					
					var oMenuItem = event.newValue;

					this.set("label", ("<em class=\"yui-button-label\">" + 
					oMenuItem.cfg.getProperty("text") + "</em>"));
				};
					
				var onCategoryRender = function (type, args, button) { 
						 button.set("selectedMenuItem", this.getItem(button.get("selectedMenuItem").index) ); 
				};
				
				if(oMenuButtonCategoryMenu != null)
				{						
					oMenuButtonCategoryMenu.subscribe("render", onCategoryRender, oSelectButtonCategory);
					oSelectButtonCategory.on("selectedMenuItemChange", onSelectedMenuItemChangeCategory);
				}				
			

		    
		
		
			var oCalendarMenu;
	
			var onButtonClick = function () {
	
				// Create a Calendar instance and render it into the body 
				// element of the Overlay.
	
				var oCalendar = new YAHOO.widget.Calendar("movementscalendar", oCalendarMenu.body.id,{navigator:true});
	
				oCalendar.render();
	
	
				// Subscribe to the Calendar instance's "select" event to 
				// update the Button instance's label when the user
				// selects a date.
	
				oCalendar.selectEvent.subscribe(function (p_sType, p_aArgs) {
	
					var aDate,
						nMonth,
						nDay,
						nYear,theDiv;
	
					if (p_aArgs) {
						
						aDate = p_aArgs[0][0];
	
						nMonth = aDate[1];
						nDay = aDate[2];
						nYear = aDate[0];
						// Sync the Calendar instance's selected date with the date form fields
						// 
						// 
						 
						Dom.getChildren("movements_controller")[1].selectedIndex = (nMonth - 1);
						Dom.getChildren("movements_controller")[0].selectedIndex = (nDay - 1);
						Dom.getChildren("movements_controller")[2].value = nYear;
						
						if (String(nDay).length == 1)
						{
							nDay = "0" + nDay;
						}
						
						if (String(nMonth).length == 1)
						{
							nMonth = "0" + nMonth;
						}
						
						
						oButton.set("label", ( nDay + "/" + nMonth + "/" + nYear));
	
	
						
	
	
					}
					
					oCalendarMenu.hide();
				
				});
	
	
				// Pressing the Esc key will hide the Calendar Menu and send focus back to 
				// its parent Button
	
				Event.on(oCalendarMenu.element, "keydown", function (p_oEvent) {
				
					if (Event.getCharCode(p_oEvent) === 27) {
						oCalendarMenu.hide();
						this.focus();
					}
				
				}, null, this);
				
				
				var focusDay = function () {

					var oCalendarTBody = Dom.get("movementscalendar").tBodies[0],
						aElements = oCalendarTBody.getElementsByTagName("a"),
						oAnchor;

					
					if (aElements.length > 0) {
					
						Dom.batch(aElements, function (element) {
						
							if (Dom.hasClass(element.parentNode, "today")) {
								oAnchor = element;
							}
						
						});
						
						
						if (!oAnchor) {
							oAnchor = aElements[0];
						}


						// Focus the anchor element using a timer since Calendar will try 
						// to set focus to its next button by default
						
						YAHOO.lang.later(0, oAnchor, function () {
							try {
								oAnchor.focus();
							}
							catch(e) {}
						});
					
					}
					
				};


				// Set focus to either the current day, or first day of the month in 
				// the Calendar	when it is made visible or the month changes
	
				oCalendarMenu.subscribe("show", focusDay);
				oCalendar.renderEvent.subscribe(focusDay, oCalendar, true);
	

				// Give the Calendar an initial focus
				
				focusDay.call(oCalendar);
	
	
				// Re-align the CalendarMenu to the Button to ensure that it is in the correct
				// position when it is initial made visible
				
				oCalendarMenu.align();

	
				// Unsubscribe from the "click" event so that this code is 
				// only executed once
	
				this.unsubscribe("click", onButtonClick);
			
			};
	
	
			var oDateFields = Dom.get("movements_controller");
			
				oMonthField =Dom.getChildren("movements_controller")[1];
				oDayField = Dom.getChildren("movements_controller")[0];
				oYearField = Dom.getChildren("movements_controller")[2];
				
				oDateLabel= "";
				
			
	
			// Hide the form fields used for the date so that they can be replaced by the 
			// calendar button.
	
			oMonthField.style.display = "none";
			
			oDayField.style.display = "none";
			oYearField.style.display = "none";
			
			if (oDayField.value.length == 1)
			{
				oDateLabel = "0" + oDayField.value + "/";
			}
			else
			{
				oDateLabel = oDayField.value + "/";
			}
			
			if (oMonthField.value.length == 1)
			{
				oDateLabel = oDateLabel+ "0" + oMonthField.value + "/";
			}	
			else
			{
				oDateLabel = oDateLabel+ oMonthField.value + "/";
			}
			
			oDateLabel = oDateLabel+ "/"+ oYearField.value ;
			
			// Create a Overlay instance to house the Calendar instance
	
			oCalendarMenu = new YAHOO.widget.Overlay("movementscalendarmenu", { visible: false });
	
	
			// Create a Button instance of type "menu"
	
			var oButton = new YAHOO.widget.Button({ 
											type: "menu", 
											id: "movementscalendarpicker", 
											label: oDateLabel, 
											menu: oCalendarMenu, 
											container: "movements_controller" });
	
	
			oButton.on("appendTo", function () {
			
				// Create an empty body element for the Overlay instance in order 
				// to reserve space to render the Calendar instance into.
		
				oCalendarMenu.setBody("&#32;");
		
				oCalendarMenu.body.id = "movementscalendarcontainer";
			
			});
	
	
			// Add a listener for the "click" event.  This listener will be
			// used to defer the creation the Calendar instance until the 
			// first time the Button's Overlay instance is requested to be displayed
			// by the user.
	
			oButton.on("click", onButtonClick);
		
		});

	}());
function mapsdoubleclick(overlay, latlng)
{
     map.clearOverlays();
	 mymarker = new GMarker(latlng);
	 GEvent.addListener(mymarker,"dblclick",markerclick);
     map.addOverlay(mymarker);
	 document.getElementById("movement_lat").value=latlng.y;
	 document.getElementById("movement_lng").value=latlng.x;
}	
function markerclick(overlay, latlng)
{
	
    if (overlay)
    {
      map.clearOverlays();
	  document.getElementById("movement_lat").value=null;
	  document.getElementById("movement_lng").value=null;
     
    }
    
}
	
		