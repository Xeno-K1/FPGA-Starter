library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity PWM is
    Port ( Press,clk,res : in  STD_LOGIC;
           data : in  STD_LOGIC_VECTOR (7 downto 0);
			PWM : out  STD_LOGIC;
           R_L : out  STD_LOGIC_VECTOR(1 downto 0);
           R_L_Diode : out  STD_LOGIC_VECTOR(1 downto 0));
end PWM;

architecture Behavioral of PWM is
	signal x1: unsigned(7 downto 0);
	signal dataUn: unsigned(7 downto 0);
	signal flag,trig: std_logic;
	signal count: unsigned(25 downto 0);
begin
	process(clk)	--Counter
		begin
			if(rising_edge(clk)) then
				if(res = '1') then
				x1 <= (others => '0');
				else
				x1 <= x1 + 1;
				end if;
			end if;
		end process;
	process(CLK)	--Debouncer
		begin
			if(rising_edge(clk)) then
				if(res = '1') then
					count <= (others => '0');
					flag 	<= '0';
					trig	<= '0';
					PWM 	<= '0';
				else
					count <= count + 1;
					if(x1 < dataUn) then
						PWM <= '1';
					else
						PWM <= '0';
					end if;

					if(flag = '0') then
						if(press = '1') then
							trig <= not(trig);
							flag <='1';
							count <= (others => '0');
							end if;
					else
							if(count = 10000000) then
								flag <= '0';
								count <= (others => '0');
							end if;
					end if;
				end if;
			end if;
		end process;
	process(clk)	--Comparator
		begin
--			if(rising_edge(clk)) then
--				if(x1 < dataUn) then
--				PWM <= '1';
--				else
--				PWM <= '0';
--				end if;
--			end if;
		end process;
	R_L <= trig & not(trig);
	R_L_Diode <= trig & not(trig);
	dataUn <= unsigned(data);

end Behavioral;

