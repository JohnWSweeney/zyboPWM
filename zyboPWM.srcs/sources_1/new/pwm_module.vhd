library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity pwm_module is
	Port(
		clk      : in std_logic;
		dutyCycle	: in integer range 0 to 255;
		pwm			: out std_logic
    );
end pwm_module;

architecture Behavioral of pwm_module is
signal	state		: integer range 0 to 255000:= 0;
signal	period		: integer:= 255000;

begin

--

process(clk)
begin
    if rising_edge(clk) then
		if state < period then
			if state < dutyCycle * 1000 then
				pwm <= '1';
			else
				pwm <= '0';
			end if;
			state <= state + 1;
		else
			state <= 0;
		end if;
    end if;
end process;

end Behavioral;