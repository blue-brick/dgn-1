FUNCTION mul_lfrg (data[(WIDTH-1)..0][1..0], select[(WIDTH-1)..0][2..0])
    WITH (WIDTH, BIT0_OF_SELECT_IS_GND, BIT2_OF_SELECT_IS_SIGN_EXT, BIT0_OF_DATA_IS_GND, INPUTS_ARE_IDENTICAL)
    RETURNS (out_bit[((WIDTH)-1)..0]);
