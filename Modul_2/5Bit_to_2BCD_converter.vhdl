library ieee;
use ieee.std_logic_1164.all;

entity bin5_to_2bcd is
    port(
        bin       : in  std_logic_vector(4 downto 0); -- input binary (b4 is MSB)
        bcd_tens  : out std_logic_vector(3 downto 0); -- tens BCD digit (4 bits)
        bcd_units : out std_logic_vector(3 downto 0)  -- units BCD digit (4 bits)
    );
end entity;

architecture behavioral_sop of bin5_to_2bcd is
begin

    -- Tens digit bit 0 (LSB of tens BCD)
    bcd_tens(0) <=
          (bin(1) = '1' and bin(2) = '1' and bin(3) = '1')
      or  (bin(1) = '1' and bin(3) = '1' and not (bin(4) = '1'))
      or  (bin(2) = '1' and bin(3) = '1' and not (bin(4) = '1'))
      or  (bin(4) = '1' and not (bin(2) = '1') and not (bin(3) = '1'));

    -- Tens digit bit 1
    bcd_tens(1) <=
          (bin(2) = '1' and bin(4) = '1')
      or  (bin(3) = '1' and bin(4) = '1');

    -- Tens digit bits 2 and 3 are always 0 for 0..31 (no value >= 40)
    bcd_tens(2) <= '0';
    bcd_tens(3) <= '0';

    -- Units digit bit 0 (LSB of units BCD) is simply input LSB
    bcd_units(0) <= bin(0);

    -- Units digit bit 1
    bcd_units(1) <=
          (bin(1) = '1' and bin(2) = '1' and not (bin(3) = '1'))
      or  (bin(1) = '1' and not (bin(3) = '1') and not (bin(4) = '1'))
      or  (bin(1) = '1' and bin(3) = '1' and bin(4) = '1' and not (bin(2) = '1'))
      or  (bin(2) = '1' and bin(3) = '1' and not (bin(1) = '1') and not (bin(4) = '1'))
      or  (bin(4) = '1' and not (bin(1) = '1') and not (bin(2) = '1') and not (bin(3) = '1'));

    -- Units digit bit 2
    bcd_units(2) <=
          (bin(1) = '1' and bin(2) = '1' and not (bin(4) = '1'))
      or  (bin(3) = '1' and bin(4) = '1' and not (bin(2) = '1'))
      or  (bin(2) = '1' and not (bin(3) = '1') and not (bin(4) = '1'))
      or  (bin(4) = '1' and not (bin(1) = '1') and not (bin(2) = '1'));

    -- Units digit bit 3 (MSB of units BCD)
    bcd_units(3) <=
          (bin(2) = '1' and bin(3) = '1' and bin(4) = '1' and not (bin(1) = '1'))
      or  (bin(1) = '1' and bin(4) = '1' and not (bin(2) = '1') and not (bin(3) = '1'))
      or  (bin(3) = '1' and not (bin(1) = '1') and not (bin(2) = '1') and not (bin(4) = '1'));

end architecture;
