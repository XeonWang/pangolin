var loadImageFile = (function () {
	if (window.FileReader) {
		var	oPreviewImg = null, oFReader = new window.FileReader(),
			rFilter = /^(?:image\/bmp|image\/cis\-cod|image\/gif|image\/ief|image\/jpeg|image\/jpeg|image\/jpeg|image\/pipeg|image\/png|image\/svg\+xml|image\/tiff|image\/x\-cmu\-raster|image\/x\-cmx|image\/x\-icon|image\/x\-portable\-anymap|image\/x\-portable\-bitmap|image\/x\-portable\-graymap|image\/x\-portable\-pixmap|image\/x\-rgb|image\/x\-xbitmap|image\/x\-xpixmap|image\/x\-xwindowdump)$/i;
		oFReader.onloadend = function (oFREvent) {
			$("#imagePreview img")[0].src = oFREvent.target.result;
		};

		return function () {
			var aFiles = document.getElementById("user_image_url").files;
			if (aFiles.length === 0) { return; }
			if (!rFilter.test(aFiles[0].type)) { alert("You must select a valid image file!"); return; }
			oFReader.readAsDataURL(aFiles[0]);
		}

	}
	if (navigator.appName === "Microsoft Internet Explorer") {
		return function () {
			document.getElementById("imagePreview").filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = document.getElementById("imageInput").value;
		}
	}
})();

jQuery(document).ready(function(){
	jQuery(function($) {
	    if($('#home_content_category').length){
	      loadContents('publish');
	    }
	});

	$('#home_content_category li a').click(this, function(event){
	  	var category = $(this).attr('category');
	  	loadContents(category);
	  	$('.active').removeClass('active');
	  	$(this).parent().addClass('active');
	  	return false;
	})
});

function loadContents(category){
	var url_map = {
		publish : '/users/published_posts',
		comment : '/comments/',
		forward : '/users/published_posts',
		favorite : '/users/published_posts'
	};

	$.ajax({
	  	url: url_map[category],
	  	success: updateContents
	});
}

function updateContents(data, textStatus, jqXHR){
	$('#home_content_list').empty();
	var jst = data.jst;
	data = data.data
	$.each(data, function(index, post){
		$.tmpl(jst, post).appendTo( "#home_content_list" );
	});

	// $('#home_content_list article blockquote').hover(addIntoLinkClass);
}