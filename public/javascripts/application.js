// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function() {
            $("#wideView").click(function() {
                $("#content").toggleClass("wide");
				$("#search").toggleClass("wide");
				$("#primary").toggleClass("wide");
                $(this).toggleClass("wide");
            });
        });
		

		
$(function(){
				  $("#movement_movdate").datepicker({
						changeMonth: true,
						changeYear: true,
						dateFormat: 'dd/mm/yy'
					});

			 });
	