// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
(function () {
	
		var Event = YAHOO.util.Event,
			Dom = YAHOO.util.Dom;	

		var ButtonGroup = YAHOO.widget.ButtonGroup;
		
		
		Event.onContentReady("quickmovement_type_bgroup", function () {
		   var mov_type = document.getElementById("quickmovement_type");
           var oButtonGroupQM = new ButtonGroup("quickmovement_type_bgroup");
		   
		   if (mov_type.value == "-1")
			oButtonGroupQM.check(0);
		   else 
		   oButtonGroupQM.check(1);
  
		   oButtonGroupQM.on("checkedButtonChange", onCheckedButtonChange);
        });

		 var onCheckedButtonChange = function (p_oEvent) {
			var mov_type = document.getElementById("quickmovement_type");
			
            if(p_oEvent.newValue.get("id") == "qm_mov_debit") {
				mov_type.value = "-1";      
            }
            if(p_oEvent.newValue.get("id") == "qm_mov_credit") {
				mov_type.value = "1";
            }
			
        };

		Event.onContentReady("div-quickmovement-submit", function () {
           var oPushButton2 = new YAHOO.widget.Button("qm-submit"); 
        });
		
		
		Event.onContentReady("datefields", function () {

			var oCalendarMenu;
	
			var onButtonClick = function () {
	
				// Create a Calendar instance and render it into the body 
				// element of the Overlay.
	
				var oCalendar = new YAHOO.widget.Calendar("buttoncalendar", oCalendarMenu.body.id,{navigator:true});
	
				oCalendar.render();
	
	
				// Subscribe to the Calendar instance's "select" event to 
				// update the Button instance's label when the user
				// selects a date.
	
				oCalendar.selectEvent.subscribe(function (p_sType, p_aArgs) {
	
					var aDate,
						nMonth,
						nDay,
						nYear;
	
					if (p_aArgs) {
						
						aDate = p_aArgs[0][0];
	
						nMonth = aDate[1];
						nDay = aDate[2];
						nYear = aDate[0];
						// Sync the Calendar instance's selected date with the date form fields
						Dom.get("movement_movdate_2i").selectedIndex = (nMonth - 1);
						Dom.get("movement_movdate_3i").selectedIndex = (nDay - 1);
						Dom.get("movement_movdate_1i").value = nYear;
						
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

					var oCalendarTBody = Dom.get("buttoncalendar").tBodies[0],
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
	
	
			var oDateFields = Dom.get("datefields");
				oMonthField = Dom.get("movement_movdate_2i"),
				oDayField = Dom.get("movement_movdate_3i"),
				oYearField = Dom.get("movement_movdate_1i");
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
	
			oCalendarMenu = new YAHOO.widget.Overlay("calendarmenu", { visible: false });
	
	
			// Create a Button instance of type "menu"
	
			var oButton = new YAHOO.widget.Button({ 
											type: "menu", 
											id: "calendarpicker", 
											label: oDateLabel, 
											menu: oCalendarMenu, 
											container: "datefields" });
	
	
			oButton.on("appendTo", function () {
			
				// Create an empty body element for the Overlay instance in order 
				// to reserve space to render the Calendar instance into.
		
				oCalendarMenu.setBody("&#32;");
		
				oCalendarMenu.body.id = "calendarcontainer";
			
			});
	
	
			// Add a listener for the "click" event.  This listener will be
			// used to defer the creation the Calendar instance until the 
			// first time the Button's Overlay instance is requested to be displayed
			// by the user.
	
			oButton.on("click", onButtonClick);
		
		});

	}());


	