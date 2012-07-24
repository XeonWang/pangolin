jQuery(document).ready(function(){
	jQuery(function($) {
	  $("#add_subscribe_group").bind("ajax:success", function(event, data, status, xhr) {
	      $("#subscrib_groups li:last").after($("<li>"+ data +"</li>"));
	      $('#myModal').modal('hide');
	      $("#add_subscribe_group").each (function(){
		  	this.reset();
		  });
	  });
	  $.ajax({
	  	url: 'posts/post_list',
	  	data: {
	  		group: $('#subscrib_groups li[class=active] a').attr('groupid')
	  	},
	  	success: function(data, textStatus, jqXHR){
	  		$.each(data, function(index, post){
	  			$.tmpl('<article class="row-fluid">\
	  				<div class="span1">${user.name}<img alt="Google" src="${user.image_url}" /></div>\
	  				<div class="span8"><div class="well"><blockquote>${content}</div></blockquote></div>\
	  				<div class="span1"><a href="/posts/${id}">Show</a></div>\
	  				<div class="span1"><a href="/posts/${id}/edit">Edit</a></div>\
	  				<div class="span1"><a href="/posts/${id}" data-confirm="Are you sure?" data-method="delete" rel="nofollow">Destroy</a></div>\
	  				</article>', post).appendTo( "#post_list" );
	  		});
	  	}
	  });
	});
});
