package body TareaCiudadP is
   task body TareaCiudad is

      subtype aleatorioReactor is Integer range -3..3;
      package Aleatorio is new Ada.Numerics.Discrete_Random(aleatorioReactor);
      seed : Aleatorio.Generator;
      tiempo: Ada.Real_Time.Time;

   begin
      tiempo:=Ada.Real_Time.Clock + Ada.Real_Time.Milliseconds(6000);
      loop
         delay until tiempo;

         Aleatorio.Reset(seed);
         consumo.add(Aleatorio.Random(seed));

         tiempo := tiempo + Ada.Real_Time.Milliseconds(6000);
      end loop;


   end TareaCiudad;
end TareaCiudadP;
