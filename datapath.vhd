----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/11/2025 06:57:50 PM
-- Design Name: 
-- Module Name: datapath - Behavioral
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

entity datapath is
    Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           x_sel : in STD_LOGIC;
           x_ld : in STD_LOGIC;
           out_ld : in STD_LOGIC;
           cnt_ld : in STD_LOGIC;
           o : out STD_LOGIC_VECTOR (31 downto 0);
           gt_4 : out STD_LOGIC);
end datapath;

architecture Behavioral of datapath is
    component mux_2_1 
    port (A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           SEL : in STD_LOGIC;
           O : out STD_LOGIC_VECTOR (31 downto 0));
     end component;
     
     component reg 
     port ( D : in STD_LOGIC_VECTOR (31 downto 0);
           load : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (31 downto 0));
      end component;
      
      component divider
      port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           O : out STD_LOGIC_VECTOR (31 downto 0));
       end component;
       
       component CLA_32bit 
       port ( A, B  : in  STD_LOGIC_VECTOR(31 downto 0);
            Cin   : in  STD_LOGIC;
            Sum   : out STD_LOGIC_VECTOR(31 downto 0);
            Cout  : out STD_LOGIC
);
        end component;
        
        component cnt_comp
        port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           load : in STD_LOGIC;
           o : out STD_LOGIC);
         end component;
         
         signal add_temp: std_logic_vector(31 downto 0);
         signal Cout_temp: std_logic;
         signal x_temp: std_logic_vector(31 downto 0);
         signal mux_temp: std_logic_vector(31 downto 0);
         signal div_temp: std_logic_vector(31 downto 0);
         signal before_shift : std_logic_vector (32 downto 0);
         signal shift_temp: std_logic_vector(31 downto 0);
         
begin



    
X_MUX : mux_2_1 port map (A,shift_temp,x_sel,mux_temp);
X_REG : reg port map (mux_temp,x_ld,reset,clk,x_temp);
div : divider port map(A, x_temp, div_temp);
add : CLA_32bit port map (div_temp,x_temp,'0',add_temp,cout_temp);
before_shift <= (cout_temp & add_temp);
shift_temp <= before_shift(32 downto 1);
OUT_REG : reg port map (shift_temp, out_ld,reset , clk, o);
compare : cnt_comp port map (clk,reset, cnt_ld,gt_4);

end Behavioral;
