jQuery(document).ready(function(){
	jQuery(function($) {
	  $("#add_subscribe_group")
	    .bind("ajax:success", function(event, data, status, xhr) {
	      $("#subscrib_groups li:last").after($("<li>"+ data +"</li>"));
	    });
	});
});
