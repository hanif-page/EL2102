-- Nama          : Muhammad Ammar Hanif
-- NIM           : 13224087
-- Rombongan     : -
-- Kelompok      : 5 
-- Percobaan     : 4
-- Tanggal       : 12 November 2025
------------------------------------------------------------------------------
-- Deskripsi
-- Fungsi   : Mengonversi nilai biner 4-bit (0000 - 1001) menjadi karakter ASCII 8-bit yang sesuai ('0' - '9').
--            Contoh: Input "0001" (1) -> Output "0011 0001" ('1')
-- Input    : biner_in (4 bit) untuk 4-bit nilai biner. Diasumsikan hanya menerima nilai 0 (0000) hingga 9 (1001). 
-- Output   : ascii_out (8 bit) untuk 8-bit kode ASCII yang sesuai.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- ENTITY Declaration
entity biner_to_ascii_converter is
    Port ( 
        biner_in : in  STD_LOGIC_VECTOR (3 downto 0);
        ascii_out : out STD_LOGIC_VECTOR (7 downto 0)
    );
end biner_to_ascii_converter;

-- ARCHITECTURE Definition
architecture Behavioral of biner_to_ascii_converter is
begin

    -- Kode ASCII => Menambahkan prefix 4-bit "0011" ke nilai biner input (dengan asumsi input hanya angka 0-9)
    ascii_out <= "0011" & biner_in;

end Behavioral;