-- Testbench for BCD_to_7segment
library ieee;
use ieee.std_logic_1164.all;

entity BCD_to_7segment_tb is
end entity BCD_to_7segment_tb;

architecture behavioral of BCD_to_7segment_tb is
    -- Component Declaration for the Unit Under Test (UUT)
    component BCD_to_7segment is
        port (
            X : in std_logic_vector(3 downto 0);
            a, b, c, d, e, f, g : out std_logic
        );
    end component;

    -- Testbench Signals
    signal X_tb : std_logic_vector(3 downto 0) := "0000";
    signal a_tb, b_tb, c_tb, d_tb, e_tb, f_tb, g_tb : std_logic;

    -- Clock period constant for timing
    constant period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut : BCD_to_7segment
        port map (
            X => X_tb,
            a => a_tb,
            b => b_tb,
            c => c_tb,
            d => d_tb,
            e => e_tb,
            f => f_tb,
            g => g_tb
        );

    -- Stimulus process to apply test vectors
    stimulus_proc : process
    begin
        -- Test Case 1: Input 0
        X_tb <= "0000";
        wait for period;

        -- Test Case 2: Input 1
        X_tb <= "0001";
        wait for period;

        -- Test Case 3: Input 2
        X_tb <= "0010";
        wait for period;

        -- Test Case 4: Input 3
        X_tb <= "0011";
        wait for period;

        -- Test Case 5: Input 4
        X_tb <= "0100";
        wait for period;

        -- Test Case 6: Input 5
        X_tb <= "0101";
        wait for period;

        -- Test Case 7: Input 6
        X_tb <= "0110";
        wait for period;

        -- Test Case 8: Input 7
        X_tb <= "0111";
        wait for period;

        -- Test Case 9: Input 8
        X_tb <= "1000";
        wait for period;

        -- Test Case 10: Input 9
        X_tb <= "1001";
        wait for period;
        
        -- Optional: Test an invalid BCD value
        -- Test Case 11: Input 10 (invalid)
        X_tb <= "1010";
        wait for period;

        -- End of simulation
        wait;
    end process stimulus_proc;

end architecture behavioral;