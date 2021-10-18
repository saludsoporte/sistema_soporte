$(document).ready(function() {
    $('select#relacion_sol_opt_opcion_id').on(
      'change',       
      function() {       
            var id_value_string = $("#relacion_sol_opt_opcion_id").val();                    
            cargaListaRelacion(id_value_string);
      }
    );      
    
    $('select#problema').on('click',
      function(){   
      
          $("#guardar").prop("disabled",false);
        
      })


  });

  function cargaListaRelacion(id_value_string){  
    
    $.ajax({         
         type:"get",
         dataType: "json",  
         cache: false,        
         url: 'carga_relacion',          
         data: { id : id_value_string },
         error: function(XMLHttpRequest, errorTextStatus, error) {
         console.log("Failed : " + errorTextStatus + " ;" + error);
         },
         success: function(data) {   
            var div="";
            var index=0;
            $.each(data,function()
            {
                div+="<option id="+data[index].id+" value = "+data[index].id+">"+data[index].nombre+"</option>";
                index++;
            });
            
            $("#problema").html(div);            
            console.log(data);
            console.log("entro");
         }
    });
}
