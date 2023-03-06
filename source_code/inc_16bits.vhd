library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity inc_16bits is
  Port ( 
        a: in std_logic_vector(15 downto 0);
        incremented_a: out std_logic_vector(15 downto 0)
        );
end inc_16bits;

architecture Behavioral of inc_16bits is

begin

incremented_a <= std_logic_vector(unsigned(a) + 1);

end Behavioral;
