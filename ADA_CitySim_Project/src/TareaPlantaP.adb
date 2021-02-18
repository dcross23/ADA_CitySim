package body TareaPlantaP is
   task body TareaPlanta is
      produccionPlanta:aliased ContadorPlanta(produccionInicial);

      entrada:SensorLector(produccionPlanta'Access);
      salida:ActuadorEscritor(produccionPlanta'Access);

      escribirFlag:Boolean:=False;
      ac:Integer;

   begin
      entrada.iniciar;
      salida.iniciar;
      loop
         select
            --Recibimos mensaje para leer
            accept leer(datoEntrada:out SensorDato) do
               entrada.leer(datoEntrada);
            end leer;

         or
            --Recibimos mensaje para escribir
            accept escribir(accion:Integer) do
               ac:=accion;
               escribirFlag:=true;
            end escribir;

         or
              --No recibimos un mensaje en 5 segundos
              delay 5.0;
              Text_IO.Put_Line("ALERTA MONITORIZACION ENERGIA");

         end select;

         if escribirFlag then
            salida.escribir(ac);
            escribirFlag := false;
         end if;

      end loop;
   end TareaPlanta;
end TareaPlantaP;
