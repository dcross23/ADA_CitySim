with Text_IO;
with Ada.Real_Time;
with Ada.Real_Time.Timing_Events;
with System;
use Ada.Real_Time;
use Ada.Real_Time.Timing_Events;
with Ada.Calendar;
with Calendar;
use Calendar;
with Ada.Numerics.Discrete_Random;

with ContadoresProtegidos;
use ContadoresProtegidos;

package TareaCiudadP is
   task type TareaCiudad(consumo:access ConsumoCiudad);
end TareaCiudadP;
