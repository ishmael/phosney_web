// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
var latitute,longitude;
function includemovementposition() 
{	
	if (navigator.geolocation ) 
	{
		navigator.geolocation.getCurrentPosition( handler);
 	} 
	else 
 	{
		var latelement = document.getElementById(lat);
		var lngelement = document.getElementById(lng);
		latelement.value = '';
		lngelement.value = '';
	}  
}

function handler(location) {
	var toggled = document.getElementById("locationtoggle");
	var latelement = document.getElementById("movement_lat");
	var lngelement = document.getElementById("movement_lng");
	if(toggled.getAttribute("toggled") == "true") 
	{
		lngelement.value =location.coords.longitude ;
		latelement.value = location.coords.latitude ;
	}
	else
	{
		latelement.value = '';
		lngelement.value = '';
	}
}