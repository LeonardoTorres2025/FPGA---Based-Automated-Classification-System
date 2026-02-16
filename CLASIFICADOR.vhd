library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity CLASIFICADOR is
 Port ( fr : in  STD_LOGIC_VECTOR (15 downto 0);
		  fa : in  STD_LOGIC_VECTOR (15 downto 0);
		  fv : in  STD_LOGIC_VECTOR (15 downto 0);
		  sw : out  STD_LOGIC_VECTOR (2 downto 0));
end CLASIFICADOR;	

architecture Behavioral of CLASIFICADOR is
--constant lower:std_logic_vector(15 downto 0) := "?0000010001110111?"; --1143
--constant upper:std_logic_vector(15 downto 0) := "?0000010101110101?"; --1397


begin

   process(fr, fa, fv)
    begin
--		  --M&Ms AMARILLO
      if   (to_integer(unsigned(fr)) >= 2210) and (to_integer(unsigned(fr)) <= 2701) and     --amarillo fcentral rojo 2456
	    	  (to_integer(unsigned(fa)) >= 1945) and (to_integer(unsigned(fa)) <= 2378) and  	--amarillo fcentral azul 2350
           (to_integer(unsigned(fv)) >= 2088) and (to_integer(unsigned(fv)) <= 2552) then     	--amarillo fcentral verde 2320

				sw<="001";	
      else

				sw<="000";
  		end if;

			--M&Ms AZUL
			if (to_integer(unsigned(fr)) >= 1688) and (to_integer(unsigned(fr)) <= 2063) and  	--azul fcentral rojo 1876
				(to_integer(unsigned(fa)) >= 2405) and (to_integer(unsigned(fa)) <= 2940) and  	--azul fcentral azul 2673
			   (to_integer(unsigned(fv)) >= 1885) and (to_integer(unsigned(fv)) <= 2304) then     	--azul fcentral verde 2095
				sw<="010";
        else
				sw<="000";
        end if;



    end process;
	 
end Behavioral;

