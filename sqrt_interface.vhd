----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/11/2025 08:53:34 PM
-- Design Name: 
-- Module Name: sqrt_interface - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sqrt_interface is
    Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           start : in STD_LOGIC;
           O : out STD_LOGIC_VECTOR (31 downto 0);
           done : out STD_LOGIC);
end sqrt_interface;

architecture Behavioral of sqrt_interface is
    component datapath
    port    ( A : in STD_LOGIC_VECTOR (31 downto 0);
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           x_sel : in STD_LOGIC;
           x_ld : in STD_LOGIC;
           out_ld : in STD_LOGIC;
           cnt_ld : in STD_LOGIC;
           o : out STD_LOGIC_VECTOR (31 downto 0);
           gt_4 : out STD_LOGIC);
     end component;
     
     component controller
     port   ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           gt_4 : in STD_LOGIC;
           start: in STD_LOGIC;
           preset : out STD_LOGIC;
           x_sel : out STD_LOGIC;
           x_ld : out STD_LOGIC;
           out_ld : out STD_LOGIC;
           cnt_ld : out STD_LOGIC;
           done : out STD_LOGIC);
     end component;
     
     signal preset_temp,x_sel_temp,x_ld_temp,out_ld_temp,cnt_ld_temp : std_logic;
     signal gt_4_temp : std_logic;
begin
    datapath_connect : datapath port map(A,clk,preset_temp,x_sel_temp,x_ld_temp,out_ld_temp,cnt_ld_temp,o,gt_4_temp);
    controller_connect : controller port map (clk,reset,gt_4_temp,start,preset_temp,x_sel_temp,x_ld_temp,out_ld_temp,cnt_ld_temp,done);

end Behavioral;
