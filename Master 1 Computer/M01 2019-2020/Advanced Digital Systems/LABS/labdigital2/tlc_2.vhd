library ieee;

use ieee.std_logic_1164.all;

use ieee.std_logic_unsigned.all;

entity  tlc_2 is
port( CLOCK, RESET : in  std_logic;

      Q            : buffer std_logic_vector (2 downto 0);

      NS, EW : out std_logic_vector(2 downto 0));
      end tlc_2;

Architecture arch of tlc_2 is

signal state: std_logic_vector (25 downto 0);

signal CLOCK_slow: std_logic;

signal TIMER : std_logic;

signal counter: std_logic_vector(2 downto 0);

signal NSEW: std_logic_vector (5 downto 0); 

Type state_type is( s0, s1, s2, s3);

signal PS: state_type;

 
 begin 

 clk_div: PROCESS(RESET, CLOCK)

          begin

          if RESET='1' then state<= (others => '0');
          elsif(CLOCK'event and CLOCK ='1') then 
          if state = 49999999 then state<= ( others => '0');
          else state<= state+1 ;
          end if ;
          end if;
 
          end process clk_div;

CLOCK_slow <= state(3);

          
div_5:    PROCESS (CLOCK_slow, RESET)     
          begin
          if RESET='1' then Q<="000";
          elsif (CLOCK_slow'event and CLOCK_slow ='1') then  
          if (Q = "100") then Q<= "000";
          else Q <= Q+1;
          end if;
          end if;
          end process div_5;
          
TIMER <= Q(2);                           

Op_ctrl:  PROCESS (CLOCK_slow, RESET)
          begin
				 if RESET='1' then PS<= S0;
                 elsif (CLOCK_slow'event and CLOCK_slow ='1') then 
                 
                    case PS is
                 when S0 => if (timer = '0') then PS <= S0;
                 else PS <= S1; end if;
                 when S1 =>  if (timer = '1') then PS <= S1;
                             else PS <= S2; end if;
                 when S2 =>  if (timer = '0') then PS <= S2;
                             else PS <= S3; end if;
                 when S3 =>  if (timer = '1') then PS <= S3;
                             else PS <= S0; end if;
                    end case;
                 end if;
           end process op_ctrl;

o_p: PROCESS (PS)
  begin
     case PS is
        when S0 => NSEW <= "011110";
        when S1 =>  NSEW <= "011101";
        when S2 => NSEW <= "110011";
        when S3 =>  NSEW <= "101011";
     end case;
end process o_p;       

EW<= NSEW(2 downto 0);   
NS <= NSEW(5 downto 3);          
end arch;