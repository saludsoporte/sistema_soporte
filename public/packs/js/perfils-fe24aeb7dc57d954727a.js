/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "/packs/";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = "./app/javascript/packs/perfils.js");
/******/ })
/************************************************************************/
/******/ ({

/***/ "./app/javascript/packs/perfils.js":
/*!*****************************************!*\
  !*** ./app/javascript/packs/perfils.js ***!
  \*****************************************/
/*! no static exports found */
/***/ (function(module, exports) {

$(document).ready(function () {
  cargar_tabla();
  $('select#perfil_id_rol').on('change', function () {
    var id_value_string = $("#perfil_id_rol").val();
    cargaListaRelacion(id_value_string);
  });
  $('button#permisos').on('click', function () {
    cargaListaRelacion(-1);
  });
});

function cargaListaRelacion(id_value_string) {
  // Send the request and update course dropdown    
  $.ajax({
    type: "get",
    dataType: "json",
    cache: false,
    url: 'carga_relacion',
    data: {
      id: id_value_string
    },
    error: function error(XMLHttpRequest, errorTextStatus, _error) {
      console.log("Failed : " + errorTextStatus + " ;" + _error);
    },
    success: function success(data) {
      var div = "";
      var index = 0;
      $.each(data, function () {
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
    data: {
      screen: ancho,
      id_p: id_p
    },
    error: function error(XMLHttpRequest, errorTextStatus, _error2) {
      console.log("Failed : " + errorTextStatus + " ;" + _error2);
    },
    success: function success(data) {
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
  var div = '<table id = "tabla-normal" class = "borde-reporte letra container table table-striped letra tabla-resp" >';
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
    div += "Sin área asociada";
  } else {
    div += "" + data.area + "";
  }

  div += "</div>  <div class ='borde-renglon-perfil dropdown-item'> <b>Dirección:</b><br>";

  if (data.direccion == null) {
    div += "Sin dirección asociada";
  } else {
    div += "" + data.direccion + "";
  }

  div += "</div><div class ='borde-renglon-perfil dropdown-item'><b> Subdirección: </b><br>";

  if (data.subdireccion == null) {
    div += "Sin subdireccion asociada";
  } else {
    div += "" + data.subdireccion + "";
  }

  div += "</div><div class = ' borde-renglon-perfil dropdown-item'><b> Departamento: </b><br>";

  if (data.departamento == null) {
    div += "Sin departamento asociado";
  } else {
    div += "" + data.departamento + "";
  }

  div += "</div><div class ='borde-renglon-perfil dropdown-item'><b>Correo:</b><br>" + data.email + "</div>";
  div += "</div></div>";
  $("#tabla-respond").html(div);
}

/***/ })

/******/ });
//# sourceMappingURL=perfils-fe24aeb7dc57d954727a.js.map