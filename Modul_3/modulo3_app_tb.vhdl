-- -- Nama          : Muhammad Ammar Hanif
-- -- NIM           : 13224087
-- -- Rombongan     : -
-- -- Kelompok      : 7 
-- -- Percobaan     : 3
-- -- Tanggal       : 3 November 2025
-- ------------------------------------------------------------------------------
-- -- Deskripsi
-- -- Fungsi   : Testbench dari modulo3_app.vhdl   
-- -- Input    : 
-- -- Output   : 
-- --          : 

-- library IEEE;
-- use IEEE.STD_LOGIC_1164.ALL;
-- use IEEE.NUMERIC_STD.ALL; -- Diperlukan untuk perbandingan unsigned

-- entity tb_modulo3_app is
-- end tb_modulo3_app;

-- architecture test of tb_modulo3_app is

--     -- 1. Deklarasi Komponen DUT (Device Under Test)
--     component modulo3_app
--         Port (
--             clk         : in  std_logic;
--             reset       : in  std_logic;
--             start       : in  std_logic;
--             Ain, Bin    : in  std_logic_vector(3 downto 0);
--             C_modulo    : out std_logic_vector(3 downto 0);
--             D_out       : out std_logic_vector(3 downto 0);
--             done        : out std_logic
--         );
--     end component;

--     -- 2. Sinyal Internal Testbench
--     signal clk_tb       : std_logic := '0';
--     signal reset_tb     : std_logic;
--     signal start_tb     : std_logic;
--     signal Ain_tb       : std_logic_vector(3 downto 0);
--     signal Bin_tb       : std_logic_vector(3 downto 0);
--     signal C_modulo_tb  : std_logic_vector(3 downto 0);
--     signal D_out_tb     : std_logic_vector(3 downto 0);
--     signal done_tb      : std_logic;

--     -- Konfigurasi Clock
--     constant CLK_PERIOD : time := 1 ns; -- 100 MHz clock

--     -- 3. Tipe data untuk menyimpan test case
--     type test_vector is record
--         A_in  : std_logic_vector(3 downto 0);
--         B_in  : std_logic_vector(3 downto 0);
--         C_exp : unsigned(3 downto 0); -- C (remainder)
--         D_exp : unsigned(3 downto 0);  -- D (quotient)
--     end record;

--     -- Array untuk menyimpan semua test case dari tabel
--     type test_array is array (natural range <>) of test_vector;

--     -- 4. Definisi Test Case
--     -- Berdasarkan tabel: C = A mod B, D = A div B
--     constant TEST_CASES : test_array := (
--         -- A,      B,      C_exp (Nilai C), D_exp (Nilai D)
--         (x"0", x"1", to_unsigned(0, 4), to_unsigned(0, 4)),   -- Baris 1: A=0, B=1
--         (x"1", x"1", to_unsigned(0, 4), to_unsigned(1, 4)),   -- Baris 2: A=1, B=1
--         (x"7", x"3", to_unsigned(1, 4), to_unsigned(2, 4)),   -- Baris 3: A=7, B=3
--         (x"8", x"4", to_unsigned(0, 4), to_unsigned(2, 4)),   -- Baris 4: A=8, B=4
--         (x"F", x"F", to_unsigned(0, 4), to_unsigned(1, 4)),   -- Baris 5: A=15, B=15
--         (x"F", x"1", to_unsigned(0, 4), to_unsigned(15, 4)),  -- Baris 6: A=15, B=1
--         (x"F", x"2", to_unsigned(1, 4), to_unsigned(7, 4)),   -- Baris 7: A=15, B=2
--         (x"E", x"3", to_unsigned(2, 4), to_unsigned(4, 4)),   -- Baris 8: A=14, B=3
--         (x"5", x"7", to_unsigned(5, 4), to_unsigned(0, 4)),   -- Baris 9: A=5, B=7
--         (x"4", x"2", to_unsigned(0, 4), to_unsigned(2, 4)),   -- Baris 10: A=4, B=2
--         (x"9", x"6", to_unsigned(3, 4), to_unsigned(1, 4)),   -- Baris 11: A=9, B=6
--         (x"C", x"5", to_unsigned(2, 4), to_unsigned(2, 4)),   -- Baris 12: A=12, B=5
--         (x"B", x"4", to_unsigned(3, 4), to_unsigned(2, 4)),   -- Baris 13: A=11, B=4
--         (x"2", x"3", to_unsigned(2, 4), to_unsigned(0, 4)),   -- Baris 14: A=2, B=3
--         (x"D", x"7", to_unsigned(6, 4), to_unsigned(1, 4))    -- Baris 15: A=13, B=7
--     );

-- begin

--     -- 5. Instansiasi DUT
--     UUT : modulo3_app
--         port map (
--             clk       => clk_tb,
--             reset     => reset_tb,
--             start     => start_tb,
--             Ain       => Ain_tb,
--             Bin       => Bin_tb,
--             C_modulo  => C_modulo_tb,
--             D_out     => D_out_tb,
--             done      => done_tb
--         );

--     -- 6. Proses Generator Clock
--     clk_process : process
--     begin
--         clk_tb <= '0';
--         wait for CLK_PERIOD / 2;
--         clk_tb <= '1';
--         wait for CLK_PERIOD / 2;
--     end process;

--     -- 7. Proses Stimulus
--     stimulus_process : process
--     begin
--         -- Reset awal
--         reset_tb <= '1';
--         start_tb <= '0';
--         Ain_tb   <= (others => '0');
--         Bin_tb   <= (others => '0');
--         wait for CLK_PERIOD * 5; -- Tahan reset
--         reset_tb <= '0';
--         wait for CLK_PERIOD;

--         -- Loop melalui semua test case
--         for i in TEST_CASES'range loop
--             report "----------------------------------------------------";
--             report "TEST " & integer'image(i) & ": A=" &
--                    integer'image(to_integer(unsigned(TEST_CASES(i).A_in))) & ", B=" &
--                    integer'image(to_integer(unsigned(TEST_CASES(i).B_in)));
            
--             report "  EXPECT: C=" & integer'image(to_integer(TEST_CASES(i).C_exp)) &
--                    ", D=" & integer'image(to_integer(TEST_CASES(i).D_exp));

--             -- Berikan input
--             Ain_tb <= TEST_CASES(i).A_in;
--             Bin_tb <= TEST_CASES(i).B_in;

--             -- Beri pulsa 'start'
--             start_tb <= '1';
--             wait for CLK_PERIOD;
--             start_tb <= '0';

--             -- Tunggu FSM selesai (atau timeout)
--             wait until done_tb = '1' for CLK_PERIOD * 50;

--             -- Cek hasil
--             if done_tb = '1' then
--                 -- Cek C_modulo
--                 assert (unsigned(C_modulo_tb) = TEST_CASES(i).C_exp)
--                     report "FAIL (C_modulo): Expected " & integer'image(to_integer(TEST_CASES(i).C_exp)) &
--                            ", Got " & integer'image(to_integer(unsigned(C_modulo_tb)))
--                     severity error;
                
--                 -- Cek D_out
--                 assert (unsigned(D_out_tb) = TEST_CASES(i).D_exp)
--                     report "FAIL (D_out): Expected " & integer'image(to_integer(TEST_CASES(i).D_exp)) &
--                            ", Got " & integer'image(to_integer(unsigned(D_out_tb)))
--                     severity error;

--             else
--                 report "TEST " & integer'image(i) & " TIMEOUT! 'done' signal never went high."
--                 severity error;
--             end if;
            
--             wait for CLK_PERIOD * 2; -- Jeda antar tes
        
--         end loop;

--         report "----------------------------------------------------";
--         report "Semua test case selesai." severity failure; -- Hentikan simulasi
--         wait;
--     end process;

-- end architecture;