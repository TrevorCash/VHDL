----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/23/2022 08:56:33 AM
-- Design Name: 
-- Module Name: AndGate - AndGate_arch
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



entity AndGate is
Port ( 
    a: in std_ulogic := to_stdulogic('0');
    b: in std_ulogic := to_stdulogic('0');
    result: out std_ulogic :=  to_stdulogic('0')  
 );
end AndGate;

architecture AndGate_arch of AndGate is
begin

process (a, b) begin
    result <= a and b;
end process;


end AndGate_arch;
