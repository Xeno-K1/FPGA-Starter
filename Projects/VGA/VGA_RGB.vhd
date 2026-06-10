library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity VGA_RGB is
    Port ( HSync,VSync : out  STD_LOGIC;
			  res,clk: in  STD_LOGIC;
           Red,Green : out  STD_LOGIC_VECTOR (2 downto 0);
           Blue : out  STD_LOGIC_VECTOR (1 downto 0));
end VGA_RGB;

architecture Behavioral of VGA_RGB is
	signal cnt_h: unsigned(10 downto 0);
	signal cnt_v: unsigned(9 downto 0);
	signal cnt: unsigned(2 downto 0);
	signal R,G: std_logic_vector(2 downto 0);
	signal B: std_logic_vector(1 downto 0);
	signal H,V: std_logic;
begin
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(res = '1') then
				cnt <= (others => '0');
				cnt_v <= (others => '0');
				cnt_h <= (others => '0');
				R <= (others => '0');
				G <= (others => '0');
				B <= (others => '0');
				H <= '0';
				V <= '0';
			else
				cnt <= cnt + 1;
				if(cnt < 5) then
				cnt_h <= cnt_h + 1;
					if(cnt_h = 1056) then
						cnt_h <= (others => '0');
						cnt_v <= cnt_v + 1;
						if(cnt_v = 628) then
							cnt_v <= (others => '0');
						end if;
					end if;
				elsif(cnt = 5) then
					cnt <= (others => '0');
				end if;
				if(cnt_h > 88 and cnt_h < 889 and cnt_v > 22 and cnt_v < 624) then
					H <= '1';
					V <= '1';
					if(cnt_h < 355) then+
						R <= "111";
						G <= "000";
						B <= "00";
					elsif(cnt_h > 354 and cnt_h < 621) then
						R <= "000";
						G <= "111";
						B <= "00";
					elsif(cnt_h < 889 and cnt_h > 620) then						
						R <= "000";
						G <= "000";
						B <= "11";
					else
						R <= "000";
						G <= "000";
						B <= "00";
					end if;
				else				
					H <= '0';
					V <= '0';
					R <= "000";
					G <= "000";
					B <= "00";
				end if;
			end if;
		end if;
	end process;
	
	Red <= R;
	Green <= G;
	Blue <= B;
	HSync <= H;
	VSync <= V;

end Behavioral;

