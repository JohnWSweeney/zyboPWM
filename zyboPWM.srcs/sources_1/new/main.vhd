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
signal	clk         : std_logic;
signal	led			: std_logic:= '0';
signal	state		: integer range 0 to 255000:= 0;
signal	period		: integer:= 255000;
signal	dutyCycle	: integer range 0 to 255:= 0;
signal	dir			: std_logic:= '0';

begin

clk             <= sysclk;
RGB0(0)			<= '0';
RGB0(1)			<= '0';
RGB0(2)			<= led;

process(clk)
begin
    if rising_edge(clk) then

		if state < period then
			if state < dutyCycle * 1000 then
				led <= '1';
			else
				led <= '0';
			end if;
			state <= state + 1;
		else
			state <= 0;
			-- fade brightness.
			if dir = '0' then
				if dutyCycle < 255 then
					dutyCycle <= dutyCycle + 1;
				else
					dir <= '1';
				end if;
			else
				if dutyCycle > 0 then
					dutyCycle <= dutyCycle - 1;
				else
					dir <= '0';
				end if;
			end if;
		end if;

    end if;
end process;

end Behavioral;