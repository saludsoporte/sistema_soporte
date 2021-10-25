// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require jquery
//= require jquery_ujs
//= require popper
//= require rails-ujs
//= require turbolinks
//= require select2
//= require_tree .
import $ from 'jquery'
import 'select2'
import 'select2/dist/css/select2.css'
import "bootstrap"


require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");

$(document).on('turbolinks:load', function() {

    $("select#area").select2({
        placeholder: "Selecciona uno",
        allowClear: true
    });
    $("#direccion").select2({
        placeholder: "Selecciona uno",
        allowClear: true
    });
    $("#subdireccion").select2({
        placeholder: "Selecciona uno",
        allowClear: true
    });
    $("#departamento").select2({
        placeholder: "Selecciona uno",
        allowClear: true
    });
    $("#departamento").select2({
        placeholder: "Selecciona uno",
        allowClear: true
    });
    $("#unidad").select2({
        placeholder: "Selecciona uno",
        allowClear: true
    });
    $("#usuarios").select2({
        placeholder: "Selecciona uno",
        allowClear: true,
        clear: true,
        remove: true

    });
    $("#tecnicos").select2({
        placeholder: "Selecciona uno",
        allowClear: true,
        clear: true,
        remove: true

    });
    $("#usuarios_edit").select2({
        placeholder: "Selecciona uno",
        allowClear: true,
        clear: true,
        remove: true

    });
    $("#tecnicos_edit").select2({
        placeholder: "Selecciona uno",
        allowClear: true,
        clear: true,
        remove: true

    });
    $("#catalogo").select2({
        placeholder: "Selecciona uno",
        allowClear: true,
        clear: true,
        remove: true
    });
    $("#tipocomp_id").select2({
        placeholder: "Selecciona uno",
        allowClear: true,
        clear: true,
        remove: true,
        width: '100%'
    });
    $("#componente_id").select2({
        placeholder: "Selecciona uno",
        allowClear: true,
        clear: true,
        remove: true
    });
    $("#caracteristica_id").select2({
        placeholder: "Selecciona uno",
        allowClear: true
    });
    $("#caracteristica_id_edit").select2({
        placeholder: "Selecciona uno",
        allowClear: true
    });
    $("#usuarios_edit_n").select2({
        placeholder: "Selecciona uno",
        allowClear: true
    });
    $("#tipocomp_invt").select2({
        placeholder: "Selecciona uno",
        allowClear: true
    });

    $("#tipocomp_id_edit").select2({
        placeholder: "Selecciona uno",
        allowClear: true,
        clear: true,
        remove: true,
        width: '100%'
    });

    $("#equipos").select2({
        placeholder: "Selecciona uno",
        allowClear: true
    });

    $("#serial_id").select2({
        placeholder: "Selecciona uno",
        allowClear: true,
        clear: true,
        remove: true
    });

    $("#user_select").select2({
        placeolder: "Selecciona uno",
        allowClear: true,
        clear: true,
        remove: true
    })

    $("#marca").select2({
        placeholder: "Selecciona uno",
        allowClear: true,
        clear: true,
        remove: true
    })

    $("#user_select").val(null).trigger("change");
    $("#equipos").val(null).trigger("change");
    $("#caracteristica_id").val(null).trigger("change");
    $("#tipocomp_invt").val(null).trigger("change");
    $("#tipocomp_id").val(null).trigger("change");
    $("#usuarios").val(null).trigger("change");
    $("#tecnicos").val(null).trigger("change");
    $("#usuarios_edit_n").val(null).trigger("change");

    //$("#serial_id").val(null).trigger("change");


    $('#serial_id').on(
        'change',
        function() {
            var id_value_string = $("#serial_id").val();
            carga_caracteristicas(id_value_string);
        }
    );

    $('#tipocomp_id').on(
        'change',
        function() {
            var id_value_string = $("#tipocomp_id").val();
            carga_componentes(id_value_string);
        }
    );

    $('#componente_id').on(
        'change',
        function() {
            var id = $("#componente_id").val();
            carga_serial(id);
        }
    );

    $('#relacion').on('change', function() {
        var id = $("#relacion").val();
        var componente = $("#comp_id").val();
        $("#conjunto").val(id);
        carga_conjuntos(id, componente);
    });

    $("#relacion").val(null).trigger("change");

    $("#tipocomp_invt").on('change', function() {
        var val = $("#tipocomp_invt").val();
        var escritorio = $("#escritorio").val();
        if (val == escritorio) {
            $("#busqueda").prop("hidden", true);
            $("#busqueda_1").prop("hidden", true);
            $("#busqueda_2").prop("hidden", true);
            $("#busqueda_3").css("display", 'block');
            $("#busqueda_4").css("display", 'block');
            $("#busqueda_5").css("display", 'block');
        } else {

            $("#busqueda").prop("hidden", false);
            $("#busqueda_1").prop("hidden", false);
            $("#busqueda_2").prop("hidden", false);
            $("#busqueda_3").css("display", 'none');
            $("#busqueda_4").css("display", 'none');
            $("#busqueda_5").css("display", 'none');
        }
    });

    $("#usuarios").on('change', function() {
        var user = $("#usuarios").val();
        verifica_no_serie(user);
    })
    $("#equipos").on('change', function() {
        var user = $("#equipos").val();
        info_equipo(user);
    });
    //$("#usuarios").append('<option selected="selected">Selecciona uno</option>');
})

function validarSubmitCarc() {
    var band = false;
    if ($("#caracteristica_id").val() != null) {
        band = true;
    }
    if ($("#valor_caracteristica").val() != null) {
        band = true;
    }
    return band;
}

function info_equipo(id_equipo) {
    if (id_equipo == null) {
        alert("Equipo no encontrado");
    } else {
        $.ajax({
            type: "get",
            dataType: "json",
            cache: true,
            url: "buscar_eq",
            data: { id: id_equipo },
            error: function(XMLHttpRequest, errorTextStatus, error) {
                console.log("Failed: " + errorTextStatus + " ;" + error);
            },
            success: function(data) {
                console.log(data);
                if (data == false) {
                    $("#info_eq").html("Equipo sin asignacion");
                } else {
                    var div = "<table class='table table-sm'>" +
                        "<thead class='table-dark'><th>Serie</th>" +
                        "<th>Activo Fijo</th>" +
                        "<th>Tipo</th>" +
                        "<th>Piso</th>" +
                        "<th>Usuario</th></thead><tbody>";
                    var index = 0;
                    $.each(data, function() {
                        div += "<tr><td>" + data[index].serie + "</td>";
                        div += "<td>" + data[index].activo_fijo + "</td>";
                        div += "<td>" + data[index].tipo + "</td>";
                        div += "<td>" + data[index].piso + "</td>";
                        div += "<td>" + data[index].user + "</td>";
                    });
                    div += "</tbody></table>";
                    $("#info_eq").html(div);
                }
            }
        });
    }
}

function verifica_no_serie(id_user) {

    $.ajax({
        type: "get",
        dataType: "json",
        cache: false,
        url: 'buscar_user',
        data: { id: id_user },
        error: function(XMLHttpRequest, errorTextStatus, error) {
            console.log("Failed : " + errorTextStatus + " ;" + error);
        },
        success: function(data) {
            if (data == false) {
                alert("No tiene equipo asociado");
                $("#serie").val(null);
            } else {
                $("#serie").val(data.no_serie);
            }
        }
    });
}

function carga_conjuntos(id_val, componente) {

    $.ajax({
        type: "get",
        dataType: "json",
        cache: false,
        url: 'carga_conjunto?compo_id=' + componente + "&conjunto=" + id_val,
        data: { id: id_val },
        error: function(XMLHttpRequest, errorTextStatus, error) {
            console.log("Failed : " + errorTextStatus + " ;" + error);
        },
        success: function(data) {
            if (data == false) {
                $("#submit_con").prop("disabled", true);
            } else if (data == true) {
                $("#div_carac").html("");
                $("#submit_con").prop("disabled", false);
            } else if (data.length == 0) {
                $("#submit_con").prop("disabled", false);
            } else {

                var div = " <b>Características</b>";
                var index = 0;
                $.each(data, function() {
                    div += "<div class='row'><div class='col-sm' >" + data[index].caracteristica + "</div>" +
                        "<div class='col-sm'>" + data[index].valor + "</div></div>";
                    index++;
                });
                $("#caracteristicas").html(div);
                $("#submit_con").prop("disabled", false);
            }
        }
    });
}

function carga_caracteristicas(id_rel) {
    console.log(id_rel);
    $.ajax({
        type: "get",
        dataType: "json",
        cache: false,
        url: 'carga_caracteristicas?compo_id=' + id_rel,
        data: { id: id_rel },
        error: function(XMLHttpRequest, errorTextStatus, error) {
            console.log("Failed : " + errorTextStatus + " ;" + error);
        },
        success: function(data) {

            $("#disponible").html("Disponible");
            $("#submit").show();
            var div = "";
            var index = 0;
            $.each(data, function() {

                div += "<div class='row'><div class='col-sm'>" + data[index].caracteristica + "</div>" +
                    "<div class='col-sm'>" + data[index].valor + "</div></div>";

                index++;
            });

            $("#caracteristicas").html(div);
            console.log(data);
            console.log("entro");
        }
    });
}

function carga_serial(id_rel) {
    if (id_rel == null) {
        console.log(id_rel);
    } else {
        $.ajax({
            type: "get",
            dataType: "json",
            cache: false,
            url: 'carga_serial?compo_id=' + id_rel,
            data: { id: id_rel },
            error: function(XMLHttpRequest, errorTextStatus, error) {
                console.log("Failed : " + errorTextStatus + " ;" + error);
            },
            success: function(data) {

                if (data.length != 0) {
                    var div = "";
                    var index = 0;
                    $("#submit").show();
                    $.each(data, function() {

                        div += "<option id=" + data[index].id + " value = " + data[index].id + "> No. Serie: " + data[index].serial + " | No. Activo Fijo: " +
                            data[index].activo_fijo + "</option>";
                        index++;
                    });
                    $("#serial_id").html(div);
                    $("#serial_id").val(null).trigger("change");
                    $("#serial_id").prop("disabled", false);

                    console.log(data);
                    console.log("entro");
                } else {

                    $("#submit").hide();
                }
            }
        });
    }
}

function carga_componentes(id_value_string) {

    $.ajax({
        type: "get",
        dataType: "json",
        cache: false,
        url: 'carga_componente',
        data: { id: id_value_string },
        error: function(XMLHttpRequest, errorTextStatus, error) {
            console.log("Failed : " + errorTextStatus + " ;" + error);
        },
        success: function(data) {
            var div;
            var index = 0;
            $.each(data, function() {
                div += "<option id=" + data[index].id + " value = " + data[index].id + "> Modelo: " + data[index].modelo + " , Marca: " +
                    data[index].marca + "</option>";
                index++;
            });
            $("#componente_id").html(div);
            $("#componente_id").val(null).trigger("change");
            $("#componente_id").prop("disabled", false);
            console.log(data);
            console.log("entro comp");
        }
    });
}