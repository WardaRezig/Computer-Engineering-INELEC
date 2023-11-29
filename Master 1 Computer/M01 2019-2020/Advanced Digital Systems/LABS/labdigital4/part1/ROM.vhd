library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM is
	port( addr : in std_logic_vector(1 downto 0);
		  clk, RD: in std_logic;
		  data_out: out std_logic_vector(7 downto 0));
end entity;

architecture behave of ROM is
type rom is ARRAY (0 to 3) of std_logic_vector(7 downto 0);
signal my_rom : rom:= (x"C0",
					   x"D1",
					   x"E2",
					   x"F3");
begin
	process(clk, addr, RD)
	begin
		if(RD = '1') then
			if(clk'event and clk = '0') then
				data_out <= my_rom(to_integer(unsigned(addr)));
			end if;
		else
			data_out <= (others => 'Z');
		end if;
	end process;
end architecture;