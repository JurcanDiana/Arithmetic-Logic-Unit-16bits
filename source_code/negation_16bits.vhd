library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity negation_16bits is
  Port ( 
        a: in std_logic_vector(15 downto 0);
        negated_a: out std_logic_vector(15 downto 0)
        );
end negation_16bits;

architecture Behavioral of negation_16bits is

begin

negated_a <= std_logic_vector(unsigned(NOT a) + 1);

end Behavioral;
