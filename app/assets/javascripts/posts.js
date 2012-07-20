jQuery(document).ready(function(){
	jQuery(function($) {
	  $("#add_subscribe_group")
	    .bind("ajax:success", function(event, data, status, xhr) {
	    	alert(1);
	      $("#subscrib_groups").add("<li>"+ data +"</li>");
	    });
	    alert(0);
	});
});
