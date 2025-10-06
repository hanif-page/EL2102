-- Testbench for fivebit_to_2bcd
library ieee;
use ieee.std_logic_1164.all;

entity fivebit_to_2bcd_tb is
end entity fivebit_to_2bcd_tb;

architecture behavioral of fivebit_to_2bcd_tb is
    -- Component Declaration for the Unit Under Test (UUT)
    component fivebit_to_2bcd is
        port (
            B    : in  std_logic_vector(4 downto 0);
            tens : out std_logic_vector(3 downto 0);
            ones : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Testbench Signals
    signal B_tb    : std_logic_vector(4 downto 0) := "00000";
    signal tens_tb : std_logic_vector(3 downto 0);
    signal ones_tb : std_logic_vector(3 downto 0);

    -- Clock period constant for timing
    constant period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut : fivebit_to_2bcd
        port map (
            B    => B_tb,
            tens => tens_tb,
            ones => ones_tb
        );

    -- Stimulus process to apply test vectors
    stimulus_proc : process
    begin
        -- Test Case 1: Input 0 (00000) -> Tens=0, Ones=0
        B_tb <= "00000";
        wait for period;

        -- Test Case 2: Input 5 (00101) -> Tens=0, Ones=5
        B_tb <= "00101";
        wait for period;

        -- Test Case 3: Input 9 (01001) -> Tens=0, Ones=9
        B_tb <= "01001";
        wait for period;

        -- Test Case 4: Input 10 (01010) -> Tens=1, Ones=0
        B_tb <= "01010";
        wait for period;

        -- Test Case 5: Input 15 (01111) -> Tens=1, Ones=5
        B_tb <= "01111";
        wait for period;

        -- Test Case 6: Input 19 (10011) -> Tens=1, Ones=9
        B_tb <= "10011";
        wait for period;

        -- Test Case 7: Input 20 (10100) -> Tens=2, Ones=0
        B_tb <= "10100";
        wait for period;
        
        -- Test Case 8: Input 23 (10111) -> Tens=2, Ones=3
        B_tb <= "10111";
        wait for period;
        
        -- Test Case 9: Input 29 (11101) -> Tens=2, Ones=9
        B_tb <= "11101";
        wait for period;

        -- Test Case 10: Input 30 (11110) -> Tens=3, Ones=0
        B_tb <= "11110";
        wait for period;

        -- Test Case 11: Input 31 (11111) -> Tens=3, Ones=1 (max value)
        B_tb <= "11111";
        wait for period;
        
        -- End of simulation
        wait;
    end process stimulus_proc;

end architecture behavioral;