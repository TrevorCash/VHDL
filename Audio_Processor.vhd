----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/01/2022 08:45:40 AM
-- Design Name: 
-- Module Name: Audio_Processor - Audio_Processor_arch
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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use DSP.dsp_package_main.ALL;


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Audio_Processor_Gain is
Port (
    interface_in: in audio_interface_port_in;
    interface_out: inout audio_interface_port_out := audio_interface_port_default_out;
    done: out std_ulogic := '0'
);
end Audio_Processor_Gain;

architecture Audio_Processor_Gain_arch of Audio_Processor_Gain is

signal inSignals: sigInRegisterArray_t(0 to 0);
signal outSignals: sigOutRegisterArray_t(0 to 0) := (others => AUDIO_SIG_ZERO);
begin

    commonInterface: entity DSP.Audio_Block_Common
     generic map (IN_SIG_COUNT => 1, OUT_SIG_COUNT => 1)
     port map(interface_in => interface_in,
      interface_out => interface_out,
      inRegArray => inSignals,
      outRegArray => outSignals
      );

    

    process(interface_in.clk, interface_in.rst) begin
        
        if(interface_in.rst = '1') then
            outSignals <= (others => AUDIO_SIG_ZERO);
        end if;
        
        
        if(rising_edge(interface_in.clk)) then
        
            if(interface_in.sample = '1') then
            
                outSignals(0) <= inSignals(0) + 1;
               -- outSignals(1) <= inSignals(1) + 2;
               -- outSignals(2) <= inSignals(2) + 3;
               -- outSignals(3) <= inSignals(3) + 4;
                
                done <= '1';
            end if;
            
            --keep done on for 1 clock cycle
            if(done = '1') then
                done <= '0';
            end if;
            
        end if;
        
    end process;

end Audio_Processor_Gain_arch;
