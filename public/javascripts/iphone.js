// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function includemovementposition() 
{	
	if (navigator.geolocation ) 
	{
		navigator.geolocation.getCurrentPosition( handler,
                                             errorCallback,
                                             {maximumAge:60000,enableHighAccuracy:true});
 	} 
	else 
 	{
		var toggled = document.getElementById("locationtoggle");
		var latelement = document.getElementById("movement_lat");
		var lngelement = document.getElementById("movement_lng");
		var accuracyelement = document.getElementById("movement_accuracy");
		toggled.getAttribute("toggled") = "false";
		latelement.value = '';
		lngelement.value = '';
		accuracyelement.value = '';
	}  
}

function handler(location) {
	var toggled = document.getElementById("locationtoggle");
	var latelement = document.getElementById("movement_lat");
	var lngelement = document.getElementById("movement_lng");
	var accuracyelement = document.getElementById("movement_accuracy");
	if(toggled.getAttribute("toggled") == "true") 
	{
		lngelement.value =location.coords.longitude ;
		latelement.value = location.coords.latitude ;
		accuracyelement.value = location.coords.accuracy;
	}
	else
	{
		latelement.value = '';
		lngelement.value = '';
		accuracyelement.value = '';
	}
}

function errorCallback(error) {
      // Update a div element with error.message.
	var latelement = document.getElementById("movement_lat");
	var lngelement = document.getElementById("movement_lng");
	var accuracyelement = document.getElementById("movement_accuracy");
	latelement.value = '';
	lngelement.value = '';
	accuracyelement.value = '';
}