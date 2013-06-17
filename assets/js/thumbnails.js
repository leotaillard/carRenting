$(document).ready(function() {
	thumbnail();

});
function thumbnail() {
	
	var tpl = $("#tplThumbnail").html();
	$("#tplThumbnail").empty();
	$.ajax({
		  url: 'queryThumbnail.xql',
		  success: function(data) {
		  
		  	$.each(data.cars, function(index, elem){

			  	$("#tplThumbnail").append(Mustache.render(tpl,{tplThumbnail:elem}));
			  		
			});
		  	$("#tplThumbnail").removeClass("hidden");
		  	$(".loading").addClass("hidden");
		  }
		  });
}