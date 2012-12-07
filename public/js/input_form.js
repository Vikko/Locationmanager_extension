$(document).ready(function(){
	$("#_submit_distance_").click(function(e){
		$.ajax({ 
			data: {
				distance: $("#distance_input_field").val(),
				heading: $("#heading_input_field").val()
			},
    		type: 'POST', 
    		url: 'Single/update'
		});
	})
	
	start_heading_interval('compass','heading_input');
});