--All filters were generated using Matlabs excellent fdatool wizard.

-- -------------------------------------------------------------
--
-- Module: octaver_filter_1
--
-- Generated by MATLAB(R) 7.5 and the Filter Design HDL Coder 2.1.
--
-- Generated on: 2010-05-24 20:32:36
--
-- -------------------------------------------------------------

-- -------------------------------------------------------------
-- HDL Code Generation Options:
--
-- TargetLanguage: VHDL
-- UseRisingEdge: on
-- Name: octaver_filter_1
-- SafeZeroConcat: off
-- TestBenchStimulus: chirp ramp step 
--
-- Filter Settings:
--
-- Discrete-Time IIR Filter (real)
-- -------------------------------
-- Filter Structure    : Direct-Form II, Second-Order Sections
-- Number of Sections  : 1
-- Stable              : Yes
-- Linear Phase        : No
-- Arithmetic          : fixed
-- Numerator           : s16,18 -> [-1.250000e-001 1.250000e-001)
-- Denominator         : s16,14 -> [-2 2)
-- Scale Values        : s16,15 -> [-1 1)
-- Input               : s16,15 -> [-1 1)
-- Section Input       : s16,14 -> [-2 2)
-- Section Output      : s16,15 -> [-1 1)
-- Output              : s16,15 -> [-1 1)
-- State               : s16,15 -> [-1 1)
-- Numerator Prod      : s32,33 -> [-2.500000e-001 2.500000e-001)
-- Denominator Prod    : s32,29 -> [-4 4)
-- Numerator Accum     : s40,33 -> [-64 64)
-- Denominator Accum   : s40,29 -> [-1024 1024)
-- Round Mode          : floor
-- Overflow Mode       : saturate
-- Cast Before Sum     : true
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.ALL;

ENTITY octaver_filter_1 IS
   PORT( clk                             :   IN    std_logic; 
         clk_enable                      :   IN    std_logic; 
         reset                           :   IN    std_logic; 
         filter_in                       :   IN    std_logic_vector(15 DOWNTO 0); -- sfix16_En15
         filter_out                      :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En15
         );

END octaver_filter_1;


----------------------------------------------------------------
--Module Architecture: octaver_filter_1
----------------------------------------------------------------
ARCHITECTURE rtl OF octaver_filter_1 IS
  -- Local Functions
  -- Type Definitions
  TYPE delay_pipeline_type IS ARRAY (NATURAL range <>) OF signed(15 DOWNTO 0); -- sfix16_En15
  -- Constants
  CONSTANT scaleconst1                    : signed(15 DOWNTO 0) := to_signed(18707, 16); -- sfix16_En15
  CONSTANT coeff_b1_section1              : signed(15 DOWNTO 0) := to_signed(9928, 16); -- sfix16_En18
  CONSTANT coeff_b2_section1              : signed(15 DOWNTO 0) := to_signed(19855, 16); -- sfix16_En18
  CONSTANT coeff_b3_section1              : signed(15 DOWNTO 0) := to_signed(9928, 16); -- sfix16_En18
  CONSTANT coeff_a2_section1              : signed(15 DOWNTO 0) := to_signed(-25282, 16); -- sfix16_En14
  CONSTANT coeff_a3_section1              : signed(15 DOWNTO 0) := to_signed(10315, 16); -- sfix16_En14
  -- Signals
  SIGNAL input_register                   : signed(15 DOWNTO 0); -- sfix16_En15
  SIGNAL scale1                           : signed(15 DOWNTO 0); -- sfix16_En14
  SIGNAL mul_temp                         : signed(31 DOWNTO 0); -- sfix32_En30
  -- Section 1 Signals 
  SIGNAL a1sum1                           : signed(39 DOWNTO 0); -- sfix40_En29
  SIGNAL a2sum1                           : signed(39 DOWNTO 0); -- sfix40_En29
  SIGNAL b1sum1                           : signed(39 DOWNTO 0); -- sfix40_En33
  SIGNAL b2sum1                           : signed(39 DOWNTO 0); -- sfix40_En33
  SIGNAL typeconvert1                     : signed(15 DOWNTO 0); -- sfix16_En15
  SIGNAL delay_section1                   : delay_pipeline_type(0 TO 1); -- sfix16_En15
  SIGNAL inputconv1                       : signed(15 DOWNTO 0); -- sfix16_En14
  SIGNAL a2mul1                           : signed(31 DOWNTO 0); -- sfix32_En29
  SIGNAL a3mul1                           : signed(31 DOWNTO 0); -- sfix32_En29
  SIGNAL b1mul1                           : signed(31 DOWNTO 0); -- sfix32_En33
  SIGNAL b2mul1                           : signed(31 DOWNTO 0); -- sfix32_En33
  SIGNAL b3mul1                           : signed(31 DOWNTO 0); -- sfix32_En33
  SIGNAL sub_cast                         : signed(39 DOWNTO 0); -- sfix40_En29
  SIGNAL sub_cast_1                       : signed(39 DOWNTO 0); -- sfix40_En29
  SIGNAL sub_temp                         : signed(40 DOWNTO 0); -- sfix41_En29
  SIGNAL sub_cast_2                       : signed(39 DOWNTO 0); -- sfix40_En29
  SIGNAL sub_cast_3                       : signed(39 DOWNTO 0); -- sfix40_En29
  SIGNAL sub_temp_1                       : signed(40 DOWNTO 0); -- sfix41_En29
  SIGNAL b1multypeconvert1                : signed(39 DOWNTO 0); -- sfix40_En33
  SIGNAL add_cast                         : signed(39 DOWNTO 0); -- sfix40_En33
  SIGNAL add_cast_1                       : signed(39 DOWNTO 0); -- sfix40_En33
  SIGNAL add_temp                         : signed(40 DOWNTO 0); -- sfix41_En33
  SIGNAL add_cast_2                       : signed(39 DOWNTO 0); -- sfix40_En33
  SIGNAL add_cast_3                       : signed(39 DOWNTO 0); -- sfix40_En33
  SIGNAL add_temp_1                       : signed(40 DOWNTO 0); -- sfix41_En33
  SIGNAL output_typeconvert               : signed(15 DOWNTO 0); -- sfix16_En15
  SIGNAL output_register                  : signed(15 DOWNTO 0); -- sfix16_En15


BEGIN

  -- Block Statements
  input_reg_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_register <= (OTHERS => '0');
    ELSIF rising_edge(clk) THEN
      IF clk_enable = '1' THEN
        input_register <= signed(filter_in);
      END IF;
    END IF; 
  END PROCESS input_reg_process;

  mul_temp <= input_register * scaleconst1;
  scale1 <= mul_temp(31 DOWNTO 16);

  --   ------------------ Section 1 ------------------

  typeconvert1 <= (15 => '0', OTHERS => '1') WHEN a1sum1(39) = '0' AND a1sum1(38 DOWNTO 29) /= "0000000000"
      ELSE (15 => '1', OTHERS => '0') WHEN a1sum1(39) = '1' AND a1sum1(38 DOWNTO 29) /= "1111111111"
      ELSE (a1sum1(29 DOWNTO 14));

  delay_process_section1 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delay_section1(0 TO 1) <= (OTHERS => (OTHERS => '0'));
    ELSIF rising_edge(clk) THEN
      IF clk_enable = '1' THEN
        delay_section1(0) <= typeconvert1;
        delay_section1(1) <= delay_section1(0);
      END IF;
    END IF; 
  END PROCESS delay_process_section1;


  inputconv1 <= scale1;

  a2mul1 <= delay_section1(0) * coeff_a2_section1;

  a3mul1 <= delay_section1(1) * coeff_a3_section1;

  b1mul1 <= typeconvert1 * coeff_b1_section1;

  b2mul1 <= delay_section1(0) * coeff_b2_section1;

  b3mul1 <= delay_section1(1) * coeff_b3_section1;

  sub_cast <= resize(inputconv1 & "000000000000000", 40);
  sub_cast_1 <= resize(a2mul1, 40);
  sub_temp <= resize(sub_cast, 41) - resize(sub_cast_1, 41);
  a2sum1 <= (39 => '0', OTHERS => '1') WHEN sub_temp(40) = '0' AND sub_temp(39) /= '0'
      ELSE (39 => '1', OTHERS => '0') WHEN sub_temp(40) = '1' AND sub_temp(39) /= '1'
      ELSE (sub_temp(39 DOWNTO 0));

  sub_cast_2 <= a2sum1;
  sub_cast_3 <= resize(a3mul1, 40);
  sub_temp_1 <= resize(sub_cast_2, 41) - resize(sub_cast_3, 41);
  a1sum1 <= (39 => '0', OTHERS => '1') WHEN sub_temp_1(40) = '0' AND sub_temp_1(39) /= '0'
      ELSE (39 => '1', OTHERS => '0') WHEN sub_temp_1(40) = '1' AND sub_temp_1(39) /= '1'
      ELSE (sub_temp_1(39 DOWNTO 0));

  b1multypeconvert1 <= resize(b1mul1, 40);

  add_cast <= b1multypeconvert1;
  add_cast_1 <= resize(b2mul1, 40);
  add_temp <= resize(add_cast, 41) + resize(add_cast_1, 41);
  b2sum1 <= (39 => '0', OTHERS => '1') WHEN add_temp(40) = '0' AND add_temp(39) /= '0'
      ELSE (39 => '1', OTHERS => '0') WHEN add_temp(40) = '1' AND add_temp(39) /= '1'
      ELSE (add_temp(39 DOWNTO 0));

  add_cast_2 <= b2sum1;
  add_cast_3 <= resize(b3mul1, 40);
  add_temp_1 <= resize(add_cast_2, 41) + resize(add_cast_3, 41);
  b1sum1 <= (39 => '0', OTHERS => '1') WHEN add_temp_1(40) = '0' AND add_temp_1(39) /= '0'
      ELSE (39 => '1', OTHERS => '0') WHEN add_temp_1(40) = '1' AND add_temp_1(39) /= '1'
      ELSE (add_temp_1(39 DOWNTO 0));

  output_typeconvert <= (15 => '0', OTHERS => '1') WHEN b1sum1(39) = '0' AND b1sum1(38 DOWNTO 33) /= "000000"
      ELSE (15 => '1', OTHERS => '0') WHEN b1sum1(39) = '1' AND b1sum1(38 DOWNTO 33) /= "111111"
      ELSE (b1sum1(33 DOWNTO 18));

  output_reg_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      output_register <= (OTHERS => '0');
    ELSIF rising_edge(clk) THEN
      IF clk_enable = '1' THEN
        output_register <= output_typeconvert;
      END IF;
    END IF; 
  END PROCESS output_reg_process;

  -- Assignment Statements
  filter_out <= std_logic_vector(output_register);
END rtl;
