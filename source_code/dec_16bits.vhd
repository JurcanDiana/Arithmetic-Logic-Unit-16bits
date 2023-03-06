library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity dec_16bits is
  Port ( 
        a: in std_logic_vector(15 downto 0);
        decremented_a: out std_logic_vector(15 downto 0)
        );
end dec_16bits;

architecture Behavioral of dec_16bits is

begin

decremented_a <= std_logic_vector(unsigned(a) - 1);

end Behavioral;
