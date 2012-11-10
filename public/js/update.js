$(document).ready(function(){
	$("#update_distance").click(function(e){
		$.ajax({
			url: "update",
			type: "GET",
			success: function(data){
				$("#information").html(data)
			}
		})
	})
});