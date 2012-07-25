jQuery(document).ready(function(){
	jQuery(function($) {
	  if($('#subscrib_groups').length){
	    loadPosts(0);
	  }

	  $("#add_subscribe_group").bind("ajax:success", function(event, data, status, xhr) {
	      $("#subscrib_groups li:last").after($("<li>"+ data +"</li>"));
	      $('#myModal').modal('hide');
	      $("#add_subscribe_group").each (function(){
		  	this.reset();
		  });
	  });

	  $('#subscrib_groups li a').click(this, function(event){
	  	var group_id = $(this).attr('groupid');
	  	loadPosts(group_id);
	  	$('.active').removeClass('active');
	  	$(this).parent().addClass('active');
	  	return false;
	  })

	  $('article[type=comment] .btn').click(this, function(){
	  	var textarea = $(this).children('textarea');
	  	textarea.show().focus();
	  });

	  $('article[type=comment] .btn textarea').keypress(saveReply);

	});
});

function updatePostList(data, textStatus, jqXHR){
	$('#post_list').empty();
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

function loadPosts(group_id){
	$.ajax({
	  	url: '/posts/post_list',
	  	data: {
	  		group: group_id
	  	},
	  	success: updatePostList
	  });
}

function saveReply(event){
	var keycode = (event.keyCode ? event.keyCode : event.which);
	var me = $(this);
	if(keycode == '13'){
		me.hide();
		if($.trim(me.val())){
			$.ajax({
				url: '/posts/reply',
				type: 'post',
				data: {
					comment: me.attr('name'),
					content: me.val()
				},
				success: function(data, textStatus, jqXHR){
					afterReplySaved(data, textStatus, jqXHR, me);
				}
			});
		}
	}
}

function afterReplySaved(reply, textStatus, jqXHR, me){
	me.val("");
	$(me.closest('article')).children('details').first().append($.tmpl('<dl style="text-indent: 50px;">\
																			<dt>${username}</dt>\
																			<dd>${content}</dd>\
																		</dl>', {username: reply.user.name, content: reply.content}));
}
