library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Debouncer is
    Port (	press : in  STD_LOGIC;	
			clk : in std_logic;
			res : in std_logic);
end Debouncer;

architecture Behavioral of Debouncer is

	signal count: unsigned(26 downto 0);
	signal flag: std_logic;
	signal trig: std_logic;
begin
	process(CLK)
		begin
			if(rising_edge(clk)) then
				if(res = '1') then
					count <= (others => '0');
					flag 	<= '0';
					trig	<= '0';
				else
					count <= count + 1;
					if(flag = '0') then
						if(press = '1') then
							trig <='1';
							count <= (others => '0');
							flag <='1';
						end if;
					else
						trig <= '0';
						if(count = 10000000) then
							flag <= '0';
						end if;					
					end if;
				end if;
			end if;
		end process;
end behavioral;