----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/11/2025 06:14:21 PM
-- Design Name: 
-- Module Name: controller - Behavioral
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

entity controller is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           gt_4 : in STD_LOGIC;
           start: in STD_LOGIC;
           preset : out STD_LOGIC := '0';
           x_sel : out STD_LOGIC := '0';
           x_ld : out STD_LOGIC := '0';
           out_ld : out STD_LOGIC := '0';
           cnt_ld : out STD_LOGIC := '0';
           done : out STD_LOGIC := '0');
end controller;

architecture Behavioral of controller is
    type state_type is (START_STATE,IDLE, CHECK, CALCULATE, RESULT,DONE_STATE );
    signal state, next_state : state_type;
begin

    process(clk,reset) begin
        if reset = '1' then
            state <= START_STATE;
         elsif rising_edge(clk) then
            state <= next_state;
         end if;
    end process;
    
    process(state,gt_4,start)
    begin
    case state is
        when START_STATE => 
            preset <= '1';
            x_sel  <= '0';
            x_ld   <= '0';
            out_ld <= '0';
            cnt_ld <= '0';
            done   <= '0';
            if start = '1' then next_state <= IDLE;
            else next_state <= START_STATE;
            end if;
          
         when IDLE =>
            preset <= '0';
            out_ld <= '0';
            cnt_ld <= '0';
            x_sel <= '0';
            x_ld <= '1';
            done   <= '0';
            next_state <= CHECK;
            
          when CHECK =>
            preset <= '0';
            x_sel  <= '0';
            x_ld   <= '0';
            out_ld <= '0';
            cnt_ld <= '0';
            done   <= '0';
            if gt_4 = '1' then
                next_state <= RESULT;
            else
                next_state <= CALCULATE;
            end if;
          when CALCULATE =>
            preset <= '0';
            cnt_ld <= '1';
            x_sel  <= '1';
            x_ld   <= '1';
            out_ld <= '0';
            done   <= '0';
            next_state <= CHECK;  
          when RESULT =>
            preset <= '0';
            cnt_ld <= '0';
            x_sel  <= '0';
            x_ld   <= '0';
            out_ld <= '1';
            done   <= '0';
            next_state <= DONE_STATE;
            
          when DONE_STATE =>
            preset <= '0';
            cnt_ld <= '0';
            x_sel  <= '0';
            x_ld   <= '0';
            out_ld <= '0';
            done   <= '1';
            next_state <= START_STATE;
          
          end case;
    end process;   
            
end Behavioral;
