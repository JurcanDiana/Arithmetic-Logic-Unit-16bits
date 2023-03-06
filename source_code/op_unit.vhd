library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity op_unit is
    Port ( enable, clk : in std_logic;
           operand1 : in std_logic_vector (15 downto 0);
           operand2 : in std_logic_vector (15 downto 0);
           mode : in std_logic_vector (3 downto 0);
           flag: out std_logic;
           result : out std_logic_vector (31 downto 0));
end op_unit;

architecture Behavioral of op_unit is

component adder_16bits is
  Port ( 
        op1: in std_logic_vector(15 downto 0);
        op2: in std_logic_vector(15 downto 0);
        sum: out std_logic_vector(15 downto 0)
        );
end component;

component subtractor_16bits is
  Port ( 
        minuend: in std_logic_vector(15 downto 0);
        subtrahend: in std_logic_vector(15 downto 0);
        diff: out std_logic_vector(15 downto 0)
        );
end component;

component inc_16bits is
  Port ( 
        a: in std_logic_vector(15 downto 0);
        incremented_a: out std_logic_vector(15 downto 0)
        );
end component;

component dec_16bits is
  Port ( 
        a: in std_logic_vector(15 downto 0);
        decremented_a: out std_logic_vector(15 downto 0)
        );
end component;

component and_16bits is
  Port ( 
        op1: in std_logic_vector(15 downto 0);
        op2: in std_logic_vector(15 downto 0);
        res: out std_logic_vector(15 downto 0)
        );
end component;

component or_16bits is
  Port ( 
        op1: in std_logic_vector(15 downto 0);
        op2: in std_logic_vector(15 downto 0);
        res: out std_logic_vector(15 downto 0)
        );
end component;

component not_16bits is
  Port ( 
        a: in std_logic_vector(15 downto 0);
        not_a: out std_logic_vector(15 downto 0)
        );
end component;

component negation_16bits is
  Port ( 
        a: in std_logic_vector(15 downto 0);
        negated_a: out std_logic_vector(15 downto 0)
        );
end component;

component rotate_left_16bits is
  Port ( 
        a: in std_logic_vector(15 downto 0);
        lr_a: out std_logic_vector(15 downto 0)
        );
end component;

component rotate_right_16bits is
  Port ( 
        a: in std_logic_vector(15 downto 0);
        rr_a: out std_logic_vector(15 downto 0)
        );
end component;

component multiplier is
    Port ( multiplicand : in STD_LOGIC_VECTOR (15 downto 0);
           multiplier : in STD_LOGIC_VECTOR (15 downto 0);
           product : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component divider is
    Port ( dividend : in STD_LOGIC_VECTOR (15 downto 0);
           divisor : in STD_LOGIC_VECTOR (15 downto 0);
           quotient : out STD_LOGIC_VECTOR (15 downto 0));
end component;

signal add_result, sub_result, inc_result, dec_result : std_logic_vector (15 downto 0);
signal and_result, or_result, not_result, negation_result : std_logic_vector (15 downto 0);
signal rr_result, lr_result, div_result: std_logic_vector (15 downto 0);
signal mul_result: std_logic_vector(31 downto 0);

begin
    
    adder_portmap: adder_16bits
    port map 
       (op1 => operand1, 
        op2 => operand2, 
        sum => add_result); 
    
    subtractor_portmap: subtractor_16bits
    port map 
       (minuend => operand1, 
        subtrahend => operand2, 
        diff => sub_result);
        
    inc_portmap: inc_16bits
    port map
        (a => operand1,
         incremented_a => inc_result);
        
    dec_portmap: dec_16bits
    port map
        (a => operand1,
         decremented_a => dec_result);
        
    and_portmap: and_16bits
    port map
        (op1 => operand1,
         op2 => operand2,
         res => and_result);
    
    or_portmap: or_16bits
    port map
        (op1 => operand1,
         op2 => operand2,
         res => or_result);
        
    not_portmap: not_16bits
    port map
        (a => operand1,
         not_a => not_result);
        
    negation_portmap: negation_16bits
    port map
        (a => operand1,
         negated_a => negation_result);
      
    lr_portmap: rotate_left_16bits
    port map
        (a => operand1,
         lr_a => lr_result);
          
    rr_portmap: rotate_right_16bits
    port map
        (a => operand1,
         rr_a => rr_result);
         
    mul_portmap: multiplier
    port map
        (multiplicand => operand1,
         multiplier => operand2, 
         product => mul_result);
         
    div_portmap: divider
    port map 
        (dividend => operand1,
         divisor => operand2,
         quotient => div_result);
    
    master: process (enable, operand1, operand2, mode, clk)
    begin
        if rising_edge(clk) then
            if enable = '1' then
                result (31 downto 16) <= (others => '0');
                
                case mode is
                    when "0000" =>  
                        flag <= '0';
                        result(15 downto 0) <= add_result;--ADD
                        
                    when "0001" => 
                        flag <= '0';
                        result(15 downto 0) <= sub_result;--SUB
                     
                    when "0010" => 
                        flag <= '0';
                        result(15 downto 0) <= inc_result;--INC
                        
                    when "0011" => 
                        flag <= '0';
                        result(15 downto 0) <= dec_result;--DEC
                    
                    when "0100" => 
                        flag <= '0';
                        result(15 downto 0) <= and_result;--AND
                        
                    when "0101" => 
                        flag <= '0';
                        result(15 downto 0) <= or_result;--OR
                     
                    when "0110" => 
                        flag <= '0';
                        result(15 downto 0) <= not_result;--NOT
                     
                    when "0111" => 
                        flag <= '0';
                        result(15 downto 0) <= negation_result;--NEG
                    
                    when "1000" => 
                        flag <= '0';
                        result(15 downto 0) <= lr_result;--LR
                     
                    when "1001" => 
                        flag <= '0';
                        result(15 downto 0) <= rr_result;--RR
                    
                    when "1010" => 
                        flag <= '1';
                        result <= mul_result;--MUL
                    
                    when "1011" => 
                        flag <= '0';
                        result(15 downto 0) <= div_result;--DIV
                    
                    when others => result <= (others => 'U');
                    flag <= '0';
                    
                end case;
            else
                flag <= '0';
            end if;
        end if;          
    end process; 

end Behavioral;
