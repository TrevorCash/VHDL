----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/01/2022 11:32:19 AM
-- Design Name: 
-- Module Name: Dsp_Package_Main - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


package dsp_package_main is 
    constant AUDIO_DATA_WIDTH: integer := 32;
    constant REG_ARRAY_BITS: integer := 4;
    
    
    
    subtype audio_signal_t is signed(AUDIO_DATA_WIDTH-1 downto 0);
    
    constant AUDIO_SIG_ZERO: audio_signal_t := to_signed(0, AUDIO_DATA_WIDTH);
     
    
    subtype audio_in_out_reg_sel_t is unsigned(REG_ARRAY_BITS-1 downto 0);

    type sigInRegisterArray_t is array (natural range <> ) of audio_signal_t;
    type sigOutRegisterArray_t is array (natural range <> ) of audio_signal_t;
 
 

    type audio_interface_port_in is record
        
        sigIn : audio_signal_t;
        
        inEnable : std_ulogic;
        inSel : audio_in_out_reg_sel_t;
        
        outEnable : std_ulogic;
        outSel : audio_in_out_reg_sel_t;
                
        sample : std_ulogic;
        
        rst : std_ulogic;
        clk : std_ulogic;
        
    end record;
    
    
    type audio_interface_port_out is record
        sigOut : audio_signal_t;
    end record;
    
    constant audio_interface_port_default_out: audio_interface_port_out := 
    (
        sigOut => (others => '0')
    );
    constant audio_interface_port_default_in: audio_interface_port_in := 
    (
        sigIn => (others => '0'),
        inEnable => '0',
        inSel => (others => '0'),
        outEnable => '1',
        outSel => (others => '0'),
        sample => '0',
        rst => '0',
        clk => '0'
    );
    
    
    
    
    
    
    


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

end package;
