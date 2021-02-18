with Text_IO;
with Ada.Real_Time;
with Ada.Real_Time.Timing_Events;
with System;
use Ada.Real_Time;
use Ada.Real_Time.Timing_Events;
with Ada.Calendar;
with Calendar;
use Calendar;

with ContadoresProtegidos;
use ContadoresProtegidos;
with SensorLectorP;
use SensorLectorP;
with ActuadorEscritorP;
use ActuadorEscritorP;

package TareaPlantaP is
    task type TareaPlanta(produccionInicial:Integer) is
      --Consultar produccion
      entry leer(datoEntrada:out SensorDato);

      --Aumentar/Reducir/Mantener produccion
      entry escribir(accion:Integer);
   end TareaPlanta;
end TareaPlantaP;
