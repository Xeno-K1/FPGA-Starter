library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity DD_With_Sigs is
    Port ( clk,res : in  STD_LOGIC;
           Num : in  STD_LOGIC_VECTOR (15 downto 0);
           --test : out  STD_LOGIC_VECTOR (6 downto 0);
           d1,d2,d3,d4,d5 : out  STD_LOGIC_VECTOR (3 downto 0)
--           dout : out  STD_LOGIC_VECTOR (7 downto 0);
--	  		  COM : out STD_LOGIC_VECTOR (3 downto 0)
			  );
end DD_With_Sigs;


architecture Behavioral of DD_With_Sigs is


	signal sipo1: std_logic_vector(15 downto 0);
	signal flag: std_logic;
	signal shift_plus: std_logic;
--	signal zout: unsigned(19 downto 0);
	signal cnt: unsigned(4 downto 0);
	signal N3: 	unsigned(1 downto 0);
--	signal d1,d2,d3,d4 :  STD_LOGIC_VECTOR (3 downto 0);
	signal z : unsigned(19 downto 0);
begin
--	d4 <= "1111";
	process(clk)
	   --variable z : unsigned(19 downto 0);	--for inside to change value at will

		begin
			if(rising_edge(clk)) then
				if(res = '1' or Num /= sipo1) then
					cnt <= (others => '0');	--free runnig counter
--					zout <= (others => '0');
					z	<= (others => '0');
					N3 <= "11";
					flag <= '0';
					sipo1 <= Num;
					shift_plus <= '0';

				else
--					if (Num /= sipo1) then
--						sipo1 <= Num;
--						cnt <= (others => '0');	--free runnig counter
--						zout <= (others => '0');
--						z	<= (others => '0');
--						N3 <= "11";
--						flag <= '0';
--						shift_plus <= '0';
--					end if;	--Num/Sipo
					--cnt <= cnt + 1;
					if(flag = '0') then	--double dabbler mechanism
						if(shift_plus = '0') then
							cnt <= cnt + 1;
							z <= z(18 downto 0) & sipo1(15 - to_integer(cnt));
							shift_plus <= not(shift_plus);
						else
							if(z(3 downto 0) > 4) then
								z(3 downto 0) <= z(3 downto 0) + N3;
							end if;
							if(z(7 downto 4) > 4) then
								z(7 downto 4) <= z(7 downto 4) + N3;
							end if;
							if(z(11 downto 8) > 4) then
								z(11 downto 8) <= z(11 downto 8) + N3;
							end if;
							if(z(15 downto 12) > 4) then
								z(15 downto 12) <= z(15 downto 12) + N3;
							end if;
							if(z(19 downto 16) > 4) then
								z(19 downto 16) <= z(19 downto 16) + N3;
							end if;
							shift_plus <= not(shift_plus);
						end if;	--shif_plus
					end if;	--flag
					if(cnt = 16) then
						flag <= '1';	--to stop after 15 clocks
					end if;
					if(cnt = 15) then
						N3 <= "00";	--to not add to the upper loop
					end if;
--					zout <= z;
				end if;			
			end if;
		end process;
		
	d1 <= std_logic_vector(z(3 downto 0));
	d2 <= std_logic_vector(z(7 downto 4));
	d3 <= std_logic_vector(z(11 downto 8));
	d4 <= std_logic_vector(z(15 downto 12));
	d5 <= std_logic_vector(z(19 downto 16));
	
end Behavioral;

