-- Nama          : Muhammad Ammar Hanif
-- NIM           : 13224087
-- Rombongan     : -
-- Kelompok      : 5 
-- Percobaan     : 2
-- Tanggal       : 8 Oktober 2024
------------------------------------------------------------------------------
-- Deskripsi
-- Fungsi   : Menentukan fungsi keluaran 1 bit 7 Segment (a-g) berdasarkan 
--            masukan 4 bit X.   
-- Input    : X (4 bit) 
-- Output   : a, b, c, d, e, f, g (masing-masing 1 bit) untuk kondisi apakah
--            bagian pada display menyala atau tidak.

-- Import and use the ieee library
library ieee;
use ieee.std_logic_1164.all;

-- create an entity called "bcd_to_7segment", with 4 bit X as an input and 7 function output
entity bcd_to_7segment is
    port (
        X : in std_logic_vector(3 downto 0);
        a, b, c, d, e, f, g : out std_logic
    );
end entity bcd_to_7segment;

-- Corrected behavioral architecture for ACTIVE-LOW displays
architecture behavioral of bcd_to_7segment is 
begin
    
    -- Invert the SOP function for each segment to match the active-low hardware
    a <= not (((not X(3)) and X(1)) or 
              (X(2) and X(0)) or 
              ((not X(2)) and (not X(1)) and (not X(0))) or 
              X(3));
    b <= not ((not X(2)) or 
              ((not X(1)) and (not X(0))) or 
              (X(1) and X(0)));
    c <= not (X(3) or 
              X(2) or 
              ((not X(3)) and (not X(1))) or 
              ((not X(3)) and X(0)));
    d <= not (X(3) or 
              (X(1) and (not X(0))) or 
              ((not X(2)) and (not X(1)) and (not X(0))) or 
              (X(2) and (not X(1)) and X(0)) or 
              ((not X(2)) and X(1) and X(0)));
    e <= not (((not X(2)) and (not X(1)) and (not X(0))) or 
              (X(1) and (not X(0))));
    f <= not (X(3) or (X(2) and (not X(1))) or 
              ((not X(2)) and (not X(1)) and (not X(0))) or 
              (X(2) and X(1) and (not X(0))));
    g <= not (X(3) or (X(2) and (not X(1))) or 
              ((not X(2)) and X(1) and X(0)) or 
              (X(1) and (not X(0))));

end architecture behavioral;
