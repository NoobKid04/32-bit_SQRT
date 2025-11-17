----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/11/2025 04:48:46 PM
-- Design Name: 
-- Module Name: divider - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity divider is
    Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           O : out STD_LOGIC_VECTOR (31 downto 0));
end divider;

architecture Behavioral of divider is
    signal out_temp : std_logic_vector ( 63 downto 0) := (others => '0');
    
begin
    process(A,B)
     variable A_temp  : unsigned(63 downto 0);
     variable B_temp  : unsigned(63 downto 0);
     variable O_temp : unsigned(63 downto 0);
     begin
     A_temp := resize(unsigned(A), 64);
     B_temp := resize(unsigned(B), 64);
     A_temp := shift_left(A_temp, 26);
     if unsigned(B) = 0 then
                O_temp := (others => '1'); 
            else
                O_temp := A_temp/B_temp;
    end if;
    out_temp <= std_logic_vector(O_temp);
    end process;
    O <= out_temp(31 downto 0);
end Behavioral;
