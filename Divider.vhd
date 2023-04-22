
library IEEE;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;



entity Divider is
Port (
sig: in std_ulogic;
out_sig: out std_ulogic
);
end Divider;

architecture Divider_Arch of Divider is

signal sig_r: std_ulogic := '0';

begin

    out_sig <= sig_r;

    process(sig) 

    begin
        if(rising_edge(sig)) then
             sig_r <= not sig_r;
        end if;
    end process;

end Divider_Arch;
