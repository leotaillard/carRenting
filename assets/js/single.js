$(document).ready(function() {

	var $_GET = getQueryParams(document.location.search);
	var make = $_GET['make'];
	var model = $_GET['model'];
	var name = $_GET['name'];
	
	single(make,model,name);
	
});
function single(make,model,name) {
	
	var tpl = $("#tplSingle").html();
	$("#tplSingle").empty();
	$.ajax({
		  url: 'getSingle.xql',
		  data:{make:make,model:model,name:name},
		  success: function(data) {
		  	if (data === null) {
				newP = $("<p/>");
				newP.html("il n'y a aucun résultats pour la recherche");
				$("#tplSingle").append(newP);
		  	}
		  	else {
		  		
		  	$.each(data, function(index, elem){
			  	$("#tplSingle").append(Mustache.render(tpl,{tplSingle:elem}));
			  		
			});
		  	}
			
		  	$("#tplSingle").removeClass("hidden");
			$(".loading").addClass("hidden");
		  	
		  }
		  });
}
// récupère les params en GET pour les mettre dans un tab
function getQueryParams(qs) {
    qs = qs.split("+").join(" ");
    var params = {},
        tokens,
        re = /[?&]?([^=]+)=([^&]*)/g;

    while (tokens = re.exec(qs)) {
        params[decodeURIComponent(tokens[1])]
            = decodeURIComponent(tokens[2]);
    }

    return params;
}

