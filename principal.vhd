library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.costal.all;

entity principal is
    Port ( 
	        pin_frecuencia : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
           mclk : in  STD_LOGIC;
           
			  leds : out  STD_LOGIC_VECTOR (7 downto 0);
			  led_sel : out  STD_LOGIC;
			  
           s0_p : out  STD_LOGIC;
           s1_p : out  STD_LOGIC;
           s2_p : out  STD_LOGIC;
           s3_p : out  STD_LOGIC;
			  sw: out  STD_LOGIC_VECTOR (2 downto 0));
end principal;

architecture Behavioral of principal is

signal auxclk, auxclk2: std_logic;
signal aux_frec: std_logic_vector(7 downto 0);

signal aux_Ftotal_rojo: std_logic_vector(15 downto 0);
signal aux_Ftotal_azul: std_logic_vector(15 downto 0);
signal aux_Ftotal_verde: std_logic_vector(15 downto 0);
signal aux_filtro: std_logic_vector(1 downto 0);
signal aux_f,aux_sel, aux_ea: std_logic;

signal aux_sw: std_logic_vector(2 downto 0);

begin
leds <= aux_frec;
led_sel <= aux_sel;
sw<=aux_sw;

--bloque medfrec
u1: medfrec port map(
srpm=> pin_frecuencia,								--entrada senal PWM de velocidad
clk=>	mclk,
rst=> reset,
sel=>	aux_sel,							--16 bits de frecuencia
f=> aux_frec);


--bloque DIVISOR
u2: DIVISOR port map(
rst=> reset,
clk=> mclk,
clksal2=> auxclk2,
clksal=> auxclk);


------------------------------------------------------------------
--bloque controlador
u3: controlador port map(
filtro=>aux_filtro,
enable_a=>aux_ea,
s0=> s0_p,
s1=> s1_p,
s2=> s2_p,
s3=> s3_p,       
clk=> auxclk,
finish_c=> aux_f);
-------------------------------------------------------------------
--totRojo
u4: totRojo port map(
enable=> aux_ea,
f=> aux_frec,
F_total_rojo=> aux_Ftotal_rojo,
F_total_azul=> aux_Ftotal_azul,
F_total_verde=> aux_Ftotal_verde,
s_r=> aux_sel, 
finish=> aux_f,
filtro=>aux_filtro,
clk=> auxclk
);


-------------------------------------------------------------------
--CLASIFICADOR
u5: CLASIFICADOR port map(
fr=> aux_Ftotal_rojo,
fa=> aux_Ftotal_azul,
fv=> aux_Ftotal_verde,
sw=> aux_sw);
end Behavioral;

