$(document).ready(function(){
	$("#_submit_distance_").click(function(e){
		$.ajax({ 
			data: {
				distance: $("#distance_input").val(),
				heading: $("#heading_input").val()
			},
    		type: 'POST', 
    		url: 'Single/update'
		});
	})
	
//	start_heading_interval('heading_input');
});