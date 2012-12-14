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
	$("#add_swing").click(function(e){
		$.ajax({
			url: "add_swing",
			type: "GET",
			success: function(data){
				$("#swings").html(data)
			}
		});
	});
});