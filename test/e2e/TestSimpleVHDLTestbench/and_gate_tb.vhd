library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AND_gate_tb is
end AND_gate_tb;

architecture Behavioral of AND_gate_tb is
    signal A_tb, B_tb, Y_tb : STD_LOGIC;
    
begin
    uut: entity work.AND_gate
        port map (A => A_tb, B => B_tb, Y => Y_tb);
    
    process
    begin
        -- Test 1: 0 AND 0 = 0
        A_tb <= '0'; B_tb <= '0'; wait for 10 ns;
        assert Y_tb = '0' report "Test 1 failed" severity ERROR;
        
        -- Test 2: 0 AND 1 = 0
        A_tb <= '0'; B_tb <= '1'; wait for 10 ns;
        assert Y_tb = '0' report "Test 2 failed" severity ERROR;
        
        -- Test 3: 1 AND 0 = 0
        A_tb <= '1'; B_tb <= '0'; wait for 10 ns;
        assert Y_tb = '0' report "Test 3 failed" severity ERROR;
        
        -- Test 4: 1 AND 1 = 1
        A_tb <= '1'; B_tb <= '1'; wait for 10 ns;
        assert Y_tb = '1' report "Test 4 failed" severity ERROR;
        
        report "All tests completed" severity NOTE;
        wait;
    end process;
    
end Behavioral;
