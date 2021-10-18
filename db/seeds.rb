# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
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

#Componenet ram
@componentes=Tipocomp.all
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

