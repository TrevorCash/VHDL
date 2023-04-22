----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/25/2022 05:21:20 PM
-- Design Name: 
-- Module Name: Blinker_tb - Blinker_tb_arch
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
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
library DSP;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Blinker_tb is
Port (
    light_tb: out bit;
    count_tb: out unsigned(31 downto 0)
 );
end Blinker_tb;

architecture Blinker_tb_arch of Blinker_tb is
signal clock_tb: bit := '0';


begin

    blink: entity DSP.Blinker
        port map(clk => clock_tb, light => light_tb, count => count_tb);
    
    clock_tb <= not clock_tb after 100ns;
    check: process 
    begin
        report "Testing Blinker..";
       
        wait;
        
    end process;
end Blinker_tb_arch;





