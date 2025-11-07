-- Nama          : Muhammad Ammar Hanif
-- NIM           : 13224087
-- Rombongan     : -
-- Kelompok      : 5 
-- Percobaan     : 4
-- Tanggal       : 12 November 2025
------------------------------------------------------------------------------
-- Deskripsi
-- Fungsi   : Mengonversi karakter ASCII 8-bit dari sebuah angka ('0' - '9') menjadi nilai biner 4-bit (0000 - 1001).
--            Contoh: Input "0011 0001" ('1') -> Output "0001" (1)   
-- Input    : ascii_in (8 bit) untuk 8-bit kode ASCII. Diasumsikan hanya menerima nilai '0' (x"30") hingga '9' (x"39") 
-- Output   : biner_out (4 bit) untuk 4-bit nilai biner yang sesuai.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- ENTITY Declaration
entity ascii_to_biner_converter is
    Port ( 
        ascii_in : in  STD_LOGIC_VECTOR (7 downto 0); 
        biner_out : out STD_LOGIC_VECTOR (3 downto 0)
    );
end ascii_to_biner_converter;

-- ARCHITECTURE Definition
architecture Behavioral of ascii_to_biner_converter is
begin

    -- Nilai biner = 4 bit terendah dari input (dengan asumsi ekspektasi output hanya angka 0-9)
    biner_out <= ascii_in(3 downto 0);

end Behavioral;