----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/27/2022 07:22:05 PM
-- Design Name: 
-- Module Name: Synthesizer_Fabric - Synthesizer_Fabric_arch
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


entity Synthesizer_Fabric is

    Port ( 
           clk : in STD_LOGIC := '0';
           
           
           rst: in std_ulogic;
           
           dac_pdm : out STD_LOGIC;
           
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
           
           debugTrig: out std_ulogic := '0'
           );
           
end Synthesizer_Fabric;





architecture Synthesizer_Fabric_arch of Synthesizer_Fabric is

constant BRAM_GRAPH_ADDR_START: unsigned(31 downto 0) := x"00000000";


constant BRAM_SIZE: integer := 256;

constant PDM_BITWIDTH: integer := 12;
constant HALF_VALUE: integer := ((2**(PDM_BITWIDTH))-1)/2;
constant MAX_HARDWARE_MODULES: integer := 256;
constant NUM_ADDERS: integer := 4;

constant MODULE_ONES: std_ulogic_vector(MAX_HARDWARE_MODULES-1 downto 0) := (NUM_ADDERS-1 downto 0 => '1', others => '0');
constant WIDE_ONE: std_ulogic_vector(MAX_HARDWARE_MODULES-1 downto 0) := (0 => '1', others => '0');

type CONTROL_STATE is (
RAM_SIM_FILLUP0,

MV0, MV1, MV2, MV3, MV4, MV5, MV6, MV7,    
 SOURCERAM1, SOURCERAM2, SOURCERAM3, SOURCERAM4,   
 DESTRAM1, DESTRAM2, DESTRAM3, DESTRAM4,   
 SMP1, SMP2, SMP3, SMP4, SMP5);




type RamType is array (0 to BRAM_SIZE-1) of std_logic_vector(31 downto 0);




signal state: integer := 0;    
--signal value: unsigned(PDM_BITWIDTH-1 downto 0) := (others => '0');

signal bus1: audio_signal_t := (others => '0');

signal sample: std_ulogic := '0';
signal inSel: audio_in_out_reg_sel_t := (others => '0');
signal outSel: audio_in_out_reg_sel_t := (others => '0');


signal dones: std_ulogic_vector(MAX_HARDWARE_MODULES-1 downto 0) := (others => '0');

signal inEnables: std_ulogic_vector(MAX_HARDWARE_MODULES-1 downto 0) := (others => '0');
signal outEnables: std_ulogic_vector(MAX_HARDWARE_MODULES-1 downto 0):= (others => '0');

signal currentInModuleIdx: unsigned(15 downto 0);

--signal curState: CONTROL_STATE := RAM_SIM_FILLUP0;
signal curState: CONTROL_STATE := MV0;

signal sourceId: unsigned(15 downto 0);
signal destId: unsigned(15 downto 0);

signal destRamFlag: std_ulogic;
signal sourceRamFlag: std_ulogic;

procedure DestinationRoute (
    enable: in std_ulogic;
    destId: in unsigned(15 downto 0);
    signal inEnables: out std_ulogic_vector(MAX_HARDWARE_MODULES-1 downto 0);
    signal destRamFlag: out std_ulogic
) is 
begin
    if(enable = '1') then
        if (destId < MAX_HARDWARE_MODULES) then
            inEnables <= (others => '0');
            inEnables(to_integer(destId)) <= '1';
            destRamFlag <= '0';
        else
            inEnables <= (others => '0');
            destRamFlag <= '1';
        end if;
    else
        inEnables <= (others => '0');
        destRamFlag <= '0';
    end if;
    
end;

procedure SourceRoute (
enable: in std_ulogic;
sourceId: in unsigned(15 downto 0);
signal outEnables: out std_ulogic_vector(MAX_HARDWARE_MODULES-1 downto 0);
signal sourceRamFlag: out std_ulogic
) is begin
    if (enable = '1') then
        if (sourceId < MAX_HARDWARE_MODULES) then
            outEnables <= (others => '0');
            outEnables(to_integer(sourceId)) <= '1';
            sourceRamFlag <= '0';
        else 
        
            outEnables <= (others => '0');
            sourceRamFlag <= '1';
        end if;
    
    else
        outEnables <= (others => '0');
        sourceRamFlag <= '0';
    end if;
    
end;

signal address1: unsigned(31 downto 0) := (others => '0');
signal address2: unsigned(31 downto 0) := (others => '1');

procedure Ram2Route (
    signal sourceRamFlag: in std_ulogic;
    signal destRamFlag: in std_logic;
    signal ramAddr: out unsigned(31 downto 0)
) is begin

    if sourceRamFlag = '1' and destRamFlag = '0' then
        ramAddr <= to_unsigned(to_integer(sourceId - MAX_HARDWARE_MODULES), 32);
    elsif sourceRamFlag = '0' and destRamFlag = '1' then
        ramAddr <= to_unsigned(to_integer(destId - MAX_HARDWARE_MODULES), 32);
    else
        ramAddr <= (others => '1');
    end if;
    
end;


procedure nullRoutingRoute (
signal sourceId: in unsigned(15 downto 0);
signal destId: in unsigned(15 downto 0);
signal nullRoute: out std_ulogic    
) is 
variable someBool: boolean;

begin

someBool := (sourceId = x"0000" and destId = x"0000" );
if(someBool) then
    nullRoute <= '1';
else
    nullRoute <= '0';
end if;


end;


signal nullRoutingFlag: std_ulogic;


begin
    
    sourceId <= unsigned(bram_data_in(31 downto 16));
    destId <= unsigned(bram_data_in(15 downto 0));
    
    
    bram_addr <= std_logic_vector(address1);
    bram2_addr <= std_logic_vector(address2);

    

    bram_rst <= rst;
    bram2_rst <= rst;
    
    nullRouting: nullRoutingRoute(sourceId, destId, nullRoutingFlag);
    destinationRouting: DestinationRoute(((not sample) and (not nullRoutingFlag)) , destId, inEnables, destRamFlag);
    sourceRouting: SourceRoute(((not sample) and (not nullRoutingFlag)), sourceId, outEnables, sourceRamFlag);
    


    dram2routing: Ram2Route(sourceRamFlag, destRamFlag, address2);


    adders: for i in 0 to (NUM_ADDERS-1) generate
        adder: entity DSP.Audio_Processor_Gain
        port map(
        interface_in.clk => clk,  
        interface_in.sigIn => bus1, 
        interface_in.inEnable => inEnables(i), 
        interface_in.outEnable => outEnables(i), 
        interface_in.inSel => inSel,
        interface_in.outSel => outSel,
        interface_in.sample => sample,
        interface_in.rst => rst,
        
        
        interface_out.sigOut => bus1,
        
        done => dones(i)
        );
        
    end generate;
    
    
    
    
    
    
    
    bram_data_out <= (others => '0');
    

    process(clk, rst) 
    begin
        if(rst = '1') then
            address1 <= (others => '0');
            curState <= MV0;
            bram_we <= "0000";

        else
    
            if(rising_edge(clk)) then
                
                
                case curState is
                

                 
                
                when MV0 =>
                    address1 <= to_unsigned(0, 32);
                    bram_we <= "0000";
                    curState <= MV2;
                
                    
                when MV2 =>
                    --routing is set - let it clock data
                    
                    
                    
                    --if source is from bram2, do substate loop
                    if(sourceRamFlag = '1' ) then
                        curState <= SOURCERAM1;

                        bram2_we <= "0000";
                        
                    --if dest is to bram2, do substate loop
                    elsif (destRamFlag = '1') then
                        curState <= DESTRAM1;
                        bram2_we <= "1111";
                        bram2_data_out <= std_logic_vector(bus1);
                        
                    --if end of list - jump to sampling state loop
                    elsif (nullRoutingFlag = '1') then
                         
                         curState <= SMP1;
                    else
                    
                        --else continue
                        address1 <= address1 + 1;
                       
                    end if;
                

    
    
    
    
                when SOURCERAM1 =>
                    -- data should be on bus1, let it clock
                    bus1 <= audio_signal_t(bram2_data_in);
                    curState <= SOURCERAM2;
  
                    
                when SOURCERAM2 =>
                    -- clocked, go back to MV2
                    bus1 <= (others => 'Z');
    
                    address1 <= address1 + 1;
                    curState <= MV2;
                    
                    
    
                when DESTRAM1 =>
                    --let it clock
                    bram2_we <= "0000";
                    bram2_data_out <= (others => '0');
                    curState <= DESTRAM2;
                     
                when DESTRAM2 =>
                    --go back to MV2
                    address1 <= address1 + 1;
                    curState <= MV2;
    
    
    
                when SMP1 =>
                    sample <= '1';
                    curState <= SMP2;
                    debugTrig <= '1';
                
                when SMP2 =>
                    --advance when all modules finished
                    if(dones = MODULE_ONES) then
                        sample <= '0';
                        --sampling finished - start the next transfer cycle
                        curState <= MV2;
                        address1 <= to_unsigned(0, 32);
                    end if;
                    debugTrig <= '0';
--               
                    
    
                when others =>
                    
                    
                    
                end case;

            end if;   
          end if;
    end process;


end Synthesizer_Fabric_arch;
