
$(document).ready(function() {
var ancho=screen.width;
    if(ancho < 500){       
        $("#tabla-normal").prop("hidden",true);
        $("#tabla-respond").prop("hidden",false);
    } 
    else{
        $("#tabla-normal").prop("hidden",false);
        $("#tabla-respond").prop("hidden",true);
    }
});

