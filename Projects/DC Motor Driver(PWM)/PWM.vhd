library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity PWM is
    Port (	clk,res : in  STD_LOGIC;
			dir_press : in  STD_LOGIC;						--for changing direction
    		data : in  STD_LOGIC_VECTOR (7 downto 0);		--input for comparator(desinged this for an external adc, could be anything)
			PWM : out  STD_LOGIC;
        	R_L : out  STD_LOGIC_VECTOR(1 downto 0);		--right or left output
        	R_L_Diode : out  STD_LOGIC_VECTOR(1 downto 0));	--right or left output diode
end PWM;

architecture Behavioral of PWM is
	signal cnt_comp: unsigned(7 downto 0);
	signal data_unsigned: unsigned(7 downto 0);
	signal flag,trig: std_logic;
	signal count: unsigned(25 downto 0);
begin
	process(clk)	--Counter
		begin
			if(rising_edge(clk)) then
				if(res = '1') then
					cnt_comp <= (others => '0');
				else
					cnt_comp <= cnt_comp + 1;
				end if;
			end if;
		end process;
	process(CLK)
		begin
			if(rising_edge(clk)) then
				if(res = '1') then
					count <= (others => '0');
					flag 	<= '0';
					trig	<= '0';
					PWM 	<= '0';
				else
					count <= count + 1;
					if(cnt_comp < data_unsigned) then	--PWM Maker
						PWM <= '1';
					else
						PWM <= '0';
					end if;

					if(flag = '0') then		--debouncer for direction change
						if(dir_press = '1') then
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
	R_L <= trig & not(trig);
	R_L_Diode <= trig & not(trig);
	data_unsigned <= unsigned(data);
end Behavioral;