library ieee;
use ieee.std_logic_1164.all;

entity sequence_detector is
  port (
    clk    : in  std_logic;
    rst    : in  std_logic;
    input  : in  std_logic;
    output : out std_logic
  );
end entity;

architecture fsm of sequence_detector is
  -- Define a new enumeration data type
  type state_type is (S0, S1, S2, S3);
  -- Declare signals
  signal state     : state_type;         -- Current state of the state machine
  signal next_state: state_type;         -- Next state of the state machine
  signal match     : std_logic := '0';   -- Signal to indicate whether the input sequence matches the pattern
    signal next_match     : std_logic := '0';
    
begin
  -- First process for clock and reset
  process (rst, clk)
  begin
    -- If reset is asserted
    if rst = '1' then
      state <= S0;          -- Reset the state to initial state
      match <= '0';         -- Reset the match signal
    -- Else if clock edge is detected
    elsif (CLK'event and CLK='1') then
      state <= next_state;  -- Update the state
      match<=next_match;
    end if;
  end process;

  -- Second process for state transition and pattern detection
  process (state, input)
  begin
    case state is
      -- If in state S0
      when S0 =>
        if input = '0' then  -- If input is 0, stay in the current state
          next_state <= S0;
        else                 -- If input is 1, go to the next state
          next_state <= S1;
        end if;
        
      -- If in state S1
      when S1 =>
        if input = '0' then  -- If input is 0, go to the next state
          next_state <= S2;
        else                 -- If input is 1, stay in the current state
          next_state <= S1;
        end if;
        
      -- If in state S2
      when S2 =>
        if input = '0' then  -- If input is 0, go back to the initial state
          next_state <= S0;
        else                 -- If input is 1, go to the final state
          next_state <= S3;
                    next_match <= '1';      -- Set the match signal to indicate the pattern is detected
        end if;
        
      -- If in state S3
      when S3 =>      
          next_state <= S3;  -- Stay in the final state
    end case;
    
  end process;
  
  -- Third process for assigning the match signal to the output
  process(match)
  begin
    output <= match;        -- Assign the match signal to the output
  end process;

end architecture;
