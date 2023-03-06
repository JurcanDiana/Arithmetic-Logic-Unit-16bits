library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder_16bits is
  Port ( 
        op1: in std_logic_vector(15 downto 0);
        op2: in std_logic_vector(15 downto 0);
        sum: out std_logic_vector(15 downto 0)
        );
end adder_16bits;

architecture Behavioral of adder_16bits is

component full_adder is
Port ( 
     a:          in std_logic;
     b:          in std_logic;
     carry_in:   in std_logic;
     sum:        out std_logic;
     carry_out:  out std_logic
    );
end component;

signal sign_carry: std_logic;
signal temp_carry: std_logic_vector(15 downto 1);

begin

FA_0: full_adder port map(
    a => op1(0),
    b => op2(0),
    carry_in => '0',
    sum => sum(0),
    carry_out => temp_carry(1));

ADDERS: for i in 1 to 14 generate
    FA_i: full_adder port map(
        a => op1(i),
        b => op2(i),
        carry_in => temp_carry(i),
        sum => sum(i),
        carry_out => temp_carry(i+1));
end generate;

FA_15: full_adder port map(
    a => op1(15),
    b => op2(15),
    carry_in => temp_carry(15),
    sum => sum(15),
    carry_out => sign_carry);

end Behavioral;
