// Testbench which sets the state of the cache to a snapshot of its data at some point in time

module cache_testbench;

  wire hit;
  wire [7:0] dataByte_read;
  reg clk, reset, cycle_en, rw;
  reg [127:0] dataIn;
  reg [25:0] tagIn;
  reg [7:0] dataByteIn;
  reg [3:0] offset;
  reg [1:0] index;

  // initialization registers
  reg [2:0] init_ctr0, init_ctr1, init_ctr2, init_ctr3, init_ctr4, init_ctr5, init_ctr6, init_ctr7,
			init_ctr8, init_ctr9, init_ctr10, init_ctr11, init_ctr12, init_ctr13, init_ctr14, init_ctr15,
			init_ctr16, init_ctr17, init_ctr18, init_ctr19, init_ctr20, init_ctr21, init_ctr22, init_ctr23,
			init_ctr24, init_ctr25, init_ctr26, init_ctr27, init_ctr28, init_ctr29, init_ctr30, init_ctr31;
  reg [3:0] init_dirty0, init_dirty1, init_dirty2, init_dirty3, init_dirty4, init_dirty5, init_dirty6, init_dirty7;
  reg [3:0] init_valid0, init_valid1, init_valid2, init_valid3, init_valid4, init_valid5, init_valid6, init_valid7;
  reg [25:0] init_tag0, init_tag1, init_tag2, init_tag3, init_tag4, init_tag5, init_tag6, init_tag7,
			 init_tag8, init_tag9, init_tag10, init_tag11, init_tag12, init_tag13, init_tag14, init_tag15,
			 init_tag16, init_tag17, init_tag18, init_tag19, init_tag20, init_tag21, init_tag22, init_tag23,
			 init_tag24, init_tag25, init_tag26, init_tag27, init_tag28, init_tag29, init_tag30, init_tag31;
  reg[127:0] init_data0, init_data1, init_data2, init_data3, init_data4, init_data5, init_data6, init_data7,
			 init_data8, init_data9, init_data10, init_data11, init_data12, init_data13, init_data14, init_data15,
			 init_data16, init_data17, init_data18, init_data19, init_data20, init_data21, init_data22, init_data23,
			 init_data24, init_data25, init_data26, init_data27, init_data28, init_data29, init_data30, init_data31;

  // top module instantiation
  cache_8way uut(clk, reset, tagIn, index, offset, cycle_en, rw, dataIn, dataByteIn, init_dirty0, init_dirty1, init_dirty2,
		 init_dirty3, init_dirty4, init_dirty5, init_dirty6, init_dirty7, init_valid0, init_valid1, init_valid2, init_valid3,
		 init_valid4, init_valid5, init_valid6, init_valid7, init_tag0, init_tag1, init_tag2, init_tag3, init_tag4, init_tag5,
		 init_tag6, init_tag7, init_tag8, init_tag9, init_tag10, init_tag11, init_tag12, init_tag13, init_tag14, init_tag15,
		 init_tag16, init_tag17, init_tag18, init_tag19, init_tag20, init_tag21, init_tag22, init_tag23, init_tag24, init_tag25,
     init_tag26, init_tag27, init_tag28, init_tag29, init_tag30, init_tag31, init_data0, init_data1, init_data2,init_data3,init_data4,
		 init_data5, init_data6, init_data7, init_data8, init_data9, init_data10, init_data11,  init_data12, init_data13, init_data14,
		 init_data15,init_data16,init_data17, init_data18,init_data19, init_data20, init_data21, init_data22, init_data23, init_data24,
		 init_data25, init_data26, init_data27, init_data28, init_data29, init_data30, init_data31, init_ctr0, init_ctr1, init_ctr2,
		 init_ctr3, init_ctr4, init_ctr5, init_ctr6, init_ctr7, init_ctr8, init_ctr9, init_ctr10, init_ctr11, init_ctr12, init_ctr13,
		 init_ctr14, init_ctr15, init_ctr16, init_ctr17, init_ctr18, init_ctr19, init_ctr20, init_ctr21, init_ctr22,  init_ctr23, init_ctr24,
		 init_ctr25, init_ctr26, init_ctr27, init_ctr28, init_ctr29, init_ctr30, init_ctr31, dataByte_read, hit);

  always  #5 clk = ~clk;
  always  #10 cycle_en = ~cycle_en;

  initial
  begin
	clk = 1'b0; reset = 1'b1; cycle_en = 1'b1; index = 2'b00; offset = 4'b0000;

	// Initialization values for FIFO counter
	init_ctr0 = 3'd0; init_ctr1 = 3'd1; init_ctr2 = 3'd2; init_ctr3 = 3'd3; init_ctr4 = 3'd4; init_ctr5 = 3'd5;  init_ctr6 = 3'd6; init_ctr7 = 3'd7;
	init_ctr8 = 3'd1; init_ctr9 = 3'd2; init_ctr10 = 3'd3; init_ctr11 = 3'd4; init_ctr12 = 3'd5; init_ctr13 = 3'd6; init_ctr14 = 3'd7; init_ctr15 = 3'd0;
	init_ctr16 = 3'd2; init_ctr17 = 3'd3; init_ctr18 = 3'd4; init_ctr19 = 3'd5;  init_ctr20 = 3'd6; init_ctr21 = 3'd7; init_ctr22 = 3'd0; init_ctr23 = 3'd1;
	init_ctr24 = 3'd3; init_ctr25 = 3'd4; init_ctr26 = 3'd5; init_ctr27 = 3'd6; init_ctr28 = 3'd7; init_ctr29 = 3'd0; init_ctr30 = 3'd1; init_ctr31 = 3'd2;

	// Initialization values for valid array of the 8 ways
	init_valid0 = 4'b1111; init_valid1 = 4'b1101; init_valid2 = 4'b0101; init_valid3 = 4'b1011;
	init_valid4 = 4'b1111; init_valid5 = 4'b0111; init_valid6 = 4'b0111; init_valid7 = 4'b1111;

	// Initialization values for the tag for each line.
	init_tag0 = 26'd101; init_tag1 = 26'd129; init_tag2 = 26'd167; init_tag3 = 26'd132; init_tag4 = 26'd130; init_tag5 = 26'd107; init_tag6 = 26'd115; init_tag7 = 26'd128;
	init_tag8 = 26'd116; init_tag9 = 26'd102; init_tag10 = 26'd114; init_tag11 = 26'd123; init_tag12 = 26'd109; init_tag13 = 26'd127; init_tag14 = 26'd106; init_tag15 = 26'd125;
	init_tag16 = 26'd117; init_tag17 = 26'd120; init_tag18 = 26'd108; init_tag19 = 26'd113; init_tag20 = 26'd103; init_tag21 = 26'd118; init_tag22 = 26'd105; init_tag23 = 26'd111;
	init_tag24 = 26'd121;  init_tag25 = 26'd104; init_tag26 = 26'd119; init_tag27 = 26'd124; init_tag28 = 26'd110; init_tag29 = 26'd126; init_tag30 = 26'd122; init_tag31 = 26'd112;

	// Initialization values for dirty ways for the 8 ways.
	init_dirty0 = 4'b1000; init_dirty1 = 4'b1000; init_dirty2 = 4'b0000; init_dirty3 = 4'b0000;
	init_dirty4 = 4'b0100; init_dirty5 = 4'b0100; init_dirty6 = 4'b0010; init_dirty7 = 4'b0010;

	// Initialization values for the data lines for each line.
	init_data0 = 128'h11121314121314151314151614151617; init_data1 = 128'h15161718161718191718191A18191A1B; init_data2 = 128'h191A1B1C1A1B1C1D1B1C1D1E1C1D1E1F;
	init_data3 = 128'h1D1E1F201E1F20211F20212220212223; init_data4 = 128'h21222324222324252324252624252627; init_data5 = 128'h25262728262728292728292A28292A2B;
	init_data6 = 128'h292A2B2C2A2B2C2D2B2C2D2E2C2D2E2F; init_data7 = 128'h2D2E2F302E2F30312F30313230313233; init_data8 = 128'h31323334323334353334353634353637;
	init_data9 = 128'h35363738363738393738393A38393A3B; init_data10 = 128'h393A3B3C3A3B3C3D3B3C3D3E3C3D3E3F; init_data11 = 128'h3D3E3F403E3F40413F40414240414243;
	init_data12 = 128'h41424344424344454344454644454647; init_data13 = 128'h45464748464748494748495A48495A5B; init_data14 = 128'h495A5B5C5A5B5C5D5B5C5D5E5C5D5E5F;
	init_data15 = 128'h5D5E5F605E5F60615F60616260616263; init_data16 = 128'h61626364626364656364656664656667; init_data17 = 128'h65666768666768696768696A68696A6B;
	init_data18 = 128'h696A6B6C6A6B6C6D6B6C6D6E6C6D6E6F; init_data19 = 128'h6D6E6F706E6F70716F70717270717273; init_data20 = 128'h71727374727374757374757674757677;
	init_data21 = 128'h75767778767778797778797A78797A7B; init_data22 = 128'h797A7B7C7A7B7C7D7B7C7D7E7C7D7E7F; init_data23 = 128'h7D7E7F807E7F80817F80818280818283;
	init_data24 = 128'h81828384828384858384858684858687; init_data25 = 128'h85868788868788898788899088899091; init_data26 = 128'h89909192909192939192939492939495;
	init_data27 = 128'h93949596949596979596979896979899; init_data28 = 128'h979899A09899A0A199A0A1A2A0A1A2A3; init_data29 = 128'hA1A2A3A4A2A3A4A5A3A4A5A6A4A5A6A7;
	init_data30 = 128'hA5A6A7A8A6A7A8A9A7A8A9AAA8A9AAAB; init_data31 = 128'hA9ABACADABACADAEACADAEAFADAEAFB0;


  // To prevent undefined values at the beginning
  rw = 1'b0; dataIn = 128'h0; tagIn = 26'd0; dataByteIn = 8'b0; offset = 4'b0; index = 2'b0;

	// Read hit
	#10 reset =1'b0; tagIn = 26'd130; index = 2'b00; offset = 4'b1111; rw = 1'b0; dataIn = 128'b0; dataByteIn = 8'b0;

  // Read miss - 1. Replace
	#20 tagIn = 26'd256; index = 2'b01; offset = 4'b1101; dataIn = 128'hffffffffffffffffffffffffffffffff; dataByteIn = 8'b0; rw = 1'b0;
	// Read miss - 2. Read from replaced block
	#20 tagIn = 26'd256; index = 2'b01; offset = 4'b1101; dataIn = 128'b0; dataByteIn = 8'b0; rw = 1'b0;

  // Write hit
	#20 tagIn = 26'd117; index = 2'b10; offset = 4'b0100; dataIn = 128'b0; dataByteIn = 8'h60; rw = 1'b1;

  // Read the newly written block
	#20 tagIn = 26'd117; index = 2'b10; offset = 4'b0100; dataIn = 128'b0; dataByteIn = 8'h0; rw = 1'b0;

  // Write miss - 1. Replace
	#20 tagIn = 26'd257; index = 2'b11; offset = 4'b0000; dataIn = 128'b0; dataByteIn = 8'hdd; rw = 1'b1;
	// Write miss - 2. Write onto replaced block
	#20 tagIn = 26'd257; index = 2'b11; offset = 4'b0000; dataIn = 128'b0; dataByteIn = 8'hdd; rw = 1'b1;

  // Read from the newly written block
	#20 tagIn = 26'd257; index = 2'b11; offset = 4'b0000; dataIn = 128'b0; dataByteIn = 8'b00; rw = 1'b0;

	#30 $finish ;
  end

endmodule
