$(document).ready(function() {
    cargar_tabla();
    $('select#perfil_id_rol').on(
        'change',
        function() {
            var id_value_string = $("#perfil_id_rol").val();
            cargaListaRelacion(id_value_string);
        }
    );
    $('button#permisos').on(
        'click',
        function() {
            cargaListaRelacion(-1);
        }
    );
});

function cargaListaRelacion(id_value_string) {
    // Send the request and update course dropdown    
    $.ajax({
        type: "get",
        dataType: "json",
        cache: false,
        url: 'carga_relacion',
        data: { id: id_value_string },
        error: function(XMLHttpRequest, errorTextStatus, error) {
            console.log("Failed : " + errorTextStatus + " ;" + error);
        },
        success: function(data) {
            var div = "";
            var index = 0;
            $.each(data, function() {
                div += "<p>" + data[index] + "</p>";
                index++;
            });

            $("#list_permisos").html(div);
            console.log(data);
            console.log("entro");
        }
    });
}

function cargar_tabla() {
    // Send the request and update course dropdown    
    var id_p = $("#id_p").val();
    var ancho = screen.width;
    $.ajax({
        type: "get",
        dataType: "json",
        cache: false,
        url: 'cargar_tabla',
        data: { screen: ancho, id_p: id_p },
        error: function(XMLHttpRequest, errorTextStatus, error) {
            console.log("Failed : " + errorTextStatus + " ;" + error);
        },
        success: function(data) {
            if (data[1].screen) {
                tabla_respond(data[0]);
            } else {
                tabla_normal(data[0]);
            }
            console.log(data);
        }
    });
}

function tabla_normal(data) {
    var div = '<table id = "tabla-normal" class = "borde-reporte letra  table-sm table table-striped letra tabla-resp" >';
    div += '<thead class = "table-dark" ><th> Rol </th> <th> Nombre </th> <th> Nombre de Usuario </th> <th> Área </th> <th > Dirección </th>';
    div += '<th > Subdirección </th> <th> Departamento </th> <th > Correo </th> </thead> <tbody><tr ><td >' + data.rol;
    div += '</td> <td >' + data.nombre_personal + '</td> <td >' + data.username + '</td>';
    div += "<td>" + data.area + "</td>";
    div += "<td>" + data.direccion + "</td>";
    div += "<td>" + data.subdireccion + "</td>";
    div += "<td>" + data.departamento + "</td>";
    div += '<td>' + data.email + '</td> </tr> </tbody> </table>';
    $("#tabla-respond").html(div);
}

function tabla_respond(data) {
    var div = "<div id = 'tabla-respond' class = 'letra dropdown navbar navbar-expand-lg navbar-light borde-reporte' >";
    div += "<button id = 'btn-menu' class = 'btn dropdown-toggle' type = 'button' id = 'dropdownMenuButton' data-toggle ='dropdown' aria-haspopup = 'true' aria-expanded = 'false' >";
    div += "Ver Perfil </button> <div class = 'dropdown-menu b-black menu-perfil' aria-labelledby = 'dropdownMenuButton' >";
    div += "<div class = ' borde-renglon-perfil dropdown-item'> <b> Rol: </b><br>" + data.rol + "</div>";
    div += "<div class ='borde-renglon-perfil dropdown-item' > <b> Nombre de usuario: </b><br>" + data.username + "</div>";
    div += "<div class ='borde-renglon-perfil dropdown-item'> <b> Nombre personal: </b><br>" + data.nombre_personal + "</div>";
    div += "<div class ='borde-renglon-perfil dropdown-item' > <b > Área: </b><br>";
    if (data.area == null) {
        div += "Sin área asociada"
    } else {
        div += "" + data.area + "";
    }
    div += "</div>  <div class ='borde-renglon-perfil dropdown-item'> <b>Dirección:</b><br>";
    if (data.direccion == null) {
        div += "Sin dirección asociada"
    } else {
        div += "" + data.direccion + "";
    }
    div += "</div><div class ='borde-renglon-perfil dropdown-item'><b> Subdirección: </b><br>";
    if (data.subdireccion == null) {
        div += "Sin subdireccion asociada"
    } else {
        div += "" + data.subdireccion + "";
    }
    div += "</div><div class = ' borde-renglon-perfil dropdown-item'><b> Departamento: </b><br>";
    if (data.departamento == null) {
        div += "Sin departamento asociado"
    } else {
        div += "" + data.departamento + "";
    }
    div += "</div><div class ='borde-renglon-perfil dropdown-item'><b>Correo:</b><br>" + data.email + "</div>";
    div += "</div></div>";
    $("#tabla-respond").html(div);
}