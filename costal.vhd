

library IEEE;
use IEEE.STD_LOGIC_1164.all;

package costal is


---------------------------------------------------------------------------------------------------
component medfrec 
    Port ( srpm : in  STD_LOGIC;								--entrada senal PWM de velocidad
           clk : in  STD_LOGIC;
			  rst : in std_logic;
			  sel : in std_logic;								--16 bits de frecuencia
           f : out  STD_LOGIC_VECTOR (7 downto 0));	--8 leds de las tarjetas
end component;

---------------------------------------------------------------------------------------------------
component DIVISOR 
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  clksal2 :out STD_LOGIC;
           clksal : out  STD_LOGIC);
end component;

---------------------------------------------------------------------------------------------------
component controlador 
    Port ( filtro: out STD_LOGIC_VECTOR(1 downto 0);
			  s0: out  STD_LOGIC;
			  s1: out  STD_LOGIC;
			  s2: out  STD_LOGIC;
			  s3: out  STD_LOGIC; 
			  enable_a: out STD_LOGIC; 
			  finish_c: in STD_LOGIC;
			  clk : in  STD_LOGIC);

end component;

---------------------------------------------------------------------------------------------------
component CLASIFICADOR 
 Port ( fr : in  STD_LOGIC_VECTOR (15 downto 0);
		  fa : in  STD_LOGIC_VECTOR (15 downto 0);
		  fv : in  STD_LOGIC_VECTOR (15 downto 0);
		  sw : out  STD_LOGIC_VECTOR (2 downto 0));

end component;	


---------------------------------------------------------------------------------------------------
component totRojo
    Port ( enable : in  STD_LOGIC;
			  f : in  STD_LOGIC_VECTOR (7 downto 0);
			  F_total_rojo : out  STD_LOGIC_VECTOR (15 downto 0);
			  F_total_azul : out  STD_LOGIC_VECTOR (15 downto 0);
			  F_total_verde : out  STD_LOGIC_VECTOR (15 downto 0);			  
			  s_r : out  STD_LOGIC; 
			  finish : out  STD_LOGIC;
			  filtro :in  STD_LOGIC_VECTOR (1 downto 0);			  
			  clk : in  STD_LOGIC);
end component;
---------------------------------------------------------------------------------------------------




end costal;
