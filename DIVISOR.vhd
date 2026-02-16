library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity DIVISOR is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  clksal2 :out STD_LOGIC;
           clksal : out  STD_LOGIC);
end DIVISOR;

architecture Behavioral of divisor is
signal q: std_logic_vector(25 downto 0);

begin
process (clk,rst)
begin 
if rst='1' then 
q <= (others => '0');
elsif rising_edge(clk) then 
q <= q+1;
end if;
end process;

clksal<= q(22); ---clk del controlador

clksal2 <= clk;

end Behavioral;

