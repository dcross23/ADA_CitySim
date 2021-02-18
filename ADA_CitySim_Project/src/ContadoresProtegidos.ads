package ContadoresProtegidos is

   --Contador protegido para la produccion independiente de las plantas
   protected type ContadorPlanta(valorInicial:Integer) is
      function getContador return Integer;
      entry increment;
      entry decrement;

   private
      MIN_PRODUCCION:Integer := 0;
      MAX_PRODUCCION:Integer := 30;

      contador:Integer:=valorInicial;

   end ContadorPlanta;



   --Contador protegido para para el consumo de la ciudad
    protected type ConsumoCiudad(valorInicial:Integer) is
      function getConsumo return Integer;
      procedure add(valor:Integer);

    private
       MIN_CONSUMO:Integer := 15;
       MAX_CONSUMO:Integer := 90;
       contador:Integer:=valorInicial;
    end ConsumoCiudad;

end ContadoresProtegidos;
