-- Testbench for fourbit_to_BCD (4-Bit Adder)
library ieee;
use ieee.std_logic_1164.all;

entity fourbit_adder_tb is
end entity fourbit_adder_tb;

architecture behavioral of fourbit_adder_tb is
    -- Component Declaration for the Unit Under Test (UUT)
    component fourbit_to_BCD is
        port (
            A, B        : in  std_logic_vector(3 downto 0);
            Cin_initial : in  std_logic;
            Cin         : buffer std_logic_vector(3 downto 0);
            S           : out std_logic_vector(3 downto 0);
            Cout        : out std_logic
        );
    end component;

    -- Testbench Signals
    signal A_tb, B_tb : std_logic_vector(3 downto 0) := "0000";
    signal Cin_initial_tb : std_logic := '0';
    signal S_tb : std_logic_vector(3 downto 0);
    signal Cout_tb : std_logic;
    signal Cin_tb : std_logic_vector(3 downto 0); -- For port mapping buffer

    -- Clock period constant for timing
    constant period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut : fourbit_to_BCD
        port map (
            A           => A_tb,
            B           => B_tb,
            Cin_initial => Cin_initial_tb,
            Cin         => Cin_tb,
            S           => S_tb,
            Cout        => Cout_tb
        );

    -- Stimulus process to apply test vectors
    stimulus_proc : process
    begin
        -- Test Case 1: 0 + 0, Cin = 0
        A_tb <= "0000"; B_tb <= "0000"; Cin_initial_tb <= '0';
        wait for period;

        -- Test Case 2: 1 + 2, Cin = 0
        A_tb <= "0001"; B_tb <= "0010"; Cin_initial_tb <= '0';
        wait for period;

        -- Test Case 3: 5 + 5, Cin = 0
        A_tb <= "0101"; B_tb <= "0101"; Cin_initial_tb <= '0';
        wait for period;

        -- Test Case 4: 9 + 1, Cin = 0
        A_tb <= "1001"; B_tb <= "0001"; Cin_initial_tb <= '0';
        wait for period;

        -- Test Case 5: 7 + 8, Cin = 0 (generates carry)
        A_tb <= "0111"; B_tb <= "1000"; Cin_initial_tb <= '0';
        wait for period;

        -- Test Case 6: 15 + 15, Cin = 0 (max values, generates carry)
        A_tb <= "1111"; B_tb <= "1111"; Cin_initial_tb <= '0';
        wait for period;

        -- Test Case 7: 0 + 0, Cin = 1
        A_tb <= "0000"; B_tb <= "0000"; Cin_initial_tb <= '1';
        wait for period;

        -- Test Case 8: 3 + 4, Cin = 1
        A_tb <= "0011"; B_tb <= "0100"; Cin_initial_tb <= '1';
        wait for period;
        
        -- Test Case 9: 8 + 8, Cin = 1 (generates carry)
        A_tb <= "1000"; B_tb <= "1000"; Cin_initial_tb <= '1';
        wait for period;

        -- Test Case 10: 15 + 15, Cin = 1 (max values with carry, generates carry)
        A_tb <= "1111"; B_tb <= "1111"; Cin_initial_tb <= '1';
        wait for period;
        
        -- Test Case 11: 6 + 9, Cin = 0 (generates carry)
        A_tb <= "0110"; B_tb <= "1001"; Cin_initial_tb <= '0';
        wait for period;

        -- End of simulation
        wait;
    end process stimulus_proc;

end architecture behavioral;