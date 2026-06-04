library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Double_Dabble is
    Port ( clk,res : in  STD_LOGIC;
           Num : in  STD_LOGIC_VECTOR (15 downto 0);
           d1,d2,d3,d4,d5 : out  STD_LOGIC_VECTOR (3 downto 0)
			  );
end Double_Dabble;

architecture Behavioral of Double_Dabble is


	signal sipo1: std_logic_vector(15 downto 0);		--sipo1 is the register for num input
	signal flag: std_logic;
	signal shift_plus: std_logic;
	signal cnt: unsigned(4 downto 0);
	signal plus3: 	unsigned(1 downto 0);
	signal num_o : unsigned(19 downto 0);
begin
	process(clk)
		begin
			if(rising_edge(clk)) then
				if(res = '1' or Num /= sipo1) then		--second condition is for when Num(input) changes so the output show the new number
					cnt <= (others => '0');			--free running counter upto 32
					num_o	<= (others => '0');
					plus3 <= "11";
					flag <= '0';
					sipo1 <= Num;
					shift_plus <= '0';
				else
					if(flag = '0') then	--double dabble mechanism
						if(shift_plus = '0') then	--one clock for shift
							cnt <= cnt + 1;
							num_o <= num_o(18 downto 0) & sipo1(15 - to_integer(cnt));
							shift_plus <= not(shift_plus);
						else						--one clock for plus3
							if(num_o(3 downto 0) > 4) then
								num_o(3 downto 0) <= num_o(3 downto 0) + plus3;
							end if;
							if(num_o(7 downto 4) > 4) then
								num_o(7 downto 4) <= num_o(7 downto 4) + plus3;
							end if;
							if(num_o(11 downto 8) > 4) then
								num_o(11 downto 8) <= num_o(11 downto 8) + plus3;
							end if;
							if(num_o(15 downto 12) > 4) then
								num_o(15 downto 12) <= num_o(15 downto 12) + plus3;
							end if;
							if(num_o(19 downto 16) > 4) then
								num_o(19 downto 16) <= num_o(19 downto 16) + plus3;
							end if;
							shift_plus <= not(shift_plus);
						end if;	--shif_plus
					end if;	--flag
					if(cnt = 15) then
						plus3 <= "00";	--to not add to the upper loop
					end if;					
					if(cnt = 16) then
						flag <= '1';	--to stop after 15 clocks
					end if;
				end if;			
			end if;
		end process;
		
	d1 <= std_logic_vector(num_o(3 downto 0));
	d2 <= std_logic_vector(num_o(7 downto 4));
	d3 <= std_logic_vector(num_o(11 downto 8));
	d4 <= std_logic_vector(num_o(15 downto 12));
	d5 <= std_logic_vector(num_o(19 downto 16));
	
end Behavioral;

