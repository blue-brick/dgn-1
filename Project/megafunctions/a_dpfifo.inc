FUNCTION a_dpfifo(	data[lpm_width-1..0], 
					wreq, rreq, clock, aclr, sclr
				 )
    WITH( LPM_WIDTH, LPM_NUMWORDS, LPM_SHOWAHEAD, UNDERFLOW_CHECKING, OVERFLOW_CHECKING, ALLOW_RWCYCLE_WHEN_FULL )
    RETURNS(	q[lpm_width-1..0], 
    			empty, full,
    			usedw[ceil(log2(LPM_NUMWORDS))-1..0]
    	   );

