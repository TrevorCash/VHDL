----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/28/2022 09:28:40 AM
-- Design Name: 
-- Module Name: Pulse_Density_Modulator - Pulse_Density_Modulator_arch
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

entity Pulse_Density_Modulator is
Generic (
WIDTH: integer := 8
);
Port ( 
modulation_clk: in std_ulogic;
density_perc: in unsigned(WIDTH-1 downto 0);
pdm_out: out std_ulogic := '0'
);
end Pulse_Density_Modulator;

architecture Pulse_Density_Modulator_arch of Pulse_Density_Modulator is

begin

    process(modulation_clk) 
    variable count_r: unsigned(WIDTH-1 downto 0) := to_unsigned(0,WIDTH);
    constant max_count: unsigned(WIDTH-1 downto 0) := (others => '1');
    begin
        if(rising_edge(modulation_clk)) then
        
--            if (count_r < max_count - density_perc) then
--                count_r := count_r + 1;
--                pdm_out <= '0';
--            else
--                count_r :=  to_unsigned(0,WIDTH);
--                pdm_out <= '1';
--            end if;
            count_r := count_r + 1;
            if (count_r < (max_count - density_perc)) then
                
                pdm_out <= '0';
            else
                pdm_out <= '1';
            end if;
        end if;
        
    
    end process;


end Pulse_Density_Modulator_arch;
