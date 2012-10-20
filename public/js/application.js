var xyz_interval = "";

function start_xyz_interval(dom_x, dom_y, dom_z) {
  $(document).ready(function() {
	  if (xyz_interval == "") {
	    xyz_interval = setInterval(function(){
	      $.get('AccelerometerTest/get_xyz', {}, function(data){
	        $('#'+dom_x).html(data.x);
	        $('#'+dom_y).html(data.y);
	        $('#'+dom_z).html(data.z);
	      });
	      return false;
	    }, 300);
  	}
  });
}

function stop_xyz_interval(){
	clearInterval(xyz_interval)
	xyz_interval = ""
}

var xyz_mag_interval = "";

function start_xyz_mag_interval(dom_x, dom_y, dom_z, dom_th) {
  $(document).ready(function() {
	  if (xyz_mag_interval == "") {
	    xyz_mag_interval = setInterval(function(){
	      $.get('LocationmanagerTest/get_xyzth', {}, function(data){
	        $('#'+dom_x).html("x = " + data.x);
	        $('#'+dom_y).html("y = " + data.y);
	        $('#'+dom_z).html("z = " + data.z);
			$('#'+dom_th).html("Heading<br/>" + data.th + "&#176;");
	      });
	      return false;
	    }, 300);
  	}
  });
}

function stop_xyz_mag_interval(){
	clearInterval(xyz_mag_interval)
	xyz_mag_interval = ""
}