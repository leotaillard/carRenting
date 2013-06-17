$(document).ready(function() {

	var $_GET = getQueryParams(document.location.search);
	
	getParam($_GET);
	
	var make = $_GET['make'];
	var model = $_GET['model'];
	var etat = $_GET['etat'];
	var checkPrice = $_GET['checkPrice'];
	
	if (checkPrice) {
	
			var prixMin = $_GET['prixMin'];
			var prixMax = $_GET['prixMax'];
	}
	else {
		var prixMin = 0;
		var prixMax = 500000;
	}
	search(make,model,prixMin,prixMax,etat);
});

function search(make,model,prixMin,prixMax,etat) {
	
	var tpl = $("#tplSearch").html();
	$("#tplSearch").empty();
	$.ajax({
		  url: 'getSingle.xql',
		  data:{make:make,model:model,prixMin:prixMin,prixMax:prixMax,etat:etat},
		  success: function(data) {
		  if (data === null) {
			newH = $("<h2/>");
			newH.html("Il n'y a aucun résultats pour la recherche");
			$("#tplSearch").append(newH);
			$(".nbrResult").html("0");
			
		  }
		  else if (data.cars.length > 1) {
		  		$.each(data.cars, function(index, elem){
		  	  		$("#tplSearch").append(Mustache.render(tpl,elem));		  	  	
		  	  	});
  			  
  			  $(".nbrResult").html(data.cars.length);
		  	  		  	
		  }
		  else {
		  	$.each(data, function(index, elem){
		  			$("#tplSearch").append(Mustache.render(tpl,elem));
		  	});
			  $(".nbrResult").html("1");
		  	
		  }
		  	$("#tplSearch").removeClass("hidden");
		  	$("#sidebar").removeClass("hidden");
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
function getParam(get) {

	var tabParam = {};
	$.each(get,function(index,elem) {
		if (elem != "") {
			tabParam[index] = elem;
		}
	});
	$("#resume").empty();
	$.each(tabParam,function(index,elem) {
	
		if (elem != "on") {
			var newLi = $("<li/>",{text:index +" : "+elem});
			$("#resume").append(newLi);
			
		}
	
	});
}