-- Template kode untuk ASCII - HEX (7 Segments) Converter
-- Kode ASCII yang harus diterjemahkan adalah:
-- angka 0, 1, 2, 3, 4, 5, 6, 7, 8, dan 9.
-- huruf A, B, C, D, E, F, G, H, I, dan J.
-- Tampilan pada HEX (7 Segments) sebagai berikut:
-- 1 -> 1
-- 2 -> 2
-- 3 -> 3
-- 4 -> 4
-- 5 -> 5
-- 6 -> 6
-- 7 -> 7
-- 8 -> 8
-- 9 -> 9
-- 0 -> 0
-- A -> A
-- B -> b
-- C -> c
-- D -> d
-- E -> E
-- F -> F
-- G -> G
-- H -> H
-- I -> I (di sebelah kiri, tidak seperti angka 1)
-- J -> j (tanpa titik)


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity asciiHex is
	port	(
				i_ascii		:		in		std_logic_vector	(7 downto 0);
				o_hex		:		out		std_logic_vector	(6 downto 0)
			);
end asciiHex;


architecture behavior of asciiHex is
	constant NOL      : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00110000"; 
	constant SATU     : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00110001"; 
	constant DUA      : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00110010"; 
	constant TIGA     : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00110011"; 
	constant EMPAT    : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00110100"; 
	constant LIMA     : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00110101"; 
	constant ENAM     : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00110110"; 
	constant TUJUH    : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00110111"; 
	constant DELAPAN  : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00111000"; 
	constant SEMBILAN : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00111001"; 

	constant A        : STD_LOGIC_VECTOR(7 DOWNTO 0) := "01000001"; 
	constant B        : STD_LOGIC_VECTOR(7 DOWNTO 0) := "01000010"; 
	constant C        : STD_LOGIC_VECTOR(7 DOWNTO 0) := "01000011"; 
	constant D        : STD_LOGIC_VECTOR(7 DOWNTO 0) := "01000100"; 
	constant E        : STD_LOGIC_VECTOR(7 DOWNTO 0) := "01000101"; 
	constant F        : STD_LOGIC_VECTOR(7 DOWNTO 0) := "01000110"; 
	constant G        : STD_LOGIC_VECTOR(7 DOWNTO 0) := "01000111"; 
	constant H        : STD_LOGIC_VECTOR(7 DOWNTO 0) := "01001000"; 
	constant I        : STD_LOGIC_VECTOR(7 DOWNTO 0) := "01001001"; 
	constant J        : STD_LOGIC_VECTOR(7 DOWNTO 0) := "01001010"; 

begin

	process(i_ascii)

	begin 

	case i_ascii is 

	when NOL      => o_hex <= "0000001";
	when SATU     => o_hex <= "1001111"; 
	when DUA      => o_hex <= "0010010"; 
	when TIGA     => o_hex <= "0000110"; 
	when EMPAT    => o_hex <= "1001100"; 
	when LIMA     => o_hex <= "0100100"; 
	when ENAM     => o_hex <= "0100000"; 
	when TUJUH    => o_hex <= "0001111"; 
	when DELAPAN  => o_hex <= "0000000"; 
	when SEMBILAN => o_hex <= "0000100"; 

	when A      => o_hex <= "0001000" ;
	when B     	=> o_hex <= "1100000"; 
	when C      => o_hex <= "0110001"; 
	when D     	=> o_hex <= "1000010"; 
	when E    	=> o_hex <= "0110000"; 
	when F     	=> o_hex <= "0111000"; 
	when G    	=> o_hex <= "0100000"; 
	when H   	=> o_hex <= "1001000"; 
	when I  	=> o_hex <= "1111001"; 
	when J 		=> o_hex <= "1000011"; 
	when others => o_hex <= "1111111"; 

	end case;

	end process;
	
end behavior;