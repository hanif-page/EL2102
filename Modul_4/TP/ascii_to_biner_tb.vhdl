library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Ini adalah entitas testbench, tidak memiliki port
entity ascii_to_biner_converter_tb is
end ascii_to_biner_converter_tb;

architecture sim of ascii_to_biner_converter_tb is

    -- 1. Deklarasikan Komponen (Design Under Test - DUT)
    -- Ini harus sama persis dengan 'entity' di file VHDL Anda 
    component ascii_to_biner_converter is
        Port ( 
            ascii_in : in  STD_LOGIC_VECTOR (7 downto 0); 
            biner_out : out STD_LOGIC_VECTOR (3 downto 0) 
        );
    end component;

    -- 2. Buat Sinyal Internal untuk dihubungkan ke DUT
    signal tb_ascii_in  : STD_LOGIC_VECTOR (7 downto 0);
    signal tb_biner_out : STD_LOGIC_VECTOR (3 downto 0);
    
    -- Definisikan konstanta waktu tunda antar tes
    constant G_DELAY : time := 10 ns;

begin

    -- 3. Instansiasi DUT (Hubungkan sinyal testbench ke port DUT)
    uut : ascii_to_biner_converter
        Port Map (
            ascii_in  => tb_ascii_in,
            biner_out => tb_biner_out
        );

    -- 4. Proses Stimulus (Pemberi Input)
    stim_proc : process
    begin
        report "--- Memulai Simulasi ASCII ke Biner ---";

        -- Kita akan loop dari integer 0 hingga 9
        for i in 0 to 9 loop
            -- Logika konversi: ASCII '0' adalah x"30", '1' adalah x"31", dst.
            -- Jadi, kita set 4 bit atas ke "0011" (yaitu '3')
            -- dan 4 bit bawah ke nilai integer 'i'
            tb_ascii_in <= "0011" & std_logic_vector(to_unsigned(i, 4));
            
            -- Tunggu G_DELAY agar kita bisa melihat perubahan di waveform
            wait for G_DELAY;
        end loop;

        report "--- Simulasi ASCII ke Biner Selesai ---";
        
        -- Hentikan simulasi
        wait;
    end process;

end sim;