library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity divider is
    Port ( dividend : in STD_LOGIC_VECTOR (15 downto 0);
           divisor : in STD_LOGIC_VECTOR (15 downto 0);
           quotient : out STD_LOGIC_VECTOR (15 downto 0));
end divider;

architecture Behavioral of divider is

begin

process(dividend, divisor)

variable temp_quotient, positive_divisor : std_logic_vector (15 downto 0);
variable positive_dividend, shifted_partial_result :  std_logic_vector (63 downto 0);
variable signs : std_logic_vector (1 downto 0);
	
begin
    --initialise variables
    temp_quotient := (others => '0');
    positive_dividend := (others => '0');
             
    --normalise dividend   
    if dividend(15) = '0' then
        positive_dividend (15 downto 0) := dividend;
        signs(1) := '0';
    else 
        positive_dividend (15 downto 0) := std_logic_vector(unsigned(NOT dividend) + 1);
        signs(1) := '1';
    end if;
             
    --normalise divisor
    if divisor(15) = '0' then
        positive_divisor := divisor;
        signs(0) := '0';
    else 
        positive_divisor := std_logic_vector(unsigned(NOT divisor) + 1);
        signs(0) := '1';
    end if;
             
    --determine quotient
    for i in 15 downto 0 loop
        shifted_partial_result := (others => '0');
        shifted_partial_result (15 + i downto i) := positive_divisor;
                   
        if unsigned(shifted_partial_result) <= unsigned(positive_dividend)then
            positive_dividend := std_logic_vector(unsigned(positive_dividend) - unsigned(shifted_partial_result));
            temp_quotient(i) := '1';
        end if;
    end loop;
             
    --decide the sign of the quotient and send it
    case signs is
        when "00" => quotient <= temp_quotient;
        when "11" => quotient <= temp_quotient;
        when "10" => quotient <= std_logic_vector(unsigned(NOT temp_quotient) + 1);
        when "01" => quotient <= std_logic_vector(unsigned(NOT temp_quotient) + 1);
        when others => quotient <= (others => '0');
    end case; 
         
end process;

end Behavioral;
