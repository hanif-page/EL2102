library ieee;
use ieee.std_logic_1164.all;

-- The testbench entity has no ports.
entity tb_display_output is
end entity tb_display_output;

architecture behavioral of tb_display_output is

    -- 1. Declare the component we want to test.
    component display_output is
        port (
            A          : in  std_logic_vector(3 downto 0);
            B          : in  std_logic_vector(3 downto 0);
            Cin        : in  std_logic;
            A_out      : out std_logic_vector(3 downto 0);
            B_out      : out std_logic_vector(3 downto 0);
            CinOut     : out std_logic;
            sevensegA0 : out std_logic_vector(0 to 6);
            sevensegA1 : out std_logic_vector(0 to 6);
            sevensegB0 : out std_logic_vector(0 to 6);
            sevensegB1 : out std_logic_vector(0 to 6);
            sevensegS0 : out std_logic_vector(0 to 6);
            sevensegS1 : out std_logic_vector(0 to 6)
        );
    end component display_output;

    -- 2. Create signals to connect to the component's ports.
    signal tb_A   : std_logic_vector(3 downto 0);
    signal tb_B   : std_logic_vector(3 downto 0);
    signal tb_Cin : std_logic;
    signal tb_A_out     : std_logic_vector(3 downto 0);
    signal tb_B_out     : std_logic_vector(3 downto 0);
    signal tb_CinOut    : std_logic;
    signal tb_sevensegA0: std_logic_vector(0 to 6);
    signal tb_sevensegA1: std_logic_vector(0 to 6);
    signal tb_sevensegB0: std_logic_vector(0 to 6);
    signal tb_sevensegB1: std_logic_vector(0 to 6);
    signal tb_sevensegS0: std_logic_vector(0 to 6);
    signal tb_sevensegS1: std_logic_vector(0 to 6);

    -- 3. Define the data structure for the test vectors.
    -- Each vector is 9 bits: Cin (1 bit), A (4 bits), B (4 bits)
    type test_vector_array is array (1 to 64) of std_logic_vector(8 downto 0);
    
    -- This constant holds all 64 vectors from your tables.
    -- Format: "C A3 A2 A1 A0 B3 B2 B1 B0"
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

    -- 4. Instantiate the Unit Under Test (UUT).
    UUT : display_output
        port map (
            A => tb_A, B => tb_B, Cin => tb_Cin,
            A_out => tb_A_out, B_out => tb_B_out, CinOut => tb_CinOut,
            sevensegA0 => tb_sevensegA0, sevensegA1 => tb_sevensegA1,
            sevensegB0 => tb_sevensegB0, sevensegB1 => tb_sevensegB1,
            sevensegS0 => tb_sevensegS0, sevensegS1 => tb_sevensegS1
        );

    -- 5. Stimulus Process: This process reads from the constant array.
    stimulus_proc : process
    begin
        report "Starting table-driven test...";

        -- Loop through all 64 vectors in the constant array
        for i in 1 to 64 loop
            -- Assign the bits from the current vector to the input signals
            tb_Cin <= test_vectors(i)(8);
            tb_A   <= test_vectors(i)(7 downto 4);
            tb_B   <= test_vectors(i)(3 downto 0);

            -- Wait for a short time before applying the next vector
            wait for 10 ns;
        end loop;

        report "Test finished after 64 vectors.";
        wait; -- Stop the simulation

    end process stimulus_proc;

end architecture behavioral;