package body ContadoresProtegidos is
   --Contador protegido para la produccion independiente de las plantas
   protected body ContadorPlanta is
      function getContador return Integer is
      begin
         return contador;
      end getContador;

      entry increment
         when contador<MAX_PRODUCCION is
      begin
            contador:=contador+1;
      end increment;

      entry decrement
         when contador>MIN_PRODUCCION is
      begin
            contador:=contador-1;
      end decrement;

   end ContadorPlanta;



   --Contador protegido para el consumo de la ciudad
   protected body ConsumoCiudad is
      function getConsumo return Integer is
      begin
         return contador;
      end getConsumo;

      procedure add(valor:Integer) is
      begin
         if (contador+valor)>MAX_CONSUMO then
            contador:=MAX_CONSUMO;

         elsif (contador+valor)<MIN_CONSUMO then
            contador:=MIN_CONSUMO;

         else
            contador:=contador+valor;
         end if;
      end add;

   end ConsumoCiudad;

end ContadoresProtegidos;
