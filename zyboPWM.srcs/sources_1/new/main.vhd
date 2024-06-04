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

begin

	PWMer : pwm_module
    port map ( 
			clk => clk,
			dutyCycle => dutyCycle,
			pwm => led
        );

clk             <= sysclk;
RGB0(0)			<= '0';
RGB0(1)			<= '0';
RGB0(2)			<= led;

process(clk)
begin
    if rising_edge(clk) then

		if timer < 312500 then
			timer <= timer + 1;
		else
			timer <= 0;
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