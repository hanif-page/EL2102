-- Nama		: Muhammad Iqbal Arsyad
-- NIM		: 33223302
-- Koordinator Asisten Praktikum Sistem Digital EL2102
-- Semester 1 Tahun Ajaran 2024/2025
-- 26 Oktober 2024
-- Percobaan 3
-- Deskripsi
-- Berfungsi untuk menyimpan nilai berukuran 4 bit. menyimpan nilai jika diaktifkan.
-- input:
--			A		data 4 bit
--			En		sinyal pengaktifan.
--			Clk	sinyal clock
--			Res	sinyal reset. Mengubah isi menjadi 0.
--	output:
--			Data	luaran data yang tersimpan.

-- Library
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Define entity
entity register4bit is
	port	(
				d		:		in		std_logic_vector (3 downto 0);	-- data A
				enable		:		in		std_logic;								-- sinyal Enable
				reset	:		in		std_logic;								-- sinyal Reset
				Clk	:		in		std_logic;								-- sinyal Clock
				q	:		out	std_logic_vector (3 downto 0)		-- luaran data
			);
end register4bit;

-- Define architecture
architecture rtl of register4bit is
	-- sinyal untuk data yang akan disimpan. default bernilai 0.
	signal v_data	:	std_logic_vector (3 downto 0) := "0000";
	
begin
	-- proses dengan mengamati sinyal clock
	process (Clk)
	begin
		-- jika sinyal clock berubah dan bernilai 1
		if rising_edge (Clk) then
			-- check sinyal reset. jika bernilai 1, maka ...
			if (reset = '1') then
				-- data diubah menjadi 0.
				v_data <= "0000";
			else
			-- sinyal reset bernilai 0.
				-- jika sinyal enable bernilai 1, maka simpan data
				if(enable = '1') then
					-- data A disimpan ke sinyal data
					v_data <= d;
				end if;
			end if;
		end if;
	end process;
	-- sinyal data dimasukkan ke luaran Data.
	q <= v_data;
end rtl;
	