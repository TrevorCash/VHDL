----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/28/2022 09:48:29 AM
-- Design Name: 
-- Module Name: Pulse_Density_Modulator_tb - Pulse_Density_Modulator_tb_arch
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


entity Pulse_Density_Modulator_tb is
Generic (
WIDTH: integer := 8
);
Port ( 
output: out std_ulogic
);
end Pulse_Density_Modulator_tb;

architecture Pulse_Density_Modulator_tb_arch of Pulse_Density_Modulator_tb is
signal clock_tb: std_ulogic := '0';
signal density_perc: unsigned(WIDTH-1 downto 0) := TO_UNSIGNED(254,WIDTH);
begin

    pdm: entity DSP.Pulse_Density_Modulator
    generic map(WIDTH => WIDTH)
    port map(modulation_clk => clock_tb, density_perc => density_perc, pdm_out => output);

    clock_tb <= not clock_tb after 100ns;
    check: process 
    begin
        report "Testing Divider..";
        
        wait;
        
    end process;
end Pulse_Density_Modulator_tb_arch;
