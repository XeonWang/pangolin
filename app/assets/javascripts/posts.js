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

	  $("#posts_head form").bind("ajax:success", function(event, data, status, xhr) {
	  	  var group_id = $('#subscrib_groups li.active').children('a').attr('groupid');
	      loadPosts(group_id);
	      this.reset();
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
	var jst = data.jst;
	data = data.data
	$.each(data, function(index, post){
		$.tmpl(jst, post).appendTo( "#post_list" );
	});

	$('#post_list article blockquote').hover(addIntoLinkClass);
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
	$(me.closest('article')).children('details').first().append($.tmpl('<dl>\
																			<dt>${username}</dt>\
																			<dd>${content}</dd>\
																		</dl>', {username: reply.user.name, content: reply.content}));
}

function addIntoLinkClass(){
	$(this).toggleClass('link_into');
}


