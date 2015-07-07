library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity borrar is
    Port ( b0 : in  STD_LOGIC;
                          clk: in  std_logic;
           b1 : in  STD_LOGIC;
           b2 : in  STD_LOGIC;
           srx : in  STD_LOGIC;
                          s0 : out  STD_LOGIC;
           s1 : out  STD_LOGIC;
           s2 : out  STD_LOGIC;
           m1 : out  STD_LOGIC;
           m0 : out  STD_LOGIC);
                                           
end borrar;

architecture Behavioral of borrar is
type STATE_TYPE is (f0, f1, f2, mup1,mup2,mdown1, mdown0);
signal nes:state_type;
begin
process(b0,b1,b2,srx,clk)
begin
if(clk' event and clk='1') then

case nes is

--Ground floor
when f0=>
s0<='1';
s1<='0';
s2<='0';
                
                if srx='1' then
                --m1<='0';
                --m0<='0';
                        if b1='1' then
                        s0<='0';
                --        s1<='1';        
                --        s2<='0';
                        --m1<='1';
                        --m0<='0';
                        nes<=mup1;
                        elsif b2='1' then
                        s0<='0';        
                        s1<='0';        
                        s2<='1';        
                        --m1<='1' after 5ns;        
                        --m0<='0';        
                        nes<=mup2;
                        else nes<=f0;
                        end if;
                end if;
-- first floor up
when f1=>
        if srx='1' then
--        m1<='0';
--        m0<='0';
                if b0='1' then
                s0<='1';        
                s1<='0';        
                s2<='0';        
                m1<='0' after 5ns;        
                m0<='1';        
                nes<=mdown0;        
           elsif b2='1' then
                s0<='0';        
                s1<='0';        
                s2<='1';        
                --m1<='1' after 5ns;
                --m0<='0';                
                nes<=mup2;
                else         nes<=f1;
                end if;
        end if;

-- sencond floor

when f2=>
        if srx ='1' then
--        m1<='0';
--        m0<='0';
                if b0='1' then
                s0<='1';        
                s1<='0';        
                s2<='0';        
                --m1<='0' after 5ns;
                --m0<='1';        
                nes<=mdown0;
                elsif b1='1' then        
                s0<='0';        
                s1<='1';        
                s2<='0';        
                --m1<='0' after 5ns;        
                --m0<='1';        
                nes<=mdown1;
                else
                nes<=f2;
                end if;
        end if;
        
when mup1=>
m1<='1';
m0<='0';
s0<='0';
s1<='1';
s2<='0';
        if srx='0' then
        m1<='0';
        m0<='0';
        nes<=f1;
        else
        nes<=mup1;
        end if;
when mup2=>
m1<='1';
m0<='0';
nes<=f2;

when mdown1=>
m1<='0';
m0<='1';
nes<=f1;

when mdown0=>
m1<='0';
m0<='1';
nes<=f0;
end case;

end if;

end process;

end Behavioral; 