$(function() {
  	// TERRIBLE CODE INCOMING!
 //  	$('.pagination a, .sort_link').on('click', function(e){
	//   	e.preventDefault();
	//   	e.stopImmediatePropagation()
	//     // Extracts the next page number from the url so that pagination can occur via POST
	//     // Extracts the sort order from the url so that sorting can occur via POST
	//     var url = e.target.href,
	// 	    sort_index_start = url.indexOf('s%5D='),
	// 	    sort_index_end   = url.indexOf('&', sort_index_start),
	// 	    sort_order       = url.substring(sort_index_start+5, sort_index_end).replace("+", " "),
	// 	    nextPage 		 = $.urlParam('page', e.target.href);

	//     if (sort_index_end != -1 && sort_index_start != -1)
	//     	$('form').append("<input type='text' name='q[s]' value='" + sort_order + "' hidden='true'/>");
	//     if (nextPage)
	//     	$('form').append("<input type='text' name='page' value='" + nextPage + "' hidden='true'/>");
	//     $('form').submit();
	// });

	if (($(document).find('div .alert').length != 0) && ($(document).find('#search-bar, #sidebar').length != 0)) {
		$('div .alert').css({"position":"fixed","left":"0px","top":"50px","width":"100%","z-index":"1000"});
		$('#search-bar, #sidebar, #content-container').css({"top": "100px"});
	}
});

$.urlParam = function(name, url){
	var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(url);
	if (results==null){
		return null;
	}
	else{
		return results[1] || 0;
	}
}