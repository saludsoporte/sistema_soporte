$(document).on('turbolinks:load', function() {
    var ancho = screen.width;
    if (ancho < 500) {
        $("#tabla-respond").prop("hidden", false);
        $("#tabla-normal").prop("hidden", true);

    } else {
        $("#tabla-normal").prop("hidden", false);
        $("#tabla-respond").prop("hidden", true);
    }

});