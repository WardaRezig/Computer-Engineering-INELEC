Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

Entity RAM_b is
Port( clk, cs, rw: 	 IN std_logic;
	  Addr:  IN integer range 15 downto 0; 
	  Din:   IN std_logic_vector(7 downto 0);-- data written in a certain address
	  Dout:  OUT std_logic_vector(7 downto 0));-- data read from a certain address
	 
End RAM_b;

Architecture Arch of RAM_b is    --1D-1D Array
TYPE Ram_a is ARRAY (15 downto 0)of std_logic_vector(7 downto 0);
Signal Ram: Ram_a;
Begin 
	Process(CS, RW, clk)              --Synchronous ram
	Begin
		if (clk'event and clk='1') then -- rw operations are synchronous
		if CS='0' then Dout<= "ZZZZZZZZ"; --if the control signal is not activated,the output data a hiZ 
		elsif CS='1' then -- if the control signal is activated 
		                  if RW='0' then Dout <=Ram(Addr);    -- performs a read operation 

						  end if;
						  if RW='1' then Ram(Addr)<=Din; Dout<= "ZZZZZZZZ";  -- performs a write operation 

						  end if;
		end if;
		end if;
	end process;
end arch;
	