library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity modulo3_app_tb is
end entity;

architecture tb of modulo3_app_tb is
    signal clk      : std_logic := '0';
    signal reset    : std_logic := '0';
    signal start    : std_logic := '0';
    signal Ain, Bin : std_logic_vector(3 downto 0) := (others => '0');
    signal C_modulo, D_out : std_logic_vector(3 downto 0);
    constant CLK_PERIOD : time := 10 ns;
    signal done     : std_logic;
    signal segC_tens, segC_ones, segD_tens, segD_ones : std_logic_vector(6 downto 0);

    type vector_type is array (0 to 14) of std_logic_vector(3 downto 0);
    signal A_vec : vector_type := (
        "0000", "0001", "0111", "1000", "1111",
        "1111", "1111", "1110", "0101", "0100", "1001",
        "1100", "1011", "0010", "1101"
    );
    signal B_vec : vector_type := (
        "0001", "0001", "0011", "0100", "1111",
        "0001", "0010", "0011", "0111", "0010", "0110",
        "0101", "0100", "0011", "0111"
    );

begin
    -- Instantiate DUT
    uut: entity work.modulo3_app
        port map(
            clk   => clk,
            reset => reset,
            start => start,
            Ain   => Ain,
            Bin   => Bin,
            done => done,
            C_modulo  => C_modulo,
            D_out  => D_out,
            segC_tens => segC_tens,
            segC_ones => segC_ones,
            segD_tens => segD_tens,
            segD_ones => segD_ones
        );

    -- Clock generation 1 Hz
    clk_process : process
    begin
        clk <= '0';
        wait for CLK_PERIOD / 2;
        clk <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    -- Test process
    stim_proc : process
    begin
        -- Reset
        reset <= '1';
        wait for 2 * CLK_PERIOD;
        reset <= '0';
        wait for CLK_PERIOD;

        -- Loop through all test cases
        for i in 0 to 14 loop
            Ain <= A_vec(i);
            Bin <= B_vec(i);
            wait for CLK_PERIOD;

            start <= '1';
            wait for 27 * CLK_PERIOD;
            start <= '0';

            -- Tunggu beberapa siklus agar FSM selesai
            wait for 10 * CLK_PERIOD;

            report "Test " & integer'image(i+1) &
                   ": A=" & integer'image(to_integer(unsigned(A_vec(i)))) &
                   ", B=" & integer'image(to_integer(unsigned(B_vec(i)))) &
                   ", C=" & integer'image(to_integer(unsigned(C_modulo))) &
                   ", D=" & integer'image(to_integer(unsigned(D_out)));
        end loop;

        report "All test completed." severity note;
        wait;
    end process;
end architecture;
