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
	$("#course_update_distance").click(function(e){
		$.ajax({
			url: "/app/Hole/update_heading_distance",
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
	$("#course_add_swing").click(function(e){
		$.ajax({
			url: "/app/Hole/add_swing",
			type: "GET",
			success: function(data){
				$("#swings").html(data)
			}
		});
	});
	$("#course_undo_swing").click(function(e){
		$.ajax({
			url: "/app/Hole/undo_swing",
			type: "GET",
			success: function(data){
				$("#swings").html(data)
			}
		});
	});
	$("#update_heading_distance").click(function(e){
		$.ajax({
			url: "/app/Hole/update_heading_distance",
			type: "GET",
			success: function(data){
				$("#information").html(data)
			}
		})
	})	
	
});