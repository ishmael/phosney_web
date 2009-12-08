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
						dateFormat: 'yy-mm-dd'
					});
					
					$('select#movement_account_id').selectmenu({
									style:'dropdown', 
									menuWidth: 400,
									width: 100
								});
								
					$('select#movement_category_id').selectmenu({
						style:'dropdown', 
						menuWidth: 400,
						width: 100
						});	
						
						$(".fg-button:not(.ui-state-disabled)")
								.hover(
									function(){ 
										$(this).addClass("ui-state-hover"); 
									},
									function(){ 
										$(this).removeClass("ui-state-hover"); 
									}
								)
								.mousedown(function(){
										$(this).parents('.fg-buttonset-single:first').find(".fg-button.ui-state-active").removeClass("ui-state-active");
										if( $(this).is('.ui-state-active.fg-button-toggleable, .fg-buttonset-multi .ui-state-active') ){ $(this).removeClass("ui-state-active"); }
										else { $(this).addClass("ui-state-active"); }	
								})
								.mouseup(function(){
									if(! $(this).is('.fg-button-toggleable, .fg-buttonset-single .fg-button,  .fg-buttonset-multi .fg-button') ){
										$(this).removeClass("ui-state-active");
									}
								});

			 });
	