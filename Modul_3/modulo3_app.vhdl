-- Nama          : Muhammad Ammar Hanif
-- NIM           : 13224087
-- Rombongan     : -
-- Kelompok      : 7 
-- Percobaan     : 3
-- Tanggal       : 3 November 2025
------------------------------------------------------------------------------
-- Deskripsi
-- Fungsi   : Melakukan proses kombinasional (dengan refer ke entity building block di file lain) dan sekuensial (FSM)   
-- Input    : 
-- Output   : 
--          : 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity modulo3_app is
    Port (
        clk         : in  std_logic;                   
        reset       : in  std_logic;                 
        start       : in  std_logic;                  
        Ain, Bin    : in  std_logic_vector(3 downto 0);
        C_modulo    : out std_logic_vector(3 downto 0);
        D_out       : out std_logic_vector(3 downto 0);
        -- ledA, ledB  : out std_logic_vector(3 downto 0);
        done        : out std_logic;
        segC_tens, segC_ones, segD_tens, segD_ones : out std_logic_vector(6 downto 0)                
    );
end modulo3_app;

architecture Behavioral of modulo3_app is

    type state_type is (IDLE, CHECK, SUBSTRACT, STOP);
    signal current_state, next_state : state_type;

    signal A_reg, B_reg, sub_out : std_logic_vector(3 downto 0);
    signal selA, selB : std_logic := '0';
    signal enA, enB, enCounter : std_logic := '0';
    signal le : std_logic;
    signal counter_out : std_logic_vector(3 downto 0);
    signal d_for_A : std_logic_vector(3 downto 0);
    signal mux_sel_A : std_logic;

    -- for converting to 7 Segment
    signal C_5bit, D_5bit  : std_logic_vector(4 downto 0);
    signal C_tens, C_ones  : std_logic_vector(3 downto 0);
    signal D_tens, D_ones  : std_logic_vector(3 downto 0); 

        -- Konverter 5-bit ke 2 digit BCD
    component fivebit_to_2bcd
        port(
            B     : in  std_logic_vector(4 downto 0);
            tens  : out std_logic_vector(3 downto 0);
            ones  : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Decoder BCD ke 7-segment
    component BCD_to_7segment
        port (
            X : in std_logic_vector(3 downto 0);
            a, b, c, d, e, f, g : out std_logic
        );
    end component;

    -- Internal signals untuk segment hasil decoding
    signal aC_t, bC_t, cC_t, dC_t, eC_t, fC_t, gC_t : std_logic;
    signal aC_o, bC_o, cC_o, dC_o, eC_o, fC_o, gC_o : std_logic;
    signal aD_t, bD_t, cD_t, dD_t, eD_t, fD_t, gD_t : std_logic;
    signal aD_o, bD_o, cD_o, dD_o, eD_o, fD_o, gD_o : std_logic;

    -- New local reset signal for the counter
    signal counter_reset_local : std_logic := '0';
    signal counter_reset : std_logic;

    -- adding a rising edge for start_pulse
    signal start_sync, start_prev, start_pulse : std_logic := '0';

    component register4bit
        port (
            clk, reset, enable : in  std_logic;
            d : in  std_logic_vector(3 downto 0);
            q : out std_logic_vector(3 downto 0)
        );
    end component;

    component comparator4bit
        port (
            A, B : in  std_logic_vector(3 downto 0);
            le : out std_logic
        );
    end component;

    component substractor4bit
        port (
            A, B : in  std_logic_vector(3 downto 0);
            Y : out std_logic_vector(3 downto 0)
        );
    end component;

    component mux2to1_4bit
        port (
            Sel : in std_logic;
            A, B : in std_logic_vector(3 downto 0);
            Data : out std_logic_vector(3 downto 0)
        );
    end component;

    component counter4bit
        port (
            clk, reset, enable : in std_logic;
            q : out std_logic_vector(3 downto 0)
        );
    end component;
    
begin
    -- Combine global and local reset for the counter
    counter_reset <= reset or counter_reset_local;

    -- MUX
    mux_sel_A <= '1' when current_state = SUBSTRACT else '0';
    MUX_A: mux2to1_4bit
        port map (
            Sel  => mux_sel_A,
            A    => Ain,
            B    => sub_out,
            Data => d_for_A
        );

    -- Register A
    REG_A: register4bit
        port map (
            clk => clk,
            reset => reset,
            enable => enA,
            d => d_for_A,
            q => A_reg
        );

    -- Register B
    REG_B: register4bit
        port map (
            clk => clk,
            reset => reset,
            enable => enB,
            d => Bin,
            q => B_reg
        );

    -- Comparator
    COMP: comparator4bit
        port map (
            A => A_reg,
            B => B_reg,
            le => le
        );

    -- Substractor
    SUB: substractor4bit
        port map (
            A => A_reg,
            B => B_reg,
            Y => sub_out
        );

    -- Counter
    CNT: counter4bit
        port map (
            clk => clk,
            reset => counter_reset,
            enable => enCounter,
            q => counter_out
        );

    CONV_C: fivebit_to_2bcd
        port map (
            B => C_5bit,
            tens => C_tens,
            ones => C_ones
        );

    CONV_D: fivebit_to_2bcd
        port map (
            B => D_5bit,
            tens => D_tens,
            ones => D_ones
        );

    SEG_C_TENS: BCD_to_7segment port map (C_tens, aC_t, bC_t, cC_t, dC_t, eC_t, fC_t, gC_t);
    SEG_C_ONES: BCD_to_7segment port map (C_ones, aC_o, bC_o, cC_o, dC_o, eC_o, fC_o, gC_o);

    -- Konversi BCD → 7 segment (D_out)
    SEG_D_TENS: BCD_to_7segment port map (D_tens, aD_t, bD_t, cD_t, dD_t, eD_t, fD_t, gD_t);
    SEG_D_ONES: BCD_to_7segment port map (D_ones, aD_o, bD_o, cD_o, dD_o, eD_o, fD_o, gD_o);

    -- FSM Sequential
    process(clk, reset)
    begin
        if reset = '1' then
            start_sync <= '0';
            start_prev <= '0';
            start_pulse <= '0';
            current_state <= IDLE;
        elsif rising_edge(clk) then
            start_prev <= start_sync;
            start_sync <= start;
            start_pulse <= start_sync and not start_prev; -- detecting rising edge
            current_state <= next_state;
        end if;
    end process;

    -- FSM Combinational
    process(current_state, start_pulse, le)
    begin
        enA <= '0';
        enB <= '0';
        enCounter <= '0';
        done <= '0';
        counter_reset_local <= '0';
        next_state <= current_state;

        case current_state is

            when IDLE =>
                if start_pulse = '1' then
                    enA <= '1';
                    enB <= '1';
                    next_state <= CHECK;
                end if;

            when CHECK =>
                if le = '1' then
                    next_state <= STOP;
                else
                    next_state <= SUBSTRACT;
                end if;

            when SUBSTRACT =>
                enA <= '1';
                enCounter <= '1';
                next_state <= CHECK;

            when STOP =>
                counter_reset_local <= '1'; -- Reset counter every time we return to IDLE
                done <= '1';
                next_state <= IDLE;

        end case;

    end process;

    -- Output
    C_modulo <= A_reg;
    D_out    <= counter_out;

    -- ERROR
    C_5bit <= '0' & A_reg; 
    D_5bit <= '0' & counter_out;

    -- Gabungkan bit segment (a-g) menjadi vektor untuk setiap 7-segmen
    segC_tens <= gC_t & fC_t & eC_t & dC_t & cC_t & bC_t & aC_t;
    segC_ones <= gC_o & fC_o & eC_o & dC_o & cC_o & bC_o & aC_o;
    segD_tens <= gD_t & fD_t & eD_t & dD_t & cD_t & bD_t & aD_t;
    segD_ones <= gD_o & fD_o & eD_o & dD_o & cD_o & bD_o & aD_o;

end Behavioral;
