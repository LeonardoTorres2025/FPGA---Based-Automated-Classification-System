--
--IPN-UPIITA


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;



entity medfrec is
    Port ( srpm : in  STD_LOGIC;								--entrada senal PWM de velocidad
           clk : in  STD_LOGIC;
			  rst : in std_logic;
			  sel : in std_logic;								--16 bits de frecuencia
           f : out  STD_LOGIC_VECTOR (7 downto 0));	--8 leds de las tarjetas
end medfrec;

   architecture Behavioral of medfrec is
type estados is (ini,cuenta,carga,limpia);			--maquina de estados
signal estado: estados;
signal con_clr,con_hld,reg_ld,reg_clr: std_logic; --
signal clkdiv: std_logic;									--divisor de frecuencia, brincos en maq edos
signal clkaux: std_logic_vector(22 downto 0);		--conteos
signal q,reg: STD_LOGIC_VECTOR (15 downto 0);		--
signal i: std_logic_vector(3 downto 0);

begin
   --Controlador
 process(clkdiv,srpm,rst)
 begin 
    if rst='1' then
	        estado <= ini;
		     con_clr <='1';
			  reg_ld <= '0';
			  reg_clr <= '1';
			  con_hld <= '0';
			  i <= "0000";
	 elsif rising_edge(clkdiv) then
	 case estado is
	    when ini =>
		     con_clr <='1';
			  reg_ld <= '0';
			  reg_clr <= '1';
			  con_hld <= '0';
			  estado <= cuenta;
			  i <= "0000";
		 
		 when cuenta =>
		     con_clr <='0';
			  reg_ld <= '0';
			  reg_clr <= '0';
			 -- con_hld <= '0';
			  if i<"1011" then    --11*.0839=0.9229s
			     estado <= cuenta;
				  i<=i+1;
				  con_hld <= '0';
				else
			     estado <= carga;
				  i <= "0000";
				  con_hld <= '1';
	        end if;
		  
		 when carga =>
			  con_clr <='0';
			  reg_ld <= '1';
			  reg_clr <= '0';
			  con_hld <= '1';
			  estado <= limpia;
		     i <= "0000";
		 
	     when limpia =>
			  con_clr <='1';
			  reg_ld <= '0';
			  reg_clr <= '0';
			  con_hld <= '0';
			  estado <= cuenta;
			  i <= "0000";
				 
    end case;
	 end if;
 end process;



   --contador numero de pulsos en un t
	process(con_clr,srpm)
	begin
	   if (con_clr='1') then
		    q <= "0000000000000000";
		elsif (srpm'event and srpm='0') then 
	       if (con_hld='1') then
			 	 q <= q;
				 else
			    q <= q+1;
			  end if;
	   end if;
	end process;

   --registro
	process(reg_ld,reg_clr,clkdiv)
	begin
	   if (reg_clr='1') then
		    reg <= "0000000000000000";
		elsif (clkdiv'event and clkdiv='1') then
		   if (reg_ld='1') then
			   reg <= q;
			else
			   reg <= reg;
			end if;
		end if;	
	end process;

    --multiplexion de los datos
	 process(reg,sel)
	 begin
 	    if sel='0' then
		     f <= reg(7 downto 0);    --parte baja
		 else
		     f <= reg(15 downto 8);
		 end if;
	 end process;
	 
	 
	 --divisor de frecuencia
	 process(clk)
	 begin
	 if (clk'event and clk='1') then
	    clkaux <= clkaux + 1;
	 end if;
	 end process;
	 
	
	 --clkdiv <= clkaux(19);  --47.6837Hz 0.0209
	 --clkdiv <= clkaux(20);  --23.8418 0.0419
    --clkdiv <= clkaux(22);  --5.96hz  0.1677 s
	 clkdiv <= clkaux(21);  --11.92hz  0.0839 s
end Behavioral;

--net srpm clock_dedicated_route=false; --siempre qeu mido rising edge de senal externa


