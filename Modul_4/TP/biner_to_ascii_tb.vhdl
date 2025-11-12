-- Ini adalah file Testbench untuk biner_to_ascii_converter
-- Fungsi: Menguji konversi Biner (0-9) ke ASCII ('0'-'9')

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Kita memerlukan library NUMERIC_STD untuk konversi tipe data (Integer ke Vektor)
use IEEE.NUMERIC_STD.ALL;

-- Ini adalah entitas testbench, tidak memiliki port
entity biner_to_ascii_converter_tb is
end biner_to_ascii_converter_tb;

architecture sim of biner_to_ascii_converter_tb is

    -- 1. Deklarasikan Komponen (Design Under Test - DUT)
    -- Ini harus sama persis dengan 'entity' di file VHDL Anda 
    component biner_to_ascii_converter is
        Port ( 
            biner_in : in  STD_LOGIC_VECTOR (3 downto 0); 
            ascii_out : out STD_LOGIC_VECTOR (7 downto 0) 
        );
    end component;

    -- 2. Buat Sinyal Internal untuk dihubungkan ke DUT
    signal tb_biner_in  : STD_LOGIC_VECTOR (3 downto 0);
    signal tb_ascii_out : STD_LOGIC_VECTOR (7 downto 0);
    
    -- Definisikan konstanta waktu tunda antar tes
    constant G_DELAY : time := 10 ns;

begin

    -- 3. Instansiasi DUT (Hubungkan sinyal testbench ke port DUT)
    uut : biner_to_ascii_converter
        Port Map (
            biner_in  => tb_biner_in,
            ascii_out => tb_ascii_out
        );

    -- 4. Proses Stimulus (Pemberi Input)
    stim_proc : process
    begin
        report "--- Memulai Simulasi Biner ke ASCII ---";

        -- Kita akan loop dari integer 0 hingga 9
        for i in 0 to 9 loop
            -- Konversi integer 'i' ke std_logic_vector 4-bit
            tb_biner_in <= std_logic_vector(to_unsigned(i, 4));
            
            -- Tunggu G_DELAY agar kita bisa melihat perubahan di waveform
            wait for G_DELAY;
        end loop;

        report "--- Simulasi Biner ke ASCII Selesai ---";
        
        -- Hentikan simulasi
        wait;
    end process;

end sim;