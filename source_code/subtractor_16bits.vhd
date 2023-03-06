library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity subtractor_16bits is
  Port ( 
        minuend:    in std_logic_vector(15 downto 0); 
        subtrahend: in std_logic_vector(15 downto 0);
        diff:       out std_logic_vector(15 downto 0)
        );
end subtractor_16bits;

architecture Behavioral of subtractor_16bits is

signal sign_carry: std_logic;
signal temp_carry: std_logic_vector(15 downto 1);
signal inv_subtrahend: std_logic_vector(15 downto 0);

component full_adder is
Port ( 
     a:          in std_logic;
     b:          in std_logic;
     carry_in:   in std_logic;
     sum:        out std_logic;
     carry_out:  out std_logic
    );
end component;

begin

inv_subtrahend <= std_logic_vector(unsigned(NOT subtrahend) + 1);

SUB_0: full_adder port map(
    a => minuend(0),
    b => inv_subtrahend(0),
    carry_in => '0',
    sum => diff(0),
    carry_out => temp_carry(1));

SUB: for i in 1 to 14 generate
    SUB_i: full_adder port map(
        a => minuend(i),
        b => inv_subtrahend(i),
        carry_in => temp_carry(i),
        sum => diff(i),
        carry_out => temp_carry(i+1));
end generate;

SUB_15: full_adder port map(
    a => minuend(15),
    b => inv_subtrahend(15),
    carry_in => temp_carry(15),
    sum => diff(15),
    carry_out => sign_carry);

end Behavioral;
