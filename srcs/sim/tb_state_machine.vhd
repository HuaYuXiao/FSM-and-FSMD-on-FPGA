library ieee;
use ieee.std_logic_1164.all;

entity sequence_detector_tb is
end entity;

architecture sim of sequence_detector_tb is
  component sequence_detector is
    port (
      clk    : in  std_logic;
      rst    : in  std_logic;
      input  : in  std_logic;
      output : out std_logic
    );
  end component;

  signal clk      : std_logic:='0';
  signal rst      : std_logic := '1';
  signal input    : std_logic:='0';
  signal output   : std_logic:= '1';

  constant period : time := 10 ns;

begin

  dut : sequence_detector
    port map (
      clk    => clk,
      rst    => rst,
      input  => input,
      output => output
    );

  clock_process : process
  begin
    loop
      clk <= not clk;
      wait for period/2;
    end loop;
    wait;
  end process;

  stimulus : process
  begin
    rst <= '1';
    wait for period*20;
    rst <= '0';

    input <= '1';
    wait for period;
    input <= '0';
    wait for period;
    input <= '1';
    wait for period;
    input <= '1';
    wait for period;
    input <= '0';
    wait for period;
    input <= '1';
    wait for period;
    wait;
  end process;

--  check : process
--  begin
--    wait for period*8;
--    assert output = '1'
--      report "Sequence detected"
--      severity note;
--    wait;
--  end process;

end architecture;
