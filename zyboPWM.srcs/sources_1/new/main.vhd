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
signal  led         : std_logic:= '0';
signal  state       : integer range 0 to 125000000:= 0;
signal  period      : integer range 0 to 125000:= 125000;
signal  pulseWidth  : integer range 0 to 125000:= 125000;
signal  incr        : integer range 0 to 125000:= 0;
signal  dir         : std_logic:= '0';
signal  ledCnt      : integer range 0 to 2:= 0;

begin

clk             <= sysclk;

process(clk)
begin
    if rising_edge(clk) then

        if pulseWidth < incr  then
            led <= '1';
        else
            led <= '0';
        end if;

        if pulseWidth < period then
            pulseWidth <= pulseWidth + 1;
        else
            pulseWidth <= 0;
        end if;

        if state < 125000 then
            state <= state + 1;
        else
            state <= 0;
            if dir = '0' then
                if incr /= 125000 then
                    incr <= incr + 125;
                else
                    dir <= '1';
                end if;
            else
                if incr /= 0 then
                    incr <= incr - 125;
                else
                    dir <= '0';
                    if ledCnt /= 2 then
                        ledCnt <= ledCnt + 1;
                    else
                        ledCnt <= 0;
                    end if;
                end if;
            end if;
        end if;

        if ledCnt = 0 then
            RGB0(0)         <= '0';
            RGB0(1)         <= '0';
            RGB0(2)         <= led;
        elsif ledCnt = 1 then
            RGB0(0)         <= '0';
            RGB0(1)         <= led;
            RGB0(2)         <= '0';
        elsif ledCnt = 2 then
            RGB0(0)         <= led;
            RGB0(1)         <= '0';
            RGB0(2)         <= '0'; 
        end if;

    end if;
end process;

end Behavioral;