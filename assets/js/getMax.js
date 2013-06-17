$(document).ready(function() {
	$.ajax({
		  url: 'test.xql',
		  success: function(data) {
			
			var prixMax = data.prix;
			
//			if (localStorage.getItem("prixMax") === null) {
//				localStorage.setItem("prixMax", prixMax);
//			}
//			else if (localStorage.getItem("prixMax") != data.prix) {
//				
//				localStorage.setItem("prixMax", prixMax);
//					
//				}
//			else {
//				localStorage.setItem("prixMax", prixMax);
//			}
//			localStorage.removeItem("prixMax");
		  }
	});
});
