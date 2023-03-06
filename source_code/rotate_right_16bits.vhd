library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rotate_right_16bits is
  Port ( 
        a: in std_logic_vector(15 downto 0);
        rr_a: out std_logic_vector(15 downto 0)
        );
end rotate_right_16bits;

architecture Behavioral of rotate_right_16bits is

begin

rr_a <= a(0) & a(15 downto 1);

end Behavioral;
