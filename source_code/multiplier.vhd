library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity multiplier is
    Port ( multiplicand : in STD_LOGIC_VECTOR (15 downto 0);
           multiplier : in STD_LOGIC_VECTOR (15 downto 0);
           product : out STD_LOGIC_VECTOR (31 downto 0));
end multiplier;

architecture Behavioral of multiplier is

begin

process(multiplicand, multiplier)
    
variable temp_product, shifted_partial_result : std_logic_vector (31 downto 0);
variable positive_multiplier, positive_multiplicand, partial_result, multiplier_bit_vector :  std_logic_vector (15 downto 0);
variable signs : std_logic_vector (1 downto 0);
	
begin

    --initialise temp_product
    temp_product := (others => '0');
         
    --normalise multiplicand   
    if multiplicand(15) = '0' then
        positive_multiplicand := multiplicand;
        signs(1) := '0';
    else 
        positive_multiplicand := std_logic_vector(unsigned(NOT multiplicand) + 1);
        signs(1) := '1';
    end if;
         
    --normalise multiplier
    if multiplier(15) = '0' then
        positive_multiplier := multiplier;
        signs(0) := '0';
    else 
        positive_multiplier := std_logic_vector(unsigned(NOT multiplier) + 1);
        signs(0) := '1';
    end if;
                  
    for i in 0 to 15 loop
        multiplier_bit_vector := (others => positive_multiplier (i));
        partial_result := multiplier_bit_vector AND positive_multiplicand;
                   
        shifted_partial_result := (others => '0');
        shifted_partial_result (15 + i downto i) := partial_result;
                   
        temp_product := std_logic_vector(unsigned(temp_product) + unsigned(shifted_partial_result));
    end loop;
             
    --decide the sign of the result and send it
    case signs is
        when "00" => product <= temp_product;
        when "11" => product <= temp_product;
        when "10" => product <= std_logic_vector(unsigned(NOT temp_product) + 1);
        when "01" => product <= std_logic_vector(unsigned(NOT temp_product) + 1);
        when others => product <= (others => '0');
    end case; 
         
end process;
     
end Behavioral;
