with System;
with Ada.Real_Time;
use Ada.Real_Time;
with Ada.Real_Time.Timing_Events;
use Ada.Real_Time;
with Ada.Calendar;
with Calendar;
with Text_IO;

with ContadoresProtegidos;
use ContadoresProtegidos;

package ActuadorEscritorP is
   type ActuadorDato is new Integer;

   protected type ActuadorEscritor(prodPlanta: access ContadorPlanta) is

      pragma Interrupt_Priority(System.Interrupt_Priority'Last);
      procedure iniciar;
      procedure escribir(accion:Integer);
      procedure Timer(event: in out Ada.Real_Time.Timing_Events.Timing_Event);

   private
      escribiendo:Boolean;
      aumRedMant:Integer;

      nextTime:Ada.Real_Time.Time;
      tiempo:Ada.Real_Time.Time;
      salidaJitterControl:Ada.Real_Time.Timing_Events.Timing_Event;

   end ActuadorEscritor;
end ActuadorEscritorP;

