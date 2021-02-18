with Text_IO;
with Ada.Real_Time;
with Ada.Real_Time.Timing_Events;
with System;
use Ada.Real_Time;
use Ada.Real_Time.Timing_Events;
with Ada.Calendar;
with Calendar;
use Calendar;

with SensorLectorP;
use SensorLectorP;
with ActuadorEscritorP;
use ActuadorEscritorP;
with TareaPlantaP;
use TareaPlantaP;
with TareaCiudadP;
use TareaCiudadP;
with ContadoresProtegidos;
use ContadoresProtegidos;

procedure Main is
   ---------------------------------------------------------------------------------------------------------------------------------------
   -- PROCEDIMIENTOS QUE SIGUE EL ALGORITMO DE CONTROL PARA ABRIR/CERRAR LAS PLANTAS NECESARIAS
   ---------------------------------------------------------------------------------------------------------------------------------------
   procedure abrirPlantas(dif:Integer; p1:access TareaPlanta;da1:SensorDato; p2: access TareaPlanta;da2:SensorDato; p3: access TareaPlanta;da3:SensorDato) is
    begin
      if dif = -1 then
         if da1<30 then
            p1.escribir(1);
         elsif da2<30 then
            p2.escribir(1);
         else
            p3.escribir(1);
         end if;

      elsif dif = -2 then
         if da1<30 and da2<30 then
            p1.escribir(1);
            p2.escribir(1);

         elsif da1<30 and da3<30 then
            p1.escribir(1);
            p3.escribir(1);

         elsif da2<30 and da3<30 then
            p2.escribir(1);
            p3.escribir(1);
         end if;

      else
         p1.escribir(1);
         p2.escribir(1);
         p3.escribir(1);
      end if;

    end abrirPlantas;

   procedure cerrarPlantas(dif:Integer;p1:access TareaPlanta;da1:SensorDato; p2: access TareaPlanta;da2:SensorDato; p3: access TareaPlanta;da3:SensorDato) is
   begin
      if dif = 1 then
         if da1>0 then
            p1.escribir(2);
         elsif da2>0 then
            p2.escribir(2);
         else
            p3.escribir(2);
         end if;

      elsif dif = 2 then
         if da1>0 and da2>0 then
            p1.escribir(2);
            p2.escribir(2);

         elsif da1>0 and da3>0 then
            p1.escribir(2);
            p3.escribir(2);

         elsif da2>0 and da3>0 then
            p2.escribir(2);
            p3.escribir(2);
         end if;

      else
         p1.escribir(2);
         p2.escribir(2);
         p3.escribir(2);
      end if;
   end cerrarPlantas;

   ---------------------------------------------------------------------------------------------------------------------------------------
   -- ALGORTIMO DE CONTROL DE LAS PLANTAS --> CONTROLA LA PRODUCCIÓN, LA COMPARA CON EL CONSUMO DE LA CIUDAD Y ACTUA EN CONSECUENCIA
   ---------------------------------------------------------------------------------------------------------------------------------------
   task type AlgoritmoControlProduccion(planta1:access TareaPlanta; planta2: access TareaPlanta; planta3: access TareaPlanta; consumoC: access ConsumoCiudad);

   task body AlgoritmoControlProduccion is
      datoPlanta1:SensorDato;
      datoPlanta2:SensorDato;
      datoPlanta3:SensorDato;

      total:Integer;
      produccion:Integer;
      consumo:Integer;
      porcentajeDif:Float;

      intervalo:Ada.Real_Time.Time_Span:=Ada.Real_Time.Milliseconds(1000);

   begin
      loop
         produccion:=0;
         Text_IO.Put_Line("");
         --Text_IO.Put_Line("Tiempo control"&Calendar.Day_Duration'Image(Calendar.Seconds(Clock)));

         planta1.leer(datoPlanta1);
         produccion:=produccion+Integer(datoPlanta1);
         --Text_IO.Put_Line("   Planta1: "&datoPlanta1'Image);

         planta2.leer(datoPlanta2);
         produccion:=produccion+Integer(datoPlanta2);
         --Text_IO.Put_Line("   Planta2: "&datoPlanta2'Image);

         planta3.leer(datoPlanta3);
         produccion:=produccion+Integer(datoPlanta3);
         --Text_IO.Put_Line("   Planta3: "&datoPlanta3'Image);

         consumo:=consumoC.getConsumo;
         total:=produccion-consumo;

         porcentajeDif:=(Float(produccion)/Float(consumo)) * 100.0;
         --Text_IO.Put_Line("Produccion: "&produccion'Img&"   Consumo: "&consumo'Image&"    Total: "&total'Image&"    %Dif: "&porcentajeDif'Image);

         if porcentajeDif < 100.0 then
            --Más consumo que produccion
            if (100.0 - porcentajeDif) > 5.0 then
               Text_IO.Put_Line("PELIGRO BAJADA"&"   Consumo: "&consumo'Image&"   Produccion: "&produccion'Img);
            else
               Text_IO.Put_Line("ESTABLE"&"   Consumo: "&consumo'Image&"   Produccion: "&produccion'Img);
            end if;

         else
            --Más produccion que consumo (o igual)
            if (porcentajeDif-100.0) > 5.0 then
               Text_IO.Put_Line("PELIGRO SOBRECARGA"&"   Consumo: "&consumo'Image&"   Produccion: "&produccion'Img);
            else
               Text_IO.Put_Line("ESTABLE"&"   Consumo: "&consumo'Image&"   Produccion: "&produccion'Img);
            end if;
         end if;


         if total<0 then
            --Hay más consumo que producción
           abrirPlantas(total, planta1,datoPlanta1,planta2,datoPlanta2,planta3,datoPlanta3);

         elsif total>0 then
            --Hay más produccion que consumo
            cerrarPlantas(total,planta1,datoPlanta1,planta2,datoPlanta2,planta3,datoPlanta3);

         else
            --Misma produccion que consumo -> mantener
            planta1.escribir(3);
            planta2.escribir(3);
            planta3.escribir(3);
         end if;

      end loop;
   end AlgoritmoControlProduccion;




   ---------------------------------------------------------------------------------------------------------------------------------------
   -- INICIACIÓN PLANTAS, CIUDAD Y ALGORTIMO DE CONTROL
   ---------------------------------------------------------------------------------------------------------------------------------------
   t1, t2, t3:aliased TareaPlanta(15);
   consumoC:aliased ConsumoCiudad(35);
   ciudad:TareaCiudad(consumoC'Access);
   control:AlgoritmoControlProduccion(t1'Access, t2'Access, t3'Access, consumoC'Access);
begin
   null;
end Main;



