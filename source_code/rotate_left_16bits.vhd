library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rotate_left_16bits is
  Port ( 
        a: in std_logic_vector(15 downto 0);
        lr_a: out std_logic_vector(15 downto 0)
        );
end rotate_left_16bits;

architecture Behavioral of rotate_left_16bits is

begin

lr_a <= a(14 downto 0) & a(15);

end Behavioral;
