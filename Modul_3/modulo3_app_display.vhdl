-- -- Nama          : Muhammad Ammar Hanif
-- -- NIM           : 13224087
-- -- Kelompok      : 7
-- -- Percobaan     : 3
-- -- Tanggal       : 3 November 2025
-- ------------------------------------------------------------------------------
-- -- Deskripsi
-- -- Top-level design untuk sistem modulo3_app dengan tampilan 7-segmen.
-- -- Menggunakan konversi dari 5-bit ke 2 digit BCD, lalu ke 7-segmen.
-- -- Output:
-- --  - C_modulo ditampilkan pada dua 7-segmen (puluhan dan satuan)
-- --  - D_out juga ditampilkan pada dua 7-segmen (puluhan dan satuan)

-- library IEEE;
-- use IEEE.STD_LOGIC_1164.ALL;
-- use IEEE.NUMERIC_STD.ALL;

-- entity modulo3_app_display is
--     Port (
--         clk         : in  std_logic;
--         reset       : in  std_logic;
--         start       : in  std_logic;
--         Ain, Bin    : in  std_logic_vector(3 downto 0);
--         -- Output tampilan
--         segC_tens, segC_ones : out std_logic_vector(6 downto 0);
--         segD_tens, segD_ones : out std_logic_vector(6 downto 0);
--         ledA, ledB  : out std_logic_vector(3 downto 0);
--         done        : out std_logic
--     );
-- end modulo3_app_display;

-- architecture Structural of modulo3_app_display is

--     -- Internal signals
--     signal C_modulo, D_out : std_logic_vector(3 downto 0);
--     signal C_5bit, D_5bit  : std_logic_vector(4 downto 0);
--     signal C_tens, C_ones  : std_logic_vector(3 downto 0);
--     signal D_tens, D_ones  : std_logic_vector(3 downto 0);

--     -- Komponen utama FSM
--     component modulo3_app
--         Port (
--             clk         : in  std_logic;
--             reset       : in  std_logic;
--             start       : in  std_logic;
--             Ain, Bin    : in  std_logic_vector(3 downto 0);
--             -- ledA, ledB  : out std_logic_vector(3 downto 0);
--             C_modulo    : out std_logic_vector(3 downto 0);
--             D_out       : out std_logic_vector(3 downto 0);
--             done        : out std_logic
--         );
--     end component;

--     -- Konverter 5-bit ke 2 digit BCD
--     component fivebit_to_2bcd
--         port(
--             B     : in  std_logic_vector(4 downto 0);
--             tens  : out std_logic_vector(3 downto 0);
--             ones  : out std_logic_vector(3 downto 0)
--         );
--     end component;

--     -- Decoder BCD ke 7-segment
--     component BCD_to_7segment
--         port (
--             X : in std_logic_vector(3 downto 0);
--             a, b, c, d, e, f, g : out std_logic
--         );
--     end component;

--     -- Internal signals untuk segment hasil decoding
--     signal aC_t, bC_t, cC_t, dC_t, eC_t, fC_t, gC_t : std_logic;
--     signal aC_o, bC_o, cC_o, dC_o, eC_o, fC_o, gC_o : std_logic;
--     signal aD_t, bD_t, cD_t, dD_t, eD_t, fD_t, gD_t : std_logic;
--     signal aD_o, bD_o, cD_o, dD_o, eD_o, fD_o, gD_o : std_logic;

-- begin

--     -- FSM utama
--     U1: modulo3_app
--         port map (
--             clk => clk,
--             reset => reset,
--             start => start,
--             Ain => Ain,
--             Bin => Bin,
--             C_modulo => C_modulo,
--             D_out => D_out,
--             done => done
--         );

--     -- Konversi 4 bit → 5 bit
--     C_5bit <= '0' & C_modulo;
--     D_5bit <= '0' & D_out;

--     -- C_5bit <= '0' & Ain;
--     -- D_5bit <= '0' & Bin;

    
--     -- Konversi 5 bit → 2 digit BCD
--     CONV_C: fivebit_to_2bcd
--         port map (
--             B => C_5bit,
--             tens => C_tens,
--             ones => C_ones
--         );

--     CONV_D: fivebit_to_2bcd
--         port map (
--             B => D_5bit,
--             tens => D_tens,
--             ones => D_ones
--         );

--     -- Konversi BCD → 7 segment (C_modulo)
--     SEG_C_TENS: BCD_to_7segment port map (C_tens, aC_t, bC_t, cC_t, dC_t, eC_t, fC_t, gC_t);
--     SEG_C_ONES: BCD_to_7segment port map (C_ones, aC_o, bC_o, cC_o, dC_o, eC_o, fC_o, gC_o);

--     -- Konversi BCD → 7 segment (D_out)
--     SEG_D_TENS: BCD_to_7segment port map (D_tens, aD_t, bD_t, cD_t, dD_t, eD_t, fD_t, gD_t);
--     SEG_D_ONES: BCD_to_7segment port map (D_ones, aD_o, bD_o, cD_o, dD_o, eD_o, fD_o, gD_o);

--     -- Gabungkan bit segment (a-g) menjadi vektor untuk setiap 7-segmen
--     segC_tens <= gC_t & fC_t & eC_t & dC_t & cC_t & bC_t & aC_t;
--     segC_ones <= gC_o & fC_o & eC_o & dC_o & cC_o & bC_o & aC_o;
--     segD_tens <= gD_t & fD_t & eD_t & dD_t & cD_t & bD_t & aD_t;
--     segD_ones <= gD_o & fD_o & eD_o & dD_o & cD_o & bD_t & aD_o;

--     -- aC_t & bC_t & cC_t & dC_t & eC_t & fC_t & gC_t

--     ledA <= Ain;
--     ledB <= Bin;

-- end Structural;
