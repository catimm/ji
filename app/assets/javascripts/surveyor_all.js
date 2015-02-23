//= require surveyor/jquery-1.9.0
//= require surveyor/jquery-ui-1.10.0.custom
//= require surveyor/jquery-ui-timepicker-addon
//= require surveyor/jquery.selectToUISlider
//= require surveyor/jquery.surveyor
//= require surveyor/jquery.maskedinput

$(document).ready(function(){
	// set year range for birthdate calendar 
	$( ".date" ).datepicker({
		yearRange: "-100:+0"
	});
	// Setter
	$( ".date" ).datepicker( "option", "yearRange", "-100:+0" );
});