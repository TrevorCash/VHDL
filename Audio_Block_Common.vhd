----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2022 09:53:30 AM
-- Design Name: 
-- Module Name: Audio_Block_Common - Audio_Block_Common_arch
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

library DSP;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use DSP.dsp_package_main.ALL;


entity Audio_Block_Common is

 
Generic (
IN_SIG_COUNT: integer := 4;
OUT_SIG_COUNT: integer := 1
);

Port (

interface_in: in audio_interface_port_in := audio_interface_port_default_in;
interface_out: inout audio_interface_port_out := audio_interface_port_default_out;

signal inRegArray: out sigInRegisterArray_t(0 to IN_SIG_COUNT-1);
signal outRegArray: in sigOutRegisterArray_t(0 to OUT_SIG_COUNT-1)

);
end Audio_Block_Common;

architecture Audio_Block_Common_arch of Audio_Block_Common is

signal inSigs_r:  sigInRegisterArray_t(0 to IN_SIG_COUNT-1);

begin
    
    inRegArray <= inSigs_r;
    
    --select final output signal to bus
    interface_out.sigOut <= outRegArray(to_integer(unsigned(interface_in.outSel))) when interface_in.outEnable = '1' else (others => 'Z');
    

    process(interface_in.clk, interface_in.rst) begin
        if(interface_in.rst = '1') then
            inSigs_r <= (others => (others => '0'));
        end if;
        if(rising_edge(interface_in.clk)) then
        
            -- capture inputs by input sel
            if(interface_in.inEnable = '1') then
            
                inSigs_r(to_integer(unsigned(interface_in.inSel))) <= interface_in.sigIn;
                
            end if;
            
        end if;
    
    
    end process;

end Audio_Block_Common_arch;
