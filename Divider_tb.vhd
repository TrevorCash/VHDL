----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/26/2022 05:28:20 PM
-- Design Name: 
-- Module Name: Divider_tb - Divider_tb_arch
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

entity Divider_tb is
Port (
clk: in std_ulogic;
output: out std_ulogic
 );
end Divider_tb;

architecture Divider_tb_arch of Divider_tb is
signal clock_tb: std_ulogic := '0';

begin
    divider: entity DSP.Divider
    port map(sig => clock_tb, out_sig => output);

    clock_tb <= not clock_tb after 100ns;
    check: process 
    begin
        report "Testing Divider..";
       
        wait;
        
    end process;

end Divider_tb_arch;
