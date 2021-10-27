# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if !Caracteristica.where("nombre in ('Frecuencia','Tipo de Memoria','Velocidad de Lectura','Voltaje',
    'Socket','Resolución','Pulgadas','Lenguaje','Nucleos','Cache','Puerto','Capacidad de Memoria','Tipo de Disco Duro')").count == 13
Caracteristica.create([
    {nombre:"Frecuencia"},
    {nombre:"Tipo de Memoria"},
    {nombre:"Velocidad de Lectura"},
    {nombre:"Voltaje"},
    {nombre:"Socket"},
    {nombre:"Resolución"},
    {nombre:"Pulgadas"},
    {nombre:"Lenguaje"},
    {nombre:"Nucleos"},
    {nombre:"Cache"},
    {nombre:"Puerto"},
    {nombre:"Capacidad de Memoria"},
    {nombre:"Tipo de Disco Duro"}
])  
end
if !Tipocomp.where("nombre in ('Disco Duro','Monitor','Teclado','Procesador',
        'Ram','Tarjeta Madre','Equipo de Computo','Servidor','Salida de Video','Sistema Operativo')").count == 10
Tipocomp.create([
    {nombre:"Disco Duro"},
    {nombre:"Monitor"},
    {nombre:"Teclado"},
    {nombre:"Procesador"},
    {nombre:"Ram"},
    {nombre:"Tarjeta Madre"},
    {nombre:"Equipo de Computo"},
    {nombre:"Servidor"},    
    {nombre:"Salida de Video"},
    {nombre:"Sistema Operativo"}])
end 
#Componenet ram
@componentes=Tipocomp.where("nombre in ('Disco Duro','Monitor','Teclado','Procesador',
    'Ram','Tarjeta Madre','Equipo de Computo','Servidor','Salida de Video','Sistema Operativo')")
@componentes.each do |co|
    Componente.create([
        {tipocomp_id:co.id,
            modelo:"All in one",
            marca:"All in one",
        }])
    Inventario.create(          
            [{tipocomp_id:co.id,
            cantidad:0,
            disponibles:0          
            }])    
end

