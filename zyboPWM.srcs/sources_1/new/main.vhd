library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity main is
	Port(
		sysclk      : in std_logic;
		RGB0        : out std_logic_vector (2 downto 0)
    );
end main;

architecture Behavioral of main is

	component pwm_module
    port
     (
      clk : in std_logic;
      dutyCycle	: in integer range 0 to 255;
	  pwm : out std_logic
     );
    end component;

signal	clk         : std_logic;
signal	led			: std_logic:= '0';
signal	timer		: integer range 0 to 125000000:= 0;
signal	dutyCycle	: integer range 0 to 255:= 0;
signal	dir			: std_logic:= '0';
signal	red			: std_logic:= '0';
signal	green		: std_logic:= '0';
signal	blue		: std_logic:= '0';
signal	state		: integer range 0 to 3:= 0;
signal	sw			: std_logic:= '0';
signal	lap			: std_logic:= '0';
signal	rate		: integer range 0 to 125000000:= 0;

begin

	rPWM : pwm_module
    port map ( 
		clk => clk,
		dutyCycle => dutyCycle,
		pwm => red);
	
	gPWM : pwm_module
    port map ( 
		clk => clk,
		dutyCycle => dutyCycle,
		pwm => green);

	bPWM : pwm_module
	port map ( 
		clk => clk,
		dutyCycle => dutyCycle,
		pwm => blue);

clk             <= sysclk;
-- RGB0(0)			<= '0';
-- RGB0(1)			<= '0';
-- RGB0(2)			<= blue;

dutyCycle <= 200;

disco: process(clk)
begin
	if rising_edge(clk) then
		-- if timer < 312500 then
		if timer < rate then
			timer <= timer + 1;
		else
			timer <= 0;
			state <= state + 1;
		end if;

		if lap = '1' then
			if dir = '0' then
				if rate /= 0 then
					rate <= rate - 1;
				else
					-- rate <= 125000000;
					dir <= '1';
				end if;
			else
				if rate < 125000000 then
					rate <= rate + 1;
				else
					-- rate <= 125000000;
					dir <= '0';
				end if;
			end if;


			
		end if;
	end if;
end process;

fade: process(clk)
begin
	if rising_edge(clk) then
		case state is
			when 0 =>
				RGB0(0)			<= '0';
				RGB0(1)			<= '0';
				RGB0(2)			<= blue;
				lap <= '0';
			when 1 =>
				RGB0(0)			<= red;
				RGB0(1)			<= '0';
				RGB0(2)			<= blue;
			when 2 =>
				RGB0(0)			<= red;
				RGB0(1)			<= '0';
				RGB0(2)			<= '0';
			when 3 =>
				RGB0(0)			<= '0';
				RGB0(1)			<= green;
				RGB0(2)			<= '0';
				lap <= '1';
		end case;
	end if;
end process;

-- process(clk)
-- begin
--     if rising_edge(clk) then

-- 		if timer < 312500 then
-- 			timer <= timer + 1;
-- 		else
-- 			timer <= 0;
-- 			-- fade brightness.
-- 			if dir = '0' then
-- 				if dutyCycle < 255 then
-- 					dutyCycle <= dutyCycle + 1;
-- 				else
-- 					dir <= '1';
-- 				end if;
-- 			else
-- 				if dutyCycle > 0 then
-- 					dutyCycle <= dutyCycle - 1;
-- 				else
-- 					dir <= '0';
-- 					state <= state + 1;
-- 				end if;
-- 			end if;
-- 		end if;

--     end if;
-- end process;

end Behavioral;