package body SensorLectorP is
   protected body SensorLector is

      --Inicia el sensor con un retraso de 0.3 segundos
      procedure iniciar is
      begin
         datoDisponible:=False;
         --Arranca a los 0.3 segundos
         nextTime:=Clock+Ada.Real_Time.Milliseconds(300);
         Ada.Real_Time.Timing_Events.Set_Handler(entradaJitterControl, nextTime, Timer'Access);
      end iniciar;

      --Obtengo el dato del buffer y lo devuelvo
      entry leer(dato:out SensorDato)
        when datoDisponible is
      begin
         dato:=leyendo;
         datoDisponible:=False;
      end leer;

      --Lee el dato utilizando "el sensor fisico simulado" para la produccion específica de la planta
      -- (objeto protegido) y lo carga en el buffer leyendo
      procedure Timer(event:in out Ada.Real_Time.Timing_Events.Timing_Event) is
      begin
         --Aqui obtenemos fisicamente el dato --> 0.15 segundos en abrir/cerrar dispositivo
         tiempo := Ada.Real_Time.Clock + Ada.Real_Time.Milliseconds(150);

         --obtener el dato y cargarlo en leyendo (buffer que vamos a utilizar)
         leyendo:=SensorDato(prodPlanta.getContador);
         datoDisponible:=True;

         delay until tiempo;

         --Volver a ejecutar el timer al segundo (entradaPeriodo = 1 seg)
         nextTime:=nextTime + entradaPeriodo;
         Ada.Real_Time.Timing_Events.Set_Handler(entradaJitterControl, nextTime, Timer'Access);
      end Timer;

   end SensorLector;
end SensorLectorP;


