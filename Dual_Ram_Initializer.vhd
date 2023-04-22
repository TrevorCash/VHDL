----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/14/2022 03:35:47 PM
-- Design Name: 
-- Module Name: Dual_Ram_Initializer - Dual_Ram_Initializer_arch
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
library DSP;
use std.textio.all;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_unsigned.all;
use DSP.dsp_package_main.all;


entity Dual_Ram_Initializer is
  port (
           --BRAM PORT 1 
           bram_addr: out std_logic_vector (31 downto 0) := (others => '0');
           bram_data_out: out std_logic_vector (31 downto 0) := (others => '0');
           bram_data_in: in std_logic_vector (31 downto 0) := (others => '0');
           bram_enable: out std_logic := '1';
           bram_we: out std_logic_vector(3 downto 0) := (others => '1');
           bram_rst_busy: in std_logic := '0';
           bram_rst: out std_logic := '0';
           
           
           --BRAM PORT 2 
           bram2_addr: out std_logic_vector (31 downto 0) := (others => '0');
           bram2_data_out: out std_logic_vector (31 downto 0) := (others => '0');
           bram2_data_in: in std_logic_vector (31 downto 0) := (others => '0');
           bram2_enable: out std_logic := '1';
           bram2_we: out std_logic_vector(3 downto 0) := (others => '1');
           bram2_rst_busy: in std_logic := '0';
           bram2_rst: out std_logic := '0';
           
    clk : in STD_LOGIC;
    init : in STD_LOGIC := '0';
    done : out STD_LOGIC := '0'
  );
end Dual_Ram_Initializer;

architecture Dual_Ram_Initializer_arch of Dual_Ram_Initializer is

constant BRAM_SIZE: integer := 256;
type RamType is array (0 to BRAM_SIZE-1) of std_logic_vector(31 downto 0);



signal address1: unsigned(31 downto 0) := (others => '0');


impure function InitRamFromFile(RamFileName : in string) return RamType is

    FILE RamFile : text is in RamFileName;
    
    variable RamFileLine : line;
    
    variable RAM         : RamType;
    
    begin
    
    for I in RamType'range loop
        
        readline(RamFile, RamFileLine);
        
        hread(RamFileLine, RAM(I));
        
    end loop;
    
    return RAM;
    
end function;



signal RAM : RamType := InitRamFromFile("SynthData.bin");
signal RAM2 : RamType := InitRamFromFile("RAM2Data.bin");



begin


bram_addr <= std_logic_vector(address1);
bram2_addr <= std_logic_vector(address1);
bram_data_out <= (RAM(to_integer(address1)));
bram2_data_out <= (RAM2(to_integer(address1)));


process (clk) begin

    if(rising_edge(clk)) then
        if(init = '1') then   
        
            bram_we <= "1111";
            bram2_we <= "1111";
            
            if(address1 < BRAM_SIZE-1) then
                address1 <= address1 + 1;
                done <= '0';
            else
                done <= '1';
            end if;
               
        else
            done <= '0';
            bram_we <= "0000";
            bram2_we <= "0000";
        end if;  
    end if;
end process;




end Dual_Ram_Initializer_arch;
