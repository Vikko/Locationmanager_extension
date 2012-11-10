$(document).ready(function(){
	$("#submit_distance").click(function(e){
		$.ajax({ 
    		type: 'POST', 
    		url: 'Single/update_distance'
		});
	})
	
	$("#submit_heading").click(function(e){
		$.ajax({ 
    		type: 'POST', 
    		url: 'Single/update_distance'
		});
	})
});