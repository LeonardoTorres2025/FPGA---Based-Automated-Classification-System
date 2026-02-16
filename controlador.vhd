
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity controlador is

    Port ( filtro: out STD_LOGIC_VECTOR(1 downto 0);
			  s0: out  STD_LOGIC;
			  s1: out  STD_LOGIC;
			  s2: out  STD_LOGIC;
			  s3: out  STD_LOGIC; 
			  enable_a: out STD_LOGIC; 
			  finish_c: in STD_LOGIC;
			  clk : in  STD_LOGIC);

end controlador;

architecture Behavioral of controlador is

--Declaro variables de estado
type estados is (inicio, estado1, estado2);
signal presente, siguiente: estados;

--Signal de divisor de frecuencia
signal q: std_logic_vector(25 downto 0);
signal t2: std_logic_vector(3 downto 0);




begin
------------------------------------------------------
--reloj de la maquina de estados
process(clk,siguiente)
begin
	if rising_edge(clk) then
		t2 <= t2+1;
			if (t2="0001") then	--1100
				presente <= siguiente;
				t2<="0000";
			end if;
	end if;
end process;
------------------------------------------------------
--Divisor de frecuencia del sensor
	s0 <= '0';
	s1 <= '1';
	
	-- estados y las transiciones 
	process(presente) --AQUI SE AGREGAN LAS POSICIONES DE LOS SERVOS
	begin
		case presente is 
-------------------------------------------------------------------		
			when inicio => 		--rojo	
---------------
				s3 <='0';
				s2 <='0';
---------------		

				filtro <="00";
				
				enable_a <='1';			------Activa la lectura de frecuencia
				
				if (finish_c='0') then 
					siguiente <= inicio;	
				else
					enable_a <='0';		------Desactiva la lectura de frecuencia		
					siguiente <= estado1;
				end if;
-------------------------------------------------------------------				
			when estado1 =>		--azul
-----------------
				s3 <='1';
				s2 <='0';
-------------------				
				
				filtro <="01";				
				
				enable_a <='1';			------Activa la lectura de frecuencia
								
				if (finish_c='0') then 
					siguiente <= estado1;	
				else
					enable_a <='0';		------Desactiva la lectura de frecuencia			
					siguiente <= estado2;
				end if;				
-------------------------------------------------------------------				
			when estado2 => 		--verde
---------------			
				s3 <='1';
				s2 <='1';
---------------

				filtro <="10";
				
				enable_a <='1';			------Activa la lectura de frecuencia
				
				if (finish_c='0') then 
					siguiente <= estado2;	
				else
					enable_a <='0';		------Desactiva la lectura de frecuencia				
					siguiente <= inicio;
				end if;


		end case;
	end process;



end Behavioral;



