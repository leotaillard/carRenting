$(document).ready(function() {
	$(".model").hide();
	getMark();
	$(".mark").change(getModel);
	getMarkAdvanced();
	$(".markAdvanced").change(getModelAdvanced);
	$(".modelAdvanced").hide();
	getEtat();
});

function getMark(){
	$(".mark").empty();
	
	$.ajax({
		  url: 'queryMark.xql',
		  success: function(data) {
		  	$.each(data.Marque, function(index, elem){
			
			newOpt = $("<option />").html(elem);
			$(".mark").append(newOpt);
		  	});
			$(".mark").trigger("change");  
	
		  }
	});
//	newOpt2 = $("<option />",{value:"",text:"- toutes les marques -"});
//	$(".mark").append(newOpt2);
	
	}
function getEtat(){
	$(".etat").empty();
	
	$.ajax({
		  url: 'getEtat.xql',
		  success: function(data) {
		  	$.each(data.etat, function(index, elem){
			
			newOpt = $("<option />").html(elem);
			$(".etat").append(newOpt);
		  	});
	
		  }
	});
	newOpt2 = $("<option />",{value:"",text:"- tout les états -"});
	$(".etat").append(newOpt2);
	
	}

function getModel(){
	var mark = $(".mark").val();
	$(".model").empty();
	$.ajax({
		  url: 'queryModel.xql',
		  data: {make:mark},
		  success: function(data) {
		  
		  	if ($.isArray(data.modele)) {
  			  	$.each(data.modele, function(index, elem){
  		
  				newOpt = $("<option />",{val:elem.nom}).html(elem.nom+" ("+elem.nombre+")");
  				$(".model").append(newOpt);
  			  	});
  		
		  	}
		  	else {
				newOpt = $("<option />",{val:data.modele.nom}).html(data.modele.nom+" ("+data.modele.nombre+")");
				$(".model").append(newOpt);
		  	}
			
	
		  }
	});
	
		newOpt2 = $("<option />",{value:"",text:"- tout les modèles -"});
		$(".model").append(newOpt2);
		
		$(".model").show();
	
}
function getMarkAdvanced(){
	$(".markAdvanced").empty();
	
	$.ajax({
		  url: 'queryMark.xql',
		  success: function(data) {
		  	$.each(data.Marque, function(index, elem){
			
			newOpt = $("<option />").html(elem);
			$(".markAdvanced").append(newOpt);
		  	});
			$(".markAdvanced").trigger("change");  
	
		  }
	});
	
}
function getModelAdvanced(){
	var mark = $(".markAdvanced").val();
	$(".modelAdvanced").empty();
	$.ajax({
		  url: 'queryModel.xql',
		  data: {make:mark},
		  success: function(data) {
		  
		  	if ($.isArray(data.modele)) {
  			  	$.each(data.modele, function(index, elem){
  		
  				newOpt = $("<option />",{val:elem.nom}).html(elem.nom+" ("+elem.nombre+")");
  				$(".modelAdvanced").append(newOpt);
  			  	});
  		
		  	}
		  	else {
				newOpt = $("<option />",{val:data.modele.nom}).html(data.modele.nom+" ("+data.modele.nombre+")");
				$(".modelAdvanced").append(newOpt);
		  	}
			
	
		  }
	});
	
		newOpt2 = $("<option />",{value:"",text:"tout les modèles"});
		$(".modelAdvanced").append(newOpt2);
		
		$(".modelAdvanced").show();
	
}
