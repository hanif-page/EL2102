library ieee;
use ieee.std_logic_1164.all;

entity display_output_tb is
end entity;

architecture behavior of display_output_tb is

    -- DUT declaration
    component display_output
        port (
            A : in std_logic_vector(3 downto 0);
            B : in std_logic_vector(3 downto 0);
            Cin : in std_logic;
            A_out : out std_logic_vector(3 downto 0);
            B_out : out std_logic_vector(3 downto 0);
            CinOut : out std_logic;
            sevensegA0 : out std_logic_vector(0 to 6);
            sevensegA1 : out std_logic_vector(0 to 6);  
            sevensegB0 : out std_logic_vector(0 to 6);
            sevensegB1 : out std_logic_vector(0 to 6);  
            sevensegS0 : out std_logic_vector(0 to 6);
            sevensegS1 : out std_logic_vector(0 to 6)
        );
    end component;

    -- Signals
    signal A_tb, B_tb        : std_logic_vector(3 downto 0) := (others => '0');
    signal Cin_tb            : std_logic := '0';
    signal A_out_tb, B_out_tb: std_logic_vector(3 downto 0);
    signal CinOut_tb         : std_logic;
    signal sevensegA0_tb, sevensegA1_tb : std_logic_vector(0 to 6);
    signal sevensegB0_tb, sevensegB1_tb : std_logic_vector(0 to 6);
    signal sevensegS0_tb, sevensegS1_tb : std_logic_vector(0 to 6);

    -- Type and constant definitions for test vectors
    type test_vector_array is array (1 to 64) of std_logic_vector(8 downto 0);
    constant test_vectors : test_vector_array := (
        -- Vectors 1-32 from the first table
        1  => "000000000", 2  => "000010000", 3  => "000100000", 4  => "000110000",
        5  => "001000000", 6  => "001010000", 7  => "001100000", 8  => "001110000",
        9  => "010000000", 10 => "010010000", 11 => "010100000", 12 => "010110000",
        13 => "011000000", 14 => "011010000", 15 => "011100000", 16 => "011110000",
        17 => "000000001", 18 => "000010001", 19 => "000100001", 20 => "000110001",
        21 => "001000001", 22 => "001010001", 23 => "001100001", 24 => "001110001",
        25 => "010000001", 26 => "010010001", 27 => "010100001", 28 => "010110001",
        29 => "011000001", 30 => "011010001", 31 => "011100001", 32 => "011110001",
        -- Vectors 33-64 from the second table
        33 => "100000000", 34 => "100010000", 35 => "100100000", 36 => "100110000",
        37 => "101000000", 38 => "101010000", 39 => "101100000", 40 => "101110000",
        41 => "110000000", 42 => "110010000", 43 => "110100000", 44 => "110110000",
        45 => "111000000", 46 => "111010000", 47 => "111100000", 48 => "111110000",
        49 => "100000001", 50 => "100010001", 51 => "100100001", 52 => "100110001",
        53 => "101000001", 54 => "101010001", 55 => "101100001", 56 => "101110001",
        57 => "110000001", 58 => "110010001", 59 => "110100001", 60 => "110110001",
        61 => "111000001", 62 => "111010001", 63 => "111100001", 64 => "111110001"
    );

begin

    -- Instantiate the DUT
    UUT: display_output
        port map (
            A => A_tb,
            B => B_tb,
            Cin => Cin_tb,
            A_out => A_out_tb,
            B_out => B_out_tb,
            CinOut => CinOut_tb,
            sevensegA0 => sevensegA0_tb,
            sevensegA1 => sevensegA1_tb,
            sevensegB0 => sevensegB0_tb,
            sevensegB1 => sevensegB1_tb,
            sevensegS0 => sevensegS0_tb,
            sevensegS1 => sevensegS1_tb
        );

    -- Apply all 64 test vectors
    stim_proc: process
    begin
        for i in test_vectors'range loop
            Cin_tb <= test_vectors(i)(8);          -- First bit
            A_tb   <= test_vectors(i)(7 downto 4); -- Middle 4 bits
            B_tb   <= test_vectors(i)(3 downto 0); -- Last 4 bits
            wait for 10 ns;
        end loop;

        wait; -- end simulation
    end process;

end architecture;
