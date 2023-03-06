library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity not_16bits is
  Port ( 
        a: in std_logic_vector(15 downto 0);
        not_a: out std_logic_vector(15 downto 0)
        );
end not_16bits;

architecture Behavioral of not_16bits is

begin

not_a <= not a;

end Behavioral;
