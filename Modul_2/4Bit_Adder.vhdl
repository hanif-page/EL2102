-- Muhammad Ammar Hanif
-- 13224087
-- EL2102 Praktikum Sistem Digital
-- Tugas Pendahuluan Nomor 3
-- Kelompok 5

-- Import and use the ieee library
library ieee;
use ieee.std_logic_1164.all;

-- Create an entity called fourbit_to_BCD
entity fourbit_to_BCD is 
    port (
        -- A and B, each as the 4 bit input number
        A, B : in std_logic_vector(3 downto 0);

        -- initial Carry input
        Cin_initial : in std_logic;

        -- Create Cin as a buffer, because I only want to use Cin vector inside the internal process (not input, not output)
        Cin : buffer std_logic_vector(3 downto 0);
        
        -- The Sum vector output
        S : out std_logic_vector(3 downto 0);

        -- The Carry output
        Cout : out std_logic;
    );
end entity fourbit_to_BCD;

-- creating a behavioral architecture
architecture behavioral of fourbit_to_BCD is
    -- Generating S(0) and the 1st carry output
    S(0) <= A(0) xor B(0) xor Cin_initial;
    Cin(0) <= (A(0) and B(0)) or 
              (B(0) and Cin_initial) or 
              (A(0) and Cin_initial);
    
    -- Generating S(1) and the 2nd carry output
    S(1) <= A(1) xor B(1) xor Cin(0);
    Cin(1) <= (A(1) and B(1)) or 
              (B(1) and Cin(0)) or 
              (A(1) and Cin(0));

    -- Generating S(2) and the 3rd carry output
    S(2) <= A(2) xor B(2) xor Cin(1);
    Cin(2) <= (A(2) and B(2)) or 
              (B(2) and Cin(1)) or 
              (A(2) and Cin(1));
    
    -- Generating S(3) and the 4th carry output (final carry)
    S(3) <= A(3) xor B(3) xor Cin(2);
    Cin(3) <= (A(3) and B(3)) or 
              (B(3) and Cin(2)) or 
              (A(3) and Cin(2));

    -- Setting the final carry as an output variable
    Cout <= Cin(3);
end architecture behavioral;