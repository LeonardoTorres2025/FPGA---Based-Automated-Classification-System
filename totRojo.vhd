
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity totRojo is
    Port ( enable : in  STD_LOGIC;
			  f : in  STD_LOGIC_VECTOR (7 downto 0);
			  F_total_rojo : out  STD_LOGIC_VECTOR (15 downto 0);
			  F_total_azul : out  STD_LOGIC_VECTOR (15 downto 0);
			  F_total_verde : out  STD_LOGIC_VECTOR (15 downto 0);			  
			  s_r : out  STD_LOGIC; 
			  finish : out  STD_LOGIC;
			  filtro :in  STD_LOGIC_VECTOR (1 downto 0);			  
			  clk : in  STD_LOGIC);
end totRojo;

architecture Behavioral of totRojo is


signal me: std_logic_vector(15 downto 0); 
signal t2: std_logic_vector(4 downto 0);

begin


--necesitamos un contador lento que cuando llegue al 7 binario
--lea los 8 bits menos significativos

--necesitamos un contador lento que cuando llegue al 10 binario
--lea los 8 bits mas significativos

--contador del 0 al 15
process(clk, filtro, enable)
begin
	if (rising_edge(clk))then
		t2 <= t2+1;
		finish<='0';	
		
--			if    (t2="0001") then	--1
--				s_r<='0';
--			elsif (t2="0100") then	--4	
--				me(7 downto 0) <= f;			
--				finish<='0';
--			elsif (t2="1001") then	--9
--				s_r<='1';	
--				finish<='0';
--			elsif (t2="1101") then	--13
--				me(15 downto 8) <= f;	
--				finish<='0';	
--			elsif (t2="1111") then	--15

			if    (t2="10100") then	--20
				s_r<='0';
				finish<='0';			
			elsif (t2="10110") then	--22	
				me(7 downto 0) <= f;			
				finish<='0';
			elsif (t2="11000") then	--24				
				s_r<='1';	
				finish<='0';
			elsif (t2="11001") then	--25				
				s_r<='1';	
				finish<='0';				
			elsif (t2="11010") then	--26
				s_r<='1';
				me(15 downto 8) <= f;	
				finish<='0';	
			elsif (t2="11100") then	--28
				s_r<='0';
				--F_total<=me;	

				case filtro is
					when "00" => 
						F_total_rojo<=me;	
						finish<='1';	
						t2 <= "00000";
					when "01" =>
						F_total_azul<=me;	
						finish<='1';	
						t2 <= "00000";
					when "10" =>					
						F_total_verde<=me;	
						finish<='1';	
						t2 <= "00000";
					when others =>					
						t2 <= "00000";
				end case;		
			end if;
	end if;
	
if (enable='0')then
		
		t2 <= "00000";
		
end if;	
	
	
	
	
end process;



end Behavioral;
