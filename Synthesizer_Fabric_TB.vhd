----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/14/2022 09:37:20 AM
-- Design Name: 
-- Module Name: Synthesizer_Fabric_TB - Synthesizer_Fabric_TB_Arch
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



entity Synthesizer_Fabric_TB is
  port (
    bram2_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    bram2_data_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    bram2_data_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    bram2_enable : out STD_LOGIC;
    bram2_rst : out STD_LOGIC;
    bram2_rst_busy : in STD_LOGIC;
    bram2_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    bram_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    bram_data_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    bram_data_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    bram_enable : out STD_LOGIC := '1';
    bram_rst : out STD_LOGIC := '0';
    bram_rst_busy : in STD_LOGIC;
    bram_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    
    initFinished : out std_ulogic
  );
end Synthesizer_Fabric_TB;

architecture Synthesizer_Fabric_TB_Arch of Synthesizer_Fabric_TB is



--routings
    signal rbram2_addr :  STD_LOGIC_VECTOR ( 31 downto 0 );
    signal rbram2_data_in :  STD_LOGIC_VECTOR ( 31 downto 0 );
    signal rbram2_data_out :  STD_LOGIC_VECTOR ( 31 downto 0 );
    signal rbram2_enable :  STD_LOGIC;
    signal rbram2_rst :  STD_LOGIC;
    signal rbram2_rst_busy :  STD_LOGIC;
    signal rbram2_we :  STD_LOGIC_VECTOR ( 3 downto 0 );
    signal rbram_addr :  STD_LOGIC_VECTOR ( 31 downto 0 );
    signal rbram_data_in :  STD_LOGIC_VECTOR ( 31 downto 0 );
    signal rbram_data_out :  STD_LOGIC_VECTOR ( 31 downto 0 );
    signal rbram_rst :  STD_LOGIC;
    signal rbram_rst_busy :  STD_LOGIC;
    signal rbram_we :  STD_LOGIC_VECTOR ( 3 downto 0 );

    signal ibram2_addr :  STD_LOGIC_VECTOR ( 31 downto 0 );
    signal ibram2_data_in :  STD_LOGIC_VECTOR ( 31 downto 0 );
    signal ibram2_data_out :  STD_LOGIC_VECTOR ( 31 downto 0 );
    signal ibram2_enable :  STD_LOGIC;
    signal ibram2_rst :  STD_LOGIC;
    signal ibram2_rst_busy :  STD_LOGIC;
    signal ibram2_we :  STD_LOGIC_VECTOR ( 3 downto 0 );
    signal ibram_addr :  STD_LOGIC_VECTOR ( 31 downto 0 );
    signal ibram_data_in :  STD_LOGIC_VECTOR ( 31 downto 0 );
    signal ibram_data_out :  STD_LOGIC_VECTOR ( 31 downto 0 );
    signal ibram_rst :  STD_LOGIC;
    signal ibram_rst_busy :  STD_LOGIC;
    signal ibram_we :  STD_LOGIC_VECTOR ( 3 downto 0 );


begin


    bram_data_out<= ibram_data_out when rst = '1' else rbram_data_out;
    bram_we <= ibram_we when rst = '1' else rbram_we;
    bram_addr <= ibram_addr when rst = '1' else rbram_addr;

    bram2_data_out <= ibram2_data_out when rst = '1' else rbram2_data_out;
    bram2_we <= ibram2_we when rst = '1' else rbram2_we;
    bram2_addr <= ibram2_addr when rst = '1' else rbram2_addr;
    

   
    ibram2_data_in <= bram2_data_in when rst = '1' else (others => '0');
    ibram_data_in <= bram_data_in when rst = '1' else (others => '0');
    
    
    rbram2_data_in <= bram2_data_in when rst = '0' else (others => '0');
    rbram_data_in <= bram_data_in when rst = '0' else (others => '0');
            
            
--    process(rst,clk) begin
--        if(rst = '1') then
--            bram2_addr <= ibram2_addr;
--            ibram2_data_in <= bram2_data_in;
--            bram2_data_out <= ibram2_data_out;
--            bram2_we <= ibram2_we;
--            bram_addr <= ibram2_addr;
--            ibram_data_in <= bram_data_in;
--            bram_data_out<= ibram_data_out;
--            bram_we <= ibram_we;
            
            
--        else
--            bram2_addr <= rbram2_addr;
--            rbram2_data_in <= bram2_data_in;
--            bram2_data_out <= rbram2_data_out;
--            bram2_we <= rbram2_we;
--            bram_addr <= rbram_addr;
--            rbram_data_in <= bram_data_in;
--            bram_data_out<= rbram_data_out;
--            bram_we <= rbram_we;
        
--        end if;
        
--    end process;

    synth_fabric: entity DSP.Synthesizer_Fabric
        port map(
        clk => clk,
        rst => rst,
        

        
        bram_addr => rbram_addr,
        bram_data_out => rbram_data_out,
        bram_data_in => rbram_data_in,
        bram_we => rbram_we,

        bram_rst_busy => rbram_rst_busy,
        
        bram2_addr => rbram2_addr,
        bram2_data_out => rbram2_data_out,
        bram2_data_in => rbram2_data_in,
        bram2_we => rbram2_we,
        bram2_rst_busy => rbram2_rst_busy

        );


    ram_initializer: entity DSP.Dual_Ram_Initializer
        port map(
            clk => clk,
            
            init => rst,
            done => initFinished,
            
            bram_addr => ibram_addr,
            bram_data_out => ibram_data_out,
            bram_data_in => ibram_data_in,
            bram_we => ibram_we,
            bram_rst_busy => ibram_rst_busy,
            
            bram2_addr => ibram2_addr,
            bram2_data_out => ibram2_data_out,
            bram2_data_in => ibram2_data_in,
            bram2_we => ibram2_we,
            bram2_rst_busy => ibram2_rst_busy
    
        );



end Synthesizer_Fabric_TB_Arch;
