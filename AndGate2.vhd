----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/23/2022 09:40:02 AM
-- Design Name: 
-- Module Name: AndGate2 - AndGate2_Arch
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

entity AndGate2 is
Port ( 
    a: in std_ulogic;
    b: in std_ulogic ;
    result: out std_ulogic 
);
end AndGate2;

architecture AndGate2_Arch of AndGate2 is

begin

process (a, b) begin
    result <= a and b;
end process;

end AndGate2_Arch;
