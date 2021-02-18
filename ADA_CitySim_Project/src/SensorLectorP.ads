with System;
with Text_IO;
with Ada.Real_Time;
use Ada.Real_Time;
with Ada.Real_Time.Timing_Events;
use Ada.Real_Time;
with Ada.Calendar;
with Calendar;

with ContadoresProtegidos;
use ContadoresProtegidos;


package SensorLectorP is
   type SensorDato is new Integer;

   protected type SensorLector(prodPlanta: access ContadorPlanta) is

      pragma Interrupt_Priority(System.Interrupt_Priority'Last);
      procedure iniciar;
      entry leer(dato:out SensorDato);
      procedure Timer(event: in out Ada.Real_Time.Timing_Events.Timing_Event);

   private
      leyendo:SensorDato:=SensorDato(prodPlanta.getContador); --Buffer a leer inicialmente con 10mw
      datoDisponible:Boolean:=True;

      nextTime:Ada.Real_Time.Time;
      tiempo:Ada.Real_Time.Time;
      entradaJitterControl:Ada.Real_Time.Timing_Events.Timing_Event;

      -- 1seg entre lecturas
      entradaPeriodo:Ada.Real_Time.Time_Span:=Ada.Real_Time.Milliseconds(1000);

   end SensorLector;
end SensorLectorP;

