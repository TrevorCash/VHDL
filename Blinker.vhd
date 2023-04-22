----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/25/2022 02:56:42 PM
-- Design Name: 
-- Module Name: Blinker - Blinker_Arch
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Blinker is
Port (
clk: in bit;
light: out bit;
count: out unsigned(31 downto 0)
 );
end Blinker;

architecture Blinker_Arch of Blinker is

begin
    process(clk) 
        variable count_r: unsigned(31 downto 0) := TO_UNSIGNED(0,32);
        variable light_r: bit := '0';
    begin
        count <= count_r;
        light <= light_r;
        if(clk = '1') then
            count_r := count_r + 1;
            
            if(count_r = (1000)) then
                light_r := not light_r;
                count_r := TO_UNSIGNED(0,32);
            end if;
        end if;
        
    end process;


end Blinker_Arch;
