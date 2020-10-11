library ieee;
context ieee.ieee_std_context;

entity Pong is
  port (
    CLK    : in  std_logic; -- 16MHz Clock input
    USBPU  : out std_logic; -- USB pull resistor
    PIN_14 : out std_logic  -- LED
  );
end;

architecture arch of Pong is

  signal test_clk: std_logic;
  signal counter: unsigned(27 downto 0) := (others=>'0');

  component pxClkGen
    port (
      sys_clk: in std_logic;
      px_clk: out std_logic
    );
  end component;

begin

  -- Drive USB pull-up resistor to '0' to disable USB
  USBPU <= '0';

  -- Instantiate clkgen for reducing the system clock
  clk_generator: component pxClkGen
  port map (
      sys_clk => CLK,
      px_clk  => test_clk -- Generated 50Mhz clock
  );

  -- Use counter logic to divide system clock.  The clock is 48 MHz,
  -- so we divide it down by 2^28.
  process(test_clk)
  begin
    if rising_edge(test_clk) then
      counter <= counter + 1;
    end if;
  end process;

  -- 50Mhz / 2^25 = 1.49Hz ~ 0.671s
  PIN_14 <= counter(25);

end;
