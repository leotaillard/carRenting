$(document).ready(function() {


$( "#slider-range" ).slider({
            range: true,
            min: 0,
            max: 500000,
            values: [ 20000, 100000 ],
            step:2000,
            slide: function( event, ui ) {
            	$( "#amount" ).html( "$" + ui.values[ 0 ] + " -   $" + ui.values[ 1 ]);
				$( "#prixMin" ).val(ui.values[ 0 ]);
				$( "#prixMax" ).val(ui.values[ 1 ]);
			}
  });
	$( "#amount" ).html( "$" + $( "#slider-range" ).slider( "values", 0 ) + " - $" + $(  "#slider-range" ).slider( "values", 1 ) );
	$( "#prixMax" ).val($( "#slider-range" ).slider( "values", 1 ));
	$( "#prixMin" ).val($( "#slider-range" ).slider( "values", 0 ));
});
