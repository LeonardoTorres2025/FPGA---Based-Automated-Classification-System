library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity totAzul is
    Port ( enable : in  STD_LOGIC;
			  f : in  STD_LOGIC_VECTOR (7 downto 0);
			  F_total : out  STD_LOGIC_VECTOR (15 downto 0);
			  s_r : out  STD_LOGIC; 
			  finish : out  STD_LOGIC;    
			  clk : in  STD_LOGIC);
end totAzul;

architecture Behavioral of totAzul is

signal me: std_logic_vector(15 downto 0); --menos significativo
signal t2: std_logic_vector(3 downto 0);

begin

--necesitamos un contador lento que cuando llegue al 7 binario
--lea los 8 bits menos significativos

--necesitamos un contador lento que cuando llegue al 10 binario
--lea los 8 bits mas significativos

--contador del 0 al 15
process(clk)
begin
	if (rising_edge(clk) and enable='1')then
		t2 <= t2+1;
--		finish<='0';	
		
			if    (t2="0001") then	--1
				s_r<='0';
			elsif (t2="0100") then	--4	
				me(7 downto 0) <= f;			
				finish<='0';
			elsif (t2="1001") then	--9
				s_r<='1';	
				finish<='0';
			elsif (t2="1101") then	--13
				me(15 downto 8) <= f;	
				finish<='0';	
			elsif (t2="1111") then	--15
				F_total<=me;	
				finish<='1';	
				t2 <= "0000";
			end if;
	end if;
end process;

end Behavioral;
