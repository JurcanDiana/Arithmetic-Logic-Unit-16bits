library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity and_16bits is
  Port ( 
        op1: in std_logic_vector(15 downto 0);
        op2: in std_logic_vector(15 downto 0);
        res: out std_logic_vector(15 downto 0)
        );
end and_16bits;

architecture Behavioral of and_16bits is

begin

res <= op1 and op2;

end Behavioral;
