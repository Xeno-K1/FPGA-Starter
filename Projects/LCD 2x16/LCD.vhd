--with 36MHz Clock

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity LCD is
    Port ( clk,res : in  STD_LOGIC;
           rs,rw,en : out  STD_LOGIC;
           data : out  STD_LOGIC_VECTOR (7 downto 0));
end LCD;

architecture Behavioral of LCD is
	type state is (init,f1,f2,f3,clr,d_con,em,setDDRAM,do);
	signal s_reg,s_next : state;
	signal cnt_next,cnt_reg : unsigned(3 downto 0);
	signal cnt: unsigned(20 downto 0);
	signal rs_reg,rs_next : std_logic;
	signal en_reg: std_logic;
	
begin
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(res = '1') then
				s_reg <= init;
				cnt_reg <= (others => '0');
				cnt <= (others => '0');
				rs_reg <= '0';
				en_reg <= '1';
			else
				cnt <= cnt + 1;
				if(cnt = 36000) then
					if(cnt_reg < 12) then
						en_reg <= '0';
					end if;
				end if;
				if(cnt = 72000) then
					s_reg <= s_next;
					cnt_reg <= cnt_next;
					rs_reg <= rs_next;
					cnt <= (others => '0');
					en_reg <= '1';
				end if;
			end if;
		end if;
	end process;
	
	process(s_reg,rs_reg,cnt_reg)
	begin
		s_next <= s_reg;
		rs_next <= rs_reg;
		data <= (others => '0');
		cnt_next <= cnt_reg;

		case s_reg	is
			when init => 
				if(rs_reg = '0') then
					s_next <= f1;
				end if;
			when f1 => 
				data <= x"38";
				s_next <= f2;
			when f2 => 
				data <= "00111000";
				s_next <= f3;
			when f3 => 
				data <= "00111000";
				s_next <= d_con;
			when d_con => 
				data <= "00001100";
				s_next <= clr;
			when clr => 
				data <= "00000001";
				s_next <= em;
			when em	 => 
				data <= "00000110";
				s_next <= setDDRAM;
			when setDDRAM => 
				data <= "10000000";
				s_next <= do;
				rs_next <= '1';		-- begin to write data
			when do => 
				cnt_next <= cnt_reg + 1;
				case cnt_reg is
					when x"0" => data <= x"47"; --G
					when x"1" => data <= x"41";	--A
					when x"2" => data <= x"52"; --R
					when x"3" => data <= x"44"; --D
					when x"4" => data <= x"20";	--SPACE
					when x"5" => data <= x"41"; --A
					when x"6" => data <= x"63"; --C
					when x"7" => data <= x"61"; --A
					when x"8" => data <= x"64"; --D
					when x"9" => data <= x"65"; --E
					when x"A" => data <= x"6D"; --M
					when x"B" => data <= x"79";	--Y
					when others => data <= x"20";
				end case;
				if(cnt_reg = 11) then
					s_next <= init;
					rs_next <= '1';			--these two line can be un commented so it goes to init but it doesnt write by not toggling the en
--					rs_next <= '0';			--this or above two lines, this goes to read mode now writing anymore even if en is toggling
				end if;
		end case;
	end process;
	rs <= rs_reg;
	rw<= '0';
	en <= en_reg;
end Behavioral;

