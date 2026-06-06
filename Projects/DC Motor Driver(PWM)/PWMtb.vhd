LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY PWMtb IS
END PWMtb;
 
ARCHITECTURE behavior OF PWMtb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PWM
    PORT(
         Press : IN  std_logic;
         clk : IN  std_logic;
         res : IN  std_logic;
         data : IN  std_logic_vector(7 downto 0);
         PWM : OUT  std_logic;
         R_L : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Press : std_logic := '0';
   signal clk : std_logic := '0';
   signal res : std_logic := '0';
   signal data : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal PWM1 : std_logic;
   signal R_L : std_logic_vector(1 downto 0);

   -- Clock period definitions
   constant clk_period : time := 1 us;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PWM PORT MAP (
          Press => Press,
          clk => clk,
          res => res,
          data => data,
          PWM => PWM1,
          R_L => R_L
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		res <= '1';
		data <= x"80";
		press <= '0';
		wait for 10 us;
		res <= '0';
		wait for 2 ms;
		press <= '1';
		wait for 10 us;

   end process;

END;
