-- Nama          : Muhammad Ammar Hanif
-- NIM           : 13224087
-- Rombongan     : -
-- Kelompok      : 5 
-- Percobaan     : 2
-- Tanggal       : 8 Oktober 2024
------------------------------------------------------------------------------
-- Deskripsi
-- Fungsi   : Melakukan konversi 5 bit B menjadi sebuah dua digit BCD   
-- Input    : B (5 bit) 
-- Output   : tens (4 bit) untuk nilai puluhan dari BCD
--          : ones (4 bit) untuk nilai satuan dari BCD
  
-- Import and use the ieee library
library ieee;
use ieee.std_logic_1164.all;

-- Create an entity called fivebit_to_2bcd
entity fivebit_to_2bcd is
    port(
        -- B as the input 5 bit number
        B     : in  std_logic_vector(4 downto 0);

        -- tens, output, in the form of vector variable 
        tens  : out std_logic_vector(3 downto 0);
        
        -- ones, output, in the form of vector variable
        ones  : out std_logic_vector(3 downto 0)
    );
end entity fivebit_to_2bcd;

-- creating a behavioral architecture
architecture behavioral of fivebit_to_2bcd is
begin
    -- This logic functions comes from the truth table of five bit to 2 BCD converter. The logic functions are generated from the Digital application by constructing the Truth Table first. The truth table and the generated logic function can be seen at Lampiran 4 in the Tugas Pendahuluan.

    -- Tens in digit logic form
    tens(3) <= '0';
    tens(2) <= '0';
    tens(1) <= (B(4) and B(2)) or (B(4) and B(3));
    tens(0) <= ((not B(4)) and B(3) and B(1)) or
               ((not B(4)) and B(3) and B(2)) or
               (B(4) and (not B(3)) and (not B(2))) or
               (B(3) and B(2) and B(1));

    -- Ones in digit logic form
    ones(3) <= ((not B(4)) and B(3) and (not B(2)) and (not B(1))) or
               (B(4) and (not B(3)) and (not B(2)) and B(1)) or
               (B(4) and B(3) and B(2) and (not B(1)));

    ones(2) <= ((not B(4)) and (not B(3)) and B(2)) or
               ((not B(4)) and B(2) and B(1)) or
               (B(4) and (not B(2)) and (not B(1))) or
               (B(4) and B(3) and (not B(2)));

    ones(1) <= ((not B(4)) and (not B(3)) and B(1)) or
               ((not B(4)) and B(3) and B(2) and (not B(1))) or
               (B(4) and (not B(3)) and (not B(2)) and (not B(1))) or
               (B(4) and B(3) and (not B(2)) and B(1)) or
               ((not B(3)) and B(2) and B(1));

    ones(0) <= B(0);

end architecture behavioral;
