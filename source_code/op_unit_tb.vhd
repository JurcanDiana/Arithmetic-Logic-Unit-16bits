library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity op_unit_tb is
--  Port ( );
end op_unit_tb;

architecture Behavioral of op_unit_tb is
component op_unit is
    Port ( enable, clk : in STD_LOGIC;
           flag : out STD_LOGIC;
           operand1 : in STD_LOGIC_VECTOR (15 downto 0);
           operand2 : in STD_LOGIC_VECTOR (15 downto 0);
           mode : in STD_LOGIC_VECTOR (3 downto 0);
           result : out STD_LOGIC_VECTOR (31 downto 0));
end component;

signal t_operand1, t_operand2 : STD_LOGIC_VECTOR (15 downto 0);
signal t_result : STD_LOGIC_VECTOR (31 downto 0);
signal t_mode : STD_LOGIC_VECTOR (3 downto 0);
signal t_flag, t_enable : std_logic;
signal t_clk : std_logic := '0';

begin

    uut: op_unit
    port map 
           (enable => t_enable, 
            clk => t_clk, 
            flag => t_flag, 
            operand1 => t_operand1, 
            operand2 => t_operand2, 
            mode => t_mode, 
            result => t_result);
    
    process
    begin
        if t_clk = '0' then
            t_clk <= '1';
        else 
             t_clk <= '0';
        end if;
        wait for 5ns;
    end process;
    
    process 
    begin
        t_enable <= '1';
        
        t_operand1 <= "1111111111111010";
        t_operand2 <= "1111111110000101";
        wait for 10ns;
        
        -- ADD
        t_mode <= "0000";
        -- Two's complement (-6) = 1111111111111010
        t_operand1 <= "1111111111111010"; --FFFA
        -- Two's complement (-123) = 1111111110000101
        t_operand2 <= "1111111110000101"; --FF85  
        -- result: 11 111111101111111 (-129)
        -- HEX: 1 FF7F
        wait for 10ns;
        
        -- SUB
        t_mode <= "0001";
        -- Two's complement (-6) = 1111111111111010
        t_operand1 <= "1111111111111010"; --FFFA
        -- Two's complement (-123) = 1111111110000101
        t_operand2 <= "1111111110000101"; --FF85  
        -- result: 0000 0000 0111 0101 (117)
        -- HEX: 75
        wait for 10ns;
        
        -- INC
        t_mode <= "0010";
        -- Two's complement (-6) = 1111111111111010
        t_operand1 <= "1111111111111010"; --FFFA 
        -- result: 1111111111111011 (-5)
        -- HEX: FFFB
        wait for 10ns;
        
        -- DEC
        t_mode <= "0011";
        -- Two's complement (-6) = 1111111111111010
        t_operand1 <= "1111111111111010"; --FFFA    
        -- result: 1111111111111001 (-7)
        -- HEX: FFF9
        wait for 10ns;
        
        -- AND
        t_mode <= "0100";
        -- Two's complement (-6) = 1111111111111010
        t_operand1 <= "1111111111111010"; --FFFA
        -- Two's complement (-123) = 1111111110000101
        t_operand2 <= "1111111110000101"; --FF85  
        -- result: 1111111110000100 (-124)
        -- HEX: FF84
        wait for 10ns;
        
        -- OR
        t_mode <= "0101";
        -- Two's complement (-6) = 1111111111111010
        t_operand1 <= "1111111111111010"; --FFFA
        -- Two's complement (-123) = 1111111110000101
        t_operand2 <= "1111111110000101"; --FF85  
        -- result: 1111111111111111 (-1)
        -- HEX: FFFF
        wait for 10ns;
        
        -- NOT
        t_mode <= "0110";
        -- Two's complement (-6) = 1111111111111010
        t_operand1 <= "1111111111111010"; --FFFA
        -- result: 0000000000000101 (5)
        -- HEX: 5
        wait for 10ns;
        
        -- NEG
        t_mode <= "0111";
        -- Two's complement (-6) = 1111111111111010
        t_operand1 <= "1111111111111010"; --FFFA
        -- result: 0000000000000110 (6)
        -- HEX: 6
        wait for 10ns;
        
        -- LR
        t_mode <= "1000";
        -- Two's complement (-6) = 1111111111111010
        t_operand1 <= "1111111111111010"; --FFFA
        -- result: 1111111111110101 (-11)
        -- HEX: FFF5
        wait for 10ns;
        
        -- RR
        t_mode <= "1001";
        -- Two's complement (-6) = 1111111111111010
        t_operand1 <= "1111111111111010"; --FFFA
        -- result: 0111111111111101 (32765)
        -- HEX: 7FFD
        wait for 10ns;
        
        -- MUL
        t_mode <= "1010";
        -- Two's complement (-6) = 1111111111111010
        t_operand1 <= "1111111111111010"; --FFFA
        -- Two's complement (-123) = 1111111110000101
        t_operand2 <= "1111111110000101"; --FFF4
        -- result: 001011100010 (738)
        -- HEX: 02E2
        wait for 10ns;
                
        -- DIV
        t_mode <= "1011";
        -- Two's complement (-123) = 1111111110000101
        t_operand1 <= "1111111110000101"; --FF85 
        -- Two's complement (-6) = 1111111111111010
        t_operand2 <= "1111111111111010"; --FFFA 
        -- result: 0000000000010100 (20), remainder (-3)
        -- HEX: 14
        wait for 10ns;
        
        wait;    
    end process;

end Behavioral;