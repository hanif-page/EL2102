-- Nama		: Muhammad Iqbal Arsyad
-- NIM		: 33223302
-- Koordinator Asisten Praktikum Sistem Digital EL2102
-- Semester 1 Tahun Ajaran 2024/2025
-- 26 Oktober 2024
-- Percobaan 3
-- Deskripsi
-- Berfungsi untuk melakukan pengurangan A dengan B. Ukuran data 4bit.
-- input : A , B
-- output: S

-- Library
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Define entity
entity substractor4bit is
	port	(
				A		:		in			std_logic_vector (3 downto 0);	-- input nilai A
				B		:		in			std_logic_vector (3 downto 0);	-- input nilai B
				Y		:		out		std_logic_vector (3 downto 0)		-- output nilai hasil pengurangan
			);
end substractor4bit;


-- Define arsitektur
architecture rtl of substractor4bit is
	signal num_A	: unsigned (3 downto 0)	:= "0000";	-- sinyal untuk nilai A
	signal num_B	: unsigned (3 downto 0)	:= "0000";	-- sinyal untuk nilai B
	signal num_S	: unsigned (3 downto 0)	:= "0000";	-- sinyal untuk nilai S
begin
	-- nilai A diubah menjadi tipe unsigned dan dimasukkan ke sinyal num_A
	num_A <= unsigned (A);
	-- nilai B diubah menjadi tipe unsigned dan dimasukkan ke sinyal num_B
	num_B <= unsigned (B);
	-- menghitung nilai hasil pengurangan
	num_S <= num_A - num_B;
	-- memasukkan sinyal nilai S ke output S.
	Y <= std_logic_vector (num_S);
end rtl;