library ieee;
use ieee.std_logic_1164.all;

entity display_output is 
    port (
        A : in std_logic_vector(3 downto 0);
        B : in std_logic_vector(3 downto 0);
        Cin : in std_logic;
        A_out : out std_logic_vector(3 downto 0);
        B_out : out std_logic_vector(3 downto 0);
        CinOut : out std_logic;
        sevensegA0 : out std_logic_vector(0 to 6);
        sevensegA1 : out std_logic_vector(0 to 6);  
        sevensegB0 : out std_logic_vector(0 to 6);
        sevensegB1 : out std_logic_vector(0 to 6);  
        sevensegS0 : out std_logic_vector(0 to 6);
        sevensegS1 : out std_logic_vector(0 to 6) 
    );
end entity display_output;

architecture structural of display_output is
    -- Component declarations remain the same
    component fourbit_adder is 
        port(
            A,B:in std_logic_vector(3 downto 0);
            Cin_initial:in std_logic;
            Cin:buffer std_logic_vector(3 downto 0);
            S:out std_logic_vector(3 downto 0);
            Cout:out std_logic
        );
    end component;
    component fivebit_to_2bcd is 
        port(
            B:in std_logic_vector(4 downto 0);
            tens:out std_logic_vector(3 downto 0);
            ones:out std_logic_vector(3 downto 0)
        );
    end component;
    component bcd_to_7segment is 
        port(
            X:in std_logic_vector(3 downto 0);
            a,b,c,d,e,f,g:out std_logic
        );
    end component;

    -- Internal Signals
    signal s_Sum        : std_logic_vector(3 downto 0);
    signal s_Cout       : std_logic;
    signal s_cin_buffer : std_logic_vector(3 downto 0); 
    signal s_A_tens, s_A_ones : std_logic_vector(3 downto 0);
    signal s_B_tens, s_B_ones : std_logic_vector(3 downto 0);
    signal s_S_tens, s_S_ones : std_logic_vector(3 downto 0);

    -- Internal signals to capture the ACTIVE-HIGH output from the decoders
    signal s_seg_A1_raw, s_seg_A0_raw : std_logic_vector(0 to 6);
    signal s_seg_B1_raw, s_seg_B0_raw : std_logic_vector(0 to 6);
    signal s_seg_S1_raw, s_seg_S0_raw : std_logic_vector(0 to 6);

begin

    -- Adder and BCD Converter instantiations
    Adder_Unit : fourbit_adder port map (A=>A, B=>B, Cin_initial=>Cin, S=>s_Sum, Cout=>s_Cout, Cin=>s_cin_buffer);
    BCD_Converter_A : fivebit_to_2bcd port map (B=>'0'&A, tens=>s_A_tens, ones=>s_A_ones);
    BCD_Converter_B : fivebit_to_2bcd port map (B=>'0'&B, tens=>s_B_tens, ones=>s_B_ones);
    BCD_Converter_S : fivebit_to_2bcd port map (B=>s_Cout & s_Sum, tens=>s_S_tens, ones=>s_S_ones);

    -- 7 Segment Decoding
    -- The decoder outputs are now mapped to our new internal "raw" signals. "raw" means it still adopt the ACTIVE-HIGH condition
    Decoder_A1: bcd_to_7segment port map(X=>s_A_tens, a=>s_seg_A1_raw(0), b=>s_seg_A1_raw(1), c=>s_seg_A1_raw(2), d=>s_seg_A1_raw(3), e=>s_seg_A1_raw(4), f=>s_seg_A1_raw(5), g=>s_seg_A1_raw(6));
    Decoder_A0: bcd_to_7segment port map(X=>s_A_ones, a=>s_seg_A0_raw(0), b=>s_seg_A0_raw(1), c=>s_seg_A0_raw(2), d=>s_seg_A0_raw(3), e=>s_seg_A0_raw(4), f=>s_seg_A0_raw(5), g=>s_seg_A0_raw(6));
    Decoder_B1: bcd_to_7segment port map(X=>s_B_tens, a=>s_seg_B1_raw(0), b=>s_seg_B1_raw(1), c=>s_seg_B1_raw(2), d=>s_seg_B1_raw(3), e=>s_seg_B1_raw(4), f=>s_seg_B1_raw(5), g=>s_seg_B1_raw(6));
    Decoder_B0: bcd_to_7segment port map(X=>s_B_ones, a=>s_seg_B0_raw(0), b=>s_seg_B0_raw(1), c=>s_seg_B0_raw(2), d=>s_seg_B0_raw(3), e=>s_seg_B0_raw(4), f=>s_seg_B0_raw(5), g=>s_seg_B0_raw(6));
    Decoder_S1: bcd_to_7segment port map(X=>s_S_tens, a=>s_seg_S1_raw(0), b=>s_seg_S1_raw(1), c=>s_seg_S1_raw(2), d=>s_seg_S1_raw(3), e=>s_seg_S1_raw(4), f=>s_seg_S1_raw(5), g=>s_seg_S1_raw(6));
    Decoder_S0: bcd_to_7segment port map(X=>s_S_ones, a=>s_seg_S0_raw(0), b=>s_seg_S0_raw(1), c=>s_seg_S0_raw(2), d=>s_seg_S0_raw(3), e=>s_seg_S0_raw(4), f=>s_seg_S0_raw(5), g=>s_seg_S0_raw(6));

    -- Signal inversion for ACTIVE-LOW condition
    -- This section is the fix. It inverts every bit of the raw decoder
    -- output before sending it to the final output ports.
    -- from the bcd_to_7segment, it's already in ACTIVE-LOW state, so just use the same value
    sevensegA1 <= s_seg_A1_raw; 
    sevensegA0 <= s_seg_A0_raw;
    sevensegB1 <= s_seg_B1_raw;
    sevensegB0 <= s_seg_B0_raw;
    sevensegS1 <= s_seg_S1_raw;
    sevensegS0 <= s_seg_S0_raw;

    -- Other outputs
    A_out <= A;
    B_out <= B;
    CinOut <= Cin;

end architecture structural;