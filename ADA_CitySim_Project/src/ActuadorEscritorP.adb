package body ActuadorEscritorP is
   protected body ActuadorEscritor is

      procedure iniciar is
      begin
         escribiendo := False;
      end iniciar;


      procedure escribir(accion:Integer) is
      begin
         aumRedMant:=accion;

         if accion = 3 then
            null; --mantener
         else
            --escribiendo es un flag para evitar la llegada de 2 aumentar/disminuir a la vez
            -- y que se sobreescriba
            if escribiendo = False then
                --Esperar 0.6 seg para abrir/cerrar dispositivo en caso de aumentar
                -- o disminuir la produccion
               tiempo:=Clock + Ada.Real_Time.Milliseconds(600);
               delay until tiempo;

               escribiendo := True;
               nextTime:=Clock+Ada.Real_Time.Milliseconds(3000);
               Ada.Real_Time.Timing_Events.Set_Handler(salidaJitterControl, nextTime, Timer'Access);
            end if;
         end if;

      end escribir;


      procedure Timer(event:in out Ada.Real_Time.Timing_Events.Timing_Event) is
      begin
         --escribir dato escribiendo -> aqui aumento/reduzco la producción
         if aumRedMant = 1 then
            --Aumentar
            prodPlanta.increment;

         elsif aumRedMant = 2 then
            --Reducir
            prodPlanta.decrement;

         else
            --Mantener (aunque ya está tratado en el otro if, pero por si acaso)
            null;
         end if;

         escribiendo := False;
      end Timer;
   end ActuadorEscritor;

end ActuadorEscritorP;

