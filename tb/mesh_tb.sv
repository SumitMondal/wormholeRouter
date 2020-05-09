//Engineer     : Sumit Mondal
//Date         : April 2020
//Name of file : mesh_tb.sv
//Description  : 4x4 Mesh Tstbench, generates simulation results (currently just throughput)

`timescale 1ns / 1ps

module mesh_tb #(
);
	// To run this testbench/gather simulation results
	// 1. compile all things in this folder
	// 2. vsim -novopt work.mesh_tb
	// 3. run -a (NOTE: do NOT run "log -r *" it will not ever complete the sim)
	// 4. Wallah ! the score is how many flits were recovered.

	int inj_rate = 50;
	int num_cycles = 5000;
	parameter buffer_depth = 64;


	logic clk;
	logic rst;
	logic [63:0] flit_written;

	int score_00;
	int score_01;
	int score_02;
	int score_03;
	int score_10;
	int score_11;
	int score_12;
	int score_13;
	int score_20;
	int score_21;
	int score_22;
	int score_23;
	int score_30;
	int score_31;
	int score_32;
	int score_33;
	int fin_score;
	int rnd;


	// router 00..
    logic [63:0] flit_inport_south_00;
    logic valid_in_south_00;
    logic buffer_on_in_south_00 = 1;
    logic [63:0] flit_inport_west_00;
    logic valid_in_west_00;
    logic buffer_on_in_west_00 = 1;
    logic [63:0] flit_inport_local_00;
    logic valid_in_local_00;
    logic buffer_on_in_local_00 = 1;
    logic [63:0] flit_outport_north_00;
    logic valid_outport_north_00;
    logic buffer_on_out_north_00;
    logic [63:0] flit_outport_east_00;
    logic valid_outport_east_00;
    logic buffer_on_out_east_00;
    logic [63:0] flit_outport_south_00;
    logic valid_outport_south_00;
    logic buffer_on_out_south_00;
    logic [63:0] flit_outport_west_00;
    logic valid_outport_west_00;
    logic buffer_on_out_west_00;
    logic [63:0] flit_outport_local_00;
    logic valid_outport_local_00;
    logic buffer_on_out_local_00;
    logic [4:0] valid_downstream_ports_00;

        // router_01..
    logic [63:0] flit_inport_west_01;
    logic valid_in_west_01;
    logic buffer_on_in_west_01 = 1;
    logic [63:0] flit_inport_local_01;
    logic valid_in_local_01;
    logic buffer_on_in_local_01 = 1;
    logic [63:0] flit_outport_north_01;
    logic valid_outport_north_01;
    logic buffer_on_out_north_01;
    logic [63:0] flit_outport_east_01;
    logic valid_outport_east_01;
    logic buffer_on_out_east_01;
    logic [63:0] flit_outport_south_01;
    logic valid_outport_south_01;
    logic buffer_on_out_south_01;
    logic [63:0] flit_outport_west_01;
    logic valid_outport_west_01;
    logic buffer_on_out_west_01;
    logic [63:0] flit_outport_local_01;
    logic valid_outport_local_01;
    logic buffer_on_out_local_01;
    logic [4:0] valid_downstream_ports_01;

    	// router_02..
    logic [63:0] flit_inport_west_02;
    logic valid_in_west_02;
    logic buffer_on_in_west_02 = 1;
    logic [63:0] flit_inport_local_02;
    logic valid_in_local_02;
    logic buffer_on_in_local_02 = 1;
    logic [63:0] flit_outport_north_02;
    logic valid_outport_north_02;
    logic buffer_on_out_north_02;
    logic [63:0] flit_outport_east_02;
    logic valid_outport_east_02;
    logic buffer_on_out_east_02;
    logic [63:0] flit_outport_south_02;
    logic valid_outport_south_02;
    logic buffer_on_out_south_02;
    logic [63:0] flit_outport_west_02;
    logic valid_outport_west_02;
    logic buffer_on_out_west_02;
    logic [63:0] flit_outport_local_02;
    logic valid_outport_local_02;
    logic buffer_on_out_local_02;
    logic [4:0] valid_downstream_ports_02;

        	// router_03..
    logic [63:0] flit_inport_north_03;
    logic valid_in_north_03;
    logic buffer_on_in_north_03 = 1;
    logic [63:0] flit_inport_west_03;
    logic valid_in_west_03;
    logic buffer_on_in_west_03 = 1;
    logic [63:0] flit_inport_local_03;
    logic valid_in_local_03;
    logic buffer_on_in_local_03 = 1;
    logic [63:0] flit_outport_north_03;
    logic valid_outport_north_03;
    logic buffer_on_out_north_03;
    logic [63:0] flit_outport_east_03;
    logic valid_outport_east_03;
    logic buffer_on_out_east_03;
    logic [63:0] flit_outport_south_03;
    logic valid_outport_south_03;
    logic buffer_on_out_south_03;
    logic [63:0] flit_outport_west_03;
    logic valid_outport_west_03;
    logic buffer_on_out_west_03;
    logic [63:0] flit_outport_local_03;
    logic valid_outport_local_03;
    logic buffer_on_out_local_03;
    logic [4:0] valid_downstream_ports_03;

    	// router_10..
    logic [63:0] flit_inport_south_10;
    logic valid_in_south_10;
    logic buffer_on_in_south_10 = 1;
    logic [63:0] flit_inport_local_10;
    logic valid_in_local_10;
    logic buffer_on_in_local_10 = 1;
    logic [63:0] flit_outport_north_10;
    logic valid_outport_north_10;
    logic buffer_on_out_north_10;
    logic [63:0] flit_outport_east_10;
    logic valid_outport_east_10;
    logic buffer_on_out_east_10;
    logic [63:0] flit_outport_south_10;
    logic valid_outport_south_10;
    logic buffer_on_out_south_10;
    logic [63:0] flit_outport_west_10;
    logic valid_outport_west_10;
    logic buffer_on_out_west_10;
    logic [63:0] flit_outport_local_10;
    logic valid_outport_local_10;
    logic buffer_on_out_local_10;
    logic [4:0] valid_downstream_ports_10;

     // Router_11 ..
    logic [63:0] flit_inport_local_11;
    logic valid_in_local_11;
    logic buffer_on_in_local_11 = 1;
    logic [63:0] flit_outport_north_11;
    logic valid_outport_north_11;
    logic buffer_on_out_north_11;
    logic [63:0] flit_outport_east_11;
    logic valid_outport_east_11;
    logic buffer_on_out_east_11;
    logic [63:0] flit_outport_south_11;
    logic valid_outport_south_11;
    logic buffer_on_out_south_11;
    logic [63:0] flit_outport_west_11;
    logic valid_outport_west_11;
    logic buffer_on_out_west_11;
    logic [63:0] flit_outport_local_11;
    logic valid_outport_local_11;
    logic buffer_on_out_local_11;
    logic [4:0] valid_downstream_ports_11;

        	// router_12..
    logic [63:0] flit_inport_local_12;
    logic valid_in_local_12;
    logic buffer_on_in_local_12 = 1;
    logic [63:0] flit_outport_north_12;
    logic valid_outport_north_12;
    logic buffer_on_out_north_12;
    logic [63:0] flit_outport_east_12;
    logic valid_outport_east_12;
    logic buffer_on_out_east_12;
    logic [63:0] flit_outport_south_12;
    logic valid_outport_south_12;
    logic buffer_on_out_south_12;
    logic [63:0] flit_outport_west_12;
    logic valid_outport_west_12;
    logic buffer_on_out_west_12;
    logic [63:0] flit_outport_local_12;
    logic valid_outport_local_12;
    logic buffer_on_out_local_12;
    logic [4:0] valid_downstream_ports_12;

    	// router_13..
    logic [63:0] flit_inport_north_13;
    logic valid_in_north_13;
    logic buffer_on_in_north_13 = 1;
    logic [63:0] flit_inport_local_13;
    logic valid_in_local_13;
    logic buffer_on_in_local_13 = 1;
    logic [63:0] flit_outport_north_13;
    logic valid_outport_north_13;
    logic buffer_on_out_north_13;
    logic [63:0] flit_outport_east_13;
    logic valid_outport_east_13;
    logic buffer_on_out_east_13;
    logic [63:0] flit_outport_south_13;
    logic valid_outport_south_13;
    logic buffer_on_out_south_13;
    logic [63:0] flit_outport_west_13;
    logic valid_outport_west_13;
    logic buffer_on_out_west_13;
    logic [63:0] flit_outport_local_13;
    logic valid_outport_local_13;
    logic buffer_on_out_local_13;
    logic [4:0] valid_downstream_ports_13;
    
            // router_20..
    logic [63:0] flit_inport_south_20;
    logic valid_in_south_20;
    logic buffer_on_in_south_20 = 1;
    logic [63:0] flit_inport_local_20;
    logic valid_in_local_20;
    logic buffer_on_in_local_20 = 1;
    logic [63:0] flit_outport_north_20;
    logic valid_outport_north_20;
    logic buffer_on_out_north_20;
    logic [63:0] flit_outport_east_20;
    logic valid_outport_east_20;
    logic buffer_on_out_east_20;
    logic [63:0] flit_outport_south_20;
    logic valid_outport_south_20;
    logic buffer_on_out_south_20;
    logic [63:0] flit_outport_west_20;
    logic valid_outport_west_20;
    logic buffer_on_out_west_20;
    logic [63:0] flit_outport_local_20;
    logic valid_outport_local_20;
    logic buffer_on_out_local_20;
    logic [4:0] valid_downstream_ports_20;

            // Router_21 ..
    logic [63:0] flit_inport_local_21;
    logic valid_in_local_21;
    logic buffer_on_in_local_21 = 1;
    logic [63:0] flit_outport_north_21;
    logic valid_outport_north_21;
    logic buffer_on_out_north_21;
    logic [63:0] flit_outport_east_21;
    logic valid_outport_east_21;
    logic buffer_on_out_east_21;
    logic [63:0] flit_outport_south_21;
    logic valid_outport_south_21;
    logic buffer_on_out_south_21;
    logic [63:0] flit_outport_west_21;
    logic valid_outport_west_21;
    logic buffer_on_out_west_21;
    logic [63:0] flit_outport_local_21;
    logic valid_outport_local_21;
    logic buffer_on_out_local_21;
    logic [4:0] valid_downstream_ports_21;
    
        // router_22..
    logic [63:0] flit_inport_local_22;
    logic valid_in_local_22;
    logic buffer_on_in_local_22 = 1;
    logic [63:0] flit_outport_north_22;
    logic valid_outport_north_22;
    logic buffer_on_out_north_22;
    logic [63:0] flit_outport_east_22;
    logic valid_outport_east_22;
    logic buffer_on_out_east_22;
    logic [63:0] flit_outport_south_22;
    logic valid_outport_south_22;
    logic buffer_on_out_south_22;
    logic [63:0] flit_outport_west_22;
    logic valid_outport_west_22;
    logic buffer_on_out_west_22;
    logic [63:0] flit_outport_local_22;
    logic valid_outport_local_22;
    logic buffer_on_out_local_22;
    logic [4:0] valid_downstream_ports_22;

        // router_23..
    logic [63:0] flit_inport_north_23;
    logic valid_in_north_23;
    logic buffer_on_in_north_23 = 1;
   
    logic [63:0] flit_inport_local_23;
    logic valid_in_local_23;
    logic buffer_on_in_local_23 = 1;
    logic [63:0] flit_outport_north_23;
    logic valid_outport_north_23;
    logic buffer_on_out_north_23;
    logic [63:0] flit_outport_east_23;
    logic valid_outport_east_23;
    logic buffer_on_out_east_23;
    logic [63:0] flit_outport_south_23;
    logic valid_outport_south_23;
    logic buffer_on_out_south_23;
    logic [63:0] flit_outport_west_23;
    logic valid_outport_west_23;
    logic buffer_on_out_west_23;
    logic [63:0] flit_outport_local_23;
    logic valid_outport_local_23;
    logic buffer_on_out_local_23;
    logic [4:0] valid_downstream_ports_23;

                // router_30..
    logic [63:0] flit_inport_east_30;
    logic valid_in_east_30;
    logic buffer_on_in_east_30 = 1;
    logic [63:0] flit_inport_south_30;
    logic valid_in_south_30;
    logic buffer_on_in_south_30 = 1;
    logic [63:0] flit_inport_local_30;
    logic valid_in_local_30;
    logic buffer_on_in_local_30 = 1;
    logic [63:0] flit_outport_north_30;
    logic valid_outport_north_30;
    logic buffer_on_out_north_30;
    logic [63:0] flit_outport_east_30;
    logic valid_outport_east_30;
    logic buffer_on_out_east_30;
    logic [63:0] flit_outport_south_30;
    logic valid_outport_south_30;
    logic buffer_on_out_south_30;
    logic [63:0] flit_outport_west_30;
    logic valid_outport_west_30;
    logic buffer_on_out_west_30;
    logic [63:0] flit_outport_local_30;
    logic valid_outport_local_30;
    logic buffer_on_out_local_30;
    logic [4:0] valid_downstream_ports_30;

        // Router_31 ..
    logic [63:0] flit_inport_east_31;
    logic valid_in_east_31;
    logic buffer_on_in_east_31 = 1;
    logic [63:0] flit_inport_local_31;
    logic valid_in_local_31;
    logic buffer_on_in_local_31 = 1;
    logic [63:0] flit_outport_north_31;
    logic valid_outport_north_31;
    logic buffer_on_out_north_31;
    logic [63:0] flit_outport_east_31;
    logic valid_outport_east_31;
    logic buffer_on_out_east_31;
    logic [63:0] flit_outport_south_31;
    logic valid_outport_south_31;
    logic buffer_on_out_south_31;
    logic [63:0] flit_outport_west_31;
    logic valid_outport_west_31;
    logic buffer_on_out_west_31;
    logic [63:0] flit_outport_local_31;
    logic valid_outport_local_31;
    logic buffer_on_out_local_31;
    logic [4:0] valid_downstream_ports_31;

        // router_32..
    logic [63:0] flit_inport_east_32;
    logic valid_in_east_32;
    logic buffer_on_in_east_32 = 1;
    logic [63:0] flit_inport_local_32;
    logic valid_in_local_32;
    logic buffer_on_in_local_32 = 1;
    logic [63:0] flit_outport_north_32;
    logic valid_outport_north_32;
    logic buffer_on_out_north_32;
    logic [63:0] flit_outport_east_32;
    logic valid_outport_east_32;
    logic buffer_on_out_east_32;
    logic [63:0] flit_outport_south_32;
    logic valid_outport_south_32;
    logic buffer_on_out_south_32;
    logic [63:0] flit_outport_west_32;
    logic valid_outport_west_32;
    logic buffer_on_out_west_32;
    logic [63:0] flit_outport_local_32;
    logic valid_outport_local_32;
    logic buffer_on_out_local_32;
    logic [4:0] valid_downstream_ports_32;
        // router_33..
    logic [63:0] flit_inport_north_33;
    logic valid_in_north_33;
    logic buffer_on_in_north_33 = 1;
    logic [63:0] flit_inport_east_33;
    logic valid_in_east_33;
    logic buffer_on_in_east_33 = 1;
    logic [63:0] flit_inport_local_33;
    logic valid_in_local_33;
    logic buffer_on_in_local_33 = 1;
    logic [63:0] flit_outport_north_33;
    logic valid_outport_north_33;
    logic buffer_on_out_north_33;
    logic [63:0] flit_outport_east_33;
    logic valid_outport_east_33;
    logic buffer_on_out_east_33;
    logic [63:0] flit_outport_south_33;
    logic valid_outport_south_33;
    logic buffer_on_out_south_33;
    logic [63:0] flit_outport_west_33;
    logic valid_outport_west_33;
    logic buffer_on_out_west_33;
    logic [63:0] flit_outport_local_33;
    logic valid_outport_local_33;
    logic buffer_on_out_local_33;
    logic [4:0] valid_downstream_ports_33;




    router #(
    	.BUFFER_SIZE_ROUTER(buffer_depth),
    	.X_CURRENT(3'b000),
    	.Y_CURRENT(3'b000)
    )
    router_00 (
    .clk(clk),
	.rst(rst),
    .flit_inport_north(flit_outport_south_01),
    .valid_in_north(valid_outport_south_01),
    .buffer_on_in_north(buffer_on_out_south_01),
    .flit_inport_east(flit_outport_west_10),
    .valid_in_east(valid_outport_west_10),
    .buffer_on_in_east(buffer_on_out_west_10),
    .flit_inport_south(flit_inport_south_00),
    .valid_in_south(valid_in_south_00),
    .buffer_on_in_south(buffer_on_in_south_00),
    .flit_inport_west(flit_inport_west_00),
    .valid_in_west(valid_in_west_00),
    .buffer_on_in_west(buffer_on_in_west_00),
    .flit_inport_local(flit_inport_local_00),
    .valid_in_local(valid_in_local_00),
    .buffer_on_in_local(buffer_on_in_local_00),
    .flit_outport_north(flit_outport_north_00),
    .valid_outport_north(valid_outport_north_00),
    .buffer_on_out_north(buffer_on_out_north_00),
    .flit_outport_east(flit_outport_east_00),
    .valid_outport_east(valid_outport_east_00),
    .buffer_on_out_east(buffer_on_out_east_00),
    .flit_outport_south(flit_outport_south_00),
    .valid_outport_south(valid_outport_south_00),
    .buffer_on_out_south(buffer_on_out_south_00),
    .flit_outport_west(flit_outport_west_00),
    .valid_outport_west(valid_outport_west_00),
    .buffer_on_out_west(buffer_on_out_west_00),
    .flit_outport_local(flit_outport_local_00),
    .valid_outport_local(valid_outport_local_00),
    .buffer_on_out_local(buffer_on_out_local_00),
    .valid_downstream_ports(valid_downstream_ports_00)
    );



    router #(
    	.BUFFER_SIZE_ROUTER(buffer_depth),
    	.X_CURRENT(3'b000),
    	.Y_CURRENT(3'b001)
    )
    router_01 (
    .clk(clk),
	.rst(rst),
    .flit_inport_north(flit_outport_south_02),
    .valid_in_north(valid_outport_south_02),
    .buffer_on_in_north(buffer_on_out_south_02),
    .flit_inport_east(flit_outport_west_11),
    .valid_in_east(valid_outport_west_11),
    .buffer_on_in_east(buffer_on_out_west_11),
    .flit_inport_south(flit_outport_north_00),
    .valid_in_south(valid_outport_north_00),
    .buffer_on_in_south(buffer_on_out_north_00),
    .flit_inport_west(flit_inport_west_01),
    .valid_in_west(valid_in_west_01),
    .buffer_on_in_west(buffer_on_in_west_01),
    .flit_inport_local(flit_inport_local_01),
    .valid_in_local(valid_in_local_01),
    .buffer_on_in_local(buffer_on_in_local_01),
    .flit_outport_north(flit_outport_north_01),
    .valid_outport_north(valid_outport_north_01),
    .buffer_on_out_north(buffer_on_out_north_01),
    .flit_outport_east(flit_outport_east_01),
    .valid_outport_east(valid_outport_east_01),
    .buffer_on_out_east(buffer_on_out_east_01),
    .flit_outport_south(flit_outport_south_01),
    .valid_outport_south(valid_outport_south_01),
    .buffer_on_out_south(buffer_on_out_south_01),
    .flit_outport_west(flit_outport_west_01),
    .valid_outport_west(valid_outport_west_01),
    .buffer_on_out_west(buffer_on_out_west_01),
    .flit_outport_local(flit_outport_local_01),
    .valid_outport_local(valid_outport_local_01),
    .buffer_on_out_local(buffer_on_out_local_01),
    .valid_downstream_ports(valid_downstream_ports_01)
    );


    router #(
    	.BUFFER_SIZE_ROUTER(buffer_depth),
    	.X_CURRENT(3'b000),
    	.Y_CURRENT(3'b010)
    )
    router_02 (
    .clk(clk),
	.rst(rst),
    .flit_inport_north(flit_outport_south_03),
    .valid_in_north(valid_outport_south_03),
    .buffer_on_in_north(buffer_on_out_south_03),
    .flit_inport_east(flit_outport_west_12),
    .valid_in_east(valid_outport_west_12),
    .buffer_on_in_east(buffer_on_out_west_12),
    .flit_inport_south(flit_outport_north_01),
    .valid_in_south(valid_outport_north_01),
    .buffer_on_in_south(buffer_on_out_north_01),
    .flit_inport_west(flit_inport_west_02),
    .valid_in_west(valid_in_west_02),
    .buffer_on_in_west(buffer_on_in_west_02),
    .flit_inport_local(flit_inport_local_02),
    .valid_in_local(valid_in_local_02),
    .buffer_on_in_local(buffer_on_in_local_02),
    .flit_outport_north(flit_outport_north_02),
    .valid_outport_north(valid_outport_north_02),
    .buffer_on_out_north(buffer_on_out_north_02),
    .flit_outport_east(flit_outport_east_02),
    .valid_outport_east(valid_outport_east_02),
    .buffer_on_out_east(buffer_on_out_east_02),
    .flit_outport_south(flit_outport_south_02),
    .valid_outport_south(valid_outport_south_02),
    .buffer_on_out_south(buffer_on_out_south_02),
    .flit_outport_west(flit_outport_west_02),
    .valid_outport_west(valid_outport_west_02),
    .buffer_on_out_west(buffer_on_out_west_02),
    .flit_outport_local(flit_outport_local_02),
    .valid_outport_local(valid_outport_local_02),
    .buffer_on_out_local(buffer_on_out_local_02),
    .valid_downstream_ports(valid_downstream_ports_02)
    );



    router #(
    	.BUFFER_SIZE_ROUTER(buffer_depth),
    	.X_CURRENT(3'b000),
    	.Y_CURRENT(3'b011)
    )
    router_03 (
    .clk(clk),
	.rst(rst),
    .flit_inport_north(flit_inport_north_03),
    .valid_in_north(valid_in_north_03),
    .buffer_on_in_north(buffer_on_in_north_03),
    .flit_inport_east(flit_outport_west_13),
    .valid_in_east(valid_outport_west_13),
    .buffer_on_in_east(buffer_on_out_west_13),
    .flit_inport_south(flit_outport_north_02),
    .valid_in_south(valid_outport_north_02),
    .buffer_on_in_south(buffer_on_out_north_02),
    .flit_inport_west(flit_inport_west_03),
    .valid_in_west(valid_in_west_03),
    .buffer_on_in_west(buffer_on_in_west_03),
    .flit_inport_local(flit_inport_local_03),
    .valid_in_local(valid_in_local_03),
    .buffer_on_in_local(buffer_on_in_local_03),
    .flit_outport_north(flit_outport_north_03),
    .valid_outport_north(valid_outport_north_03),
    .buffer_on_out_north(buffer_on_out_north_03),
    .flit_outport_east(flit_outport_east_03),
    .valid_outport_east(valid_outport_east_03),
    .buffer_on_out_east(buffer_on_out_east_03),
    .flit_outport_south(flit_outport_south_03),
    .valid_outport_south(valid_outport_south_03),
    .buffer_on_out_south(buffer_on_out_south_03),
    .flit_outport_west(flit_outport_west_03),
    .valid_outport_west(valid_outport_west_03),
    .buffer_on_out_west(buffer_on_out_west_03),
    .flit_outport_local(flit_outport_local_03),
    .valid_outport_local(valid_outport_local_03),
    .buffer_on_out_local(buffer_on_out_local_03),
    .valid_downstream_ports(valid_downstream_ports_03)
    );

    

    router #(
    	.BUFFER_SIZE_ROUTER(buffer_depth),
    	.X_CURRENT(3'b001),
    	.Y_CURRENT(3'b000)
    )
    router_10 (
    .clk(clk),
	.rst(rst),
    .flit_inport_north(flit_outport_south_11),
    .valid_in_north(valid_outport_south_11),
    .buffer_on_in_north(buffer_on_out_south_11),
    .flit_inport_east(flit_outport_west_20),
    .valid_in_east(valid_outport_west_20),
    .buffer_on_in_east(buffer_on_out_west_20),
    .flit_inport_south(flit_inport_south_10),
    .valid_in_south(valid_in_south_10),
    .buffer_on_in_south(buffer_on_in_south_10),
    .flit_inport_west(flit_outport_east_00),
    .valid_in_west(valid_outport_east_00),
    .buffer_on_in_west(buffer_on_out_east_00),
    .flit_inport_local(flit_inport_local_10),
    .valid_in_local(valid_in_local_10),
    .buffer_on_in_local(buffer_on_in_local_10),
    .flit_outport_north(flit_outport_north_10),
    .valid_outport_north(valid_outport_north_10),
    .buffer_on_out_north(buffer_on_out_north_10),
    .flit_outport_east(flit_outport_east_10),
    .valid_outport_east(valid_outport_east_10),
    .buffer_on_out_east(buffer_on_out_east_10),
    .flit_outport_south(flit_outport_south_10),
    .valid_outport_south(valid_outport_south_10),
    .buffer_on_out_south(buffer_on_out_south_10),
    .flit_outport_west(flit_outport_west_10),
    .valid_outport_west(valid_outport_west_10),
    .buffer_on_out_west(buffer_on_out_west_10),
    .flit_outport_local(flit_outport_local_10),
    .valid_outport_local(valid_outport_local_10),
    .buffer_on_out_local(buffer_on_out_local_10),
    .valid_downstream_ports(valid_downstream_ports_10)
    );

   

    router #(
    	.BUFFER_SIZE_ROUTER(buffer_depth),
    	.X_CURRENT(3'b001),
    	.Y_CURRENT(3'b001)
    )
    router_11 (
    .clk(clk),
	.rst(rst),
    .flit_inport_north(flit_outport_south_12),
    .valid_in_north(valid_outport_south_12),
    .buffer_on_in_north(buffer_on_out_south_12),
    .flit_inport_east(flit_outport_west_21),
    .valid_in_east(valid_outport_west_21),
    .buffer_on_in_east(buffer_on_out_west_21),
    .flit_inport_south(flit_outport_north_10),
    .valid_in_south(valid_outport_north_10),
    .buffer_on_in_south(buffer_on_out_north_10),
    .flit_inport_west(flit_outport_east_01),
    .valid_in_west(valid_outport_east_01),
    .buffer_on_in_west(buffer_on_out_east_01),
    .flit_inport_local(flit_inport_local_11),
    .valid_in_local(valid_in_local_11),
    .buffer_on_in_local(buffer_on_in_local_11),
    .flit_outport_north(flit_outport_north_11),
    .valid_outport_north(valid_outport_north_11),
    .buffer_on_out_north(buffer_on_out_north_11),
    .flit_outport_east(flit_outport_east_11),
    .valid_outport_east(valid_outport_east_11),
    .buffer_on_out_east(buffer_on_out_east_11),
    .flit_outport_south(flit_outport_south_11),
    .valid_outport_south(valid_outport_south_11),
    .buffer_on_out_south(buffer_on_out_south_11),
    .flit_outport_west(flit_outport_west_11),
    .valid_outport_west(valid_outport_west_11),
    .buffer_on_out_west(buffer_on_out_west_11),
    .flit_outport_local(flit_outport_local_11),
    .valid_outport_local(valid_outport_local_11),
    .buffer_on_out_local(buffer_on_out_local_11),
    .valid_downstream_ports(valid_downstream_ports_11)
    );

    


    router #(
    	.BUFFER_SIZE_ROUTER(buffer_depth),
    	.X_CURRENT(3'b001),
    	.Y_CURRENT(3'b010)
    )
    router_12 (
    .clk(clk),
	.rst(rst),
    .flit_inport_north(flit_outport_south_13),
    .valid_in_north(valid_outport_south_13),
    .buffer_on_in_north(buffer_on_out_south_13),
    .flit_inport_east(flit_outport_west_22),
    .valid_in_east(valid_outport_west_22),
    .buffer_on_in_east(buffer_on_out_west_22),
    .flit_inport_south(flit_outport_north_11),
    .valid_in_south(valid_outport_north_11),
    .buffer_on_in_south(buffer_on_out_north_11),
    .flit_inport_west(flit_outport_east_02),
    .valid_in_west(valid_outport_east_02),
    .buffer_on_in_west(buffer_on_out_east_02),
    .flit_inport_local(flit_inport_local_12),
    .valid_in_local(valid_in_local_12),
    .buffer_on_in_local(buffer_on_in_local_12),
    .flit_outport_north(flit_outport_north_12),
    .valid_outport_north(valid_outport_north_12),
    .buffer_on_out_north(buffer_on_out_north_12),
    .flit_outport_east(flit_outport_east_12),
    .valid_outport_east(valid_outport_east_12),
    .buffer_on_out_east(buffer_on_out_east_12),
    .flit_outport_south(flit_outport_south_12),
    .valid_outport_south(valid_outport_south_12),
    .buffer_on_out_south(buffer_on_out_south_12),
    .flit_outport_west(flit_outport_west_12),
    .valid_outport_west(valid_outport_west_12),
    .buffer_on_out_west(buffer_on_out_west_12),
    .flit_outport_local(flit_outport_local_12),
    .valid_outport_local(valid_outport_local_12),
    .buffer_on_out_local(buffer_on_out_local_12),
    .valid_downstream_ports(valid_downstream_ports_12)
    );




    router #(
    	.BUFFER_SIZE_ROUTER(buffer_depth),
    	.X_CURRENT(3'b001),
    	.Y_CURRENT(3'b011)
    )
    router_13 (
    .clk(clk),
	.rst(rst),
    .flit_inport_north(flit_inport_north_13),
    .valid_in_north(valid_in_north_13),
    .buffer_on_in_north(buffer_on_in_north_13),
    .flit_inport_east(flit_outport_west_23),
    .valid_in_east(valid_outport_west_23),
    .buffer_on_in_east(buffer_on_out_west_23),
    .flit_inport_south(flit_outport_north_12),
    .valid_in_south(valid_outport_north_12),
    .buffer_on_in_south(buffer_on_out_north_12),
    .flit_inport_west(flit_outport_east_03),
    .valid_in_west(valid_outport_east_03),
    .buffer_on_in_west(buffer_on_out_east_03),
    .flit_inport_local(flit_inport_local_13),
    .valid_in_local(valid_in_local_13),
    .buffer_on_in_local(buffer_on_in_local_13),
    .flit_outport_north(flit_outport_north_13),
    .valid_outport_north(valid_outport_north_13),
    .buffer_on_out_north(buffer_on_out_north_13),
    .flit_outport_east(flit_outport_east_13),
    .valid_outport_east(valid_outport_east_13),
    .buffer_on_out_east(buffer_on_out_east_13),
    .flit_outport_south(flit_outport_south_13),
    .valid_outport_south(valid_outport_south_13),
    .buffer_on_out_south(buffer_on_out_south_13),
    .flit_outport_west(flit_outport_west_13),
    .valid_outport_west(valid_outport_west_13),
    .buffer_on_out_west(buffer_on_out_west_13),
    .flit_outport_local(flit_outport_local_13),
    .valid_outport_local(valid_outport_local_13),
    .buffer_on_out_local(buffer_on_out_local_13),
    .valid_downstream_ports(valid_downstream_ports_13)
    );




    router #(
        .BUFFER_SIZE_ROUTER(buffer_depth),
        .X_CURRENT(3'b010),
        .Y_CURRENT(3'b000)
    )
    router_20 (
    .clk(clk),
    .rst(rst),
    .flit_inport_north(flit_outport_south_21),
    .valid_in_north(valid_outport_south_21),
    .buffer_on_in_north(buffer_on_out_south_21),
    .flit_inport_east(flit_outport_west_30),
    .valid_in_east(valid_outport_west_30),
    .buffer_on_in_east(buffer_on_out_west_30),
    .flit_inport_south(flit_inport_south_20),
    .valid_in_south(valid_in_south_20),
    .buffer_on_in_south(buffer_on_in_south_20),
    .flit_inport_west(flit_outport_east_10),
    .valid_in_west(valid_outport_east_10),
    .buffer_on_in_west(buffer_on_out_east_10),
    .flit_inport_local(flit_inport_local_20),
    .valid_in_local(valid_in_local_20),
    .buffer_on_in_local(buffer_on_in_local_20),
    .flit_outport_north(flit_outport_north_20),
    .valid_outport_north(valid_outport_north_20),
    .buffer_on_out_north(buffer_on_out_north_20),
    .flit_outport_east(flit_outport_east_20),
    .valid_outport_east(valid_outport_east_20),
    .buffer_on_out_east(buffer_on_out_east_20),
    .flit_outport_south(flit_outport_south_20),
    .valid_outport_south(valid_outport_south_20),
    .buffer_on_out_south(buffer_on_out_south_20),
    .flit_outport_west(flit_outport_west_20),
    .valid_outport_west(valid_outport_west_20),
    .buffer_on_out_west(buffer_on_out_west_20),
    .flit_outport_local(flit_outport_local_20),
    .valid_outport_local(valid_outport_local_20),
    .buffer_on_out_local(buffer_on_out_local_20),
    .valid_downstream_ports(valid_downstream_ports_20)
    );



    router #(
        .BUFFER_SIZE_ROUTER(buffer_depth),
        .X_CURRENT(3'b010),
        .Y_CURRENT(3'b001)
    )
    router_21 (
    .clk(clk),
    .rst(rst),
    .flit_inport_north(flit_outport_south_22),
    .valid_in_north(valid_outport_south_22),
    .buffer_on_in_north(buffer_on_out_south_22),
    .flit_inport_east(flit_outport_west_31),
    .valid_in_east(valid_outport_west_31),
    .buffer_on_in_east(buffer_on_out_west_31),
    .flit_inport_south(flit_outport_north_20),
    .valid_in_south(valid_outport_north_20),
    .buffer_on_in_south(buffer_on_out_north_20),
    .flit_inport_west(flit_outport_east_11),
    .valid_in_west(valid_outport_east_11),
    .buffer_on_in_west(buffer_on_out_east_11),
    .flit_inport_local(flit_inport_local_21),
    .valid_in_local(valid_in_local_21),
    .buffer_on_in_local(buffer_on_in_local_21),
    .flit_outport_north(flit_outport_north_21),
    .valid_outport_north(valid_outport_north_21),
    .buffer_on_out_north(buffer_on_out_north_21),
    .flit_outport_east(flit_outport_east_21),
    .valid_outport_east(valid_outport_east_21),
    .buffer_on_out_east(buffer_on_out_east_21),
    .flit_outport_south(flit_outport_south_21),
    .valid_outport_south(valid_outport_south_21),
    .buffer_on_out_south(buffer_on_out_south_21),
    .flit_outport_west(flit_outport_west_21),
    .valid_outport_west(valid_outport_west_21),
    .buffer_on_out_west(buffer_on_out_west_21),
    .flit_outport_local(flit_outport_local_21),
    .valid_outport_local(valid_outport_local_21),
    .buffer_on_out_local(buffer_on_out_local_21),
    .valid_downstream_ports(valid_downstream_ports_21)
    );


    router #(
        .BUFFER_SIZE_ROUTER(buffer_depth),
        .X_CURRENT(3'b010),
        .Y_CURRENT(3'b010)
    )
    router_22 (
    .clk(clk),
    .rst(rst),
    .flit_inport_north(flit_outport_south_23),
    .valid_in_north(valid_outport_south_23),
    .buffer_on_in_north(buffer_on_out_south_23),
    .flit_inport_east(flit_outport_west_32),
    .valid_in_east(valid_outport_west_32),
    .buffer_on_in_east(buffer_on_out_west_32),
    .flit_inport_south(flit_outport_north_21),
    .valid_in_south(valid_outport_north_21),
    .buffer_on_in_south(buffer_on_out_north_21),
    .flit_inport_west(flit_outport_east_12),
    .valid_in_west(valid_outport_east_12),
    .buffer_on_in_west(buffer_on_out_east_12),
    .flit_inport_local(flit_inport_local_22),
    .valid_in_local(valid_in_local_22),
    .buffer_on_in_local(buffer_on_in_local_22),
    .flit_outport_north(flit_outport_north_22),
    .valid_outport_north(valid_outport_north_22),
    .buffer_on_out_north(buffer_on_out_north_22),
    .flit_outport_east(flit_outport_east_22),
    .valid_outport_east(valid_outport_east_22),
    .buffer_on_out_east(buffer_on_out_east_22),
    .flit_outport_south(flit_outport_south_22),
    .valid_outport_south(valid_outport_south_22),
    .buffer_on_out_south(buffer_on_out_south_22),
    .flit_outport_west(flit_outport_west_22),
    .valid_outport_west(valid_outport_west_22),
    .buffer_on_out_west(buffer_on_out_west_22),
    .flit_outport_local(flit_outport_local_22),
    .valid_outport_local(valid_outport_local_22),
    .buffer_on_out_local(buffer_on_out_local_22),
    .valid_downstream_ports(valid_downstream_ports_22)
    );



    router #(
        .BUFFER_SIZE_ROUTER(buffer_depth),
        .X_CURRENT(3'b010),
        .Y_CURRENT(3'b011)
    )
    router_23 (
    .clk(clk),
    .rst(rst),
    .flit_inport_north(flit_inport_north_23),
    .valid_in_north(valid_in_north_23),
    .buffer_on_in_north(buffer_on_in_north_23),
    .flit_inport_east(flit_outport_west_33),
    .valid_in_east(valid_outport_west_33),
    .buffer_on_in_east(buffer_on_out_west_33),
    .flit_inport_south(flit_outport_north_22),
    .valid_in_south(valid_outport_north_22),
    .buffer_on_in_south(buffer_on_out_north_22),
    .flit_inport_west(flit_outport_east_13),
    .valid_in_west(valid_outport_east_13),
    .buffer_on_in_west(buffer_on_out_east_13),
    .flit_inport_local(flit_inport_local_23),
    .valid_in_local(valid_in_local_23),
    .buffer_on_in_local(buffer_on_in_local_23),
    .flit_outport_north(flit_outport_north_23),
    .valid_outport_north(valid_outport_north_23),
    .buffer_on_out_north(buffer_on_out_north_23),
    .flit_outport_east(flit_outport_east_23),
    .valid_outport_east(valid_outport_east_23),
    .buffer_on_out_east(buffer_on_out_east_23),
    .flit_outport_south(flit_outport_south_23),
    .valid_outport_south(valid_outport_south_23),
    .buffer_on_out_south(buffer_on_out_south_23),
    .flit_outport_west(flit_outport_west_23),
    .valid_outport_west(valid_outport_west_23),
    .buffer_on_out_west(buffer_on_out_west_23),
    .flit_outport_local(flit_outport_local_23),
    .valid_outport_local(valid_outport_local_23),
    .buffer_on_out_local(buffer_on_out_local_23),
    .valid_downstream_ports(valid_downstream_ports_23)
    );



    router #(
        .BUFFER_SIZE_ROUTER(buffer_depth),
        .X_CURRENT(3'b011),
        .Y_CURRENT(3'b000)
    )
    router_30 (
    .clk(clk),
    .rst(rst),
    .flit_inport_north(flit_outport_south_31),
    .valid_in_north(valid_outport_south_31),
    .buffer_on_in_north(buffer_on_out_south_31),
    .flit_inport_east(flit_inport_east_30),
    .valid_in_east(valid_in_east_30),
    .buffer_on_in_east(buffer_on_in_east_30),
    .flit_inport_south(flit_inport_south_30),
    .valid_in_south(valid_in_south_30),
    .buffer_on_in_south(buffer_on_in_south_30),
    .flit_inport_west(flit_outport_east_20),
    .valid_in_west(valid_outport_east_20),
    .buffer_on_in_west(buffer_on_out_east_20),
    .flit_inport_local(flit_inport_local_30),
    .valid_in_local(valid_in_local_30),
    .buffer_on_in_local(buffer_on_in_local_30),
    .flit_outport_north(flit_outport_north_30),
    .valid_outport_north(valid_outport_north_30),
    .buffer_on_out_north(buffer_on_out_north_30),
    .flit_outport_east(flit_outport_east_30),
    .valid_outport_east(valid_outport_east_30),
    .buffer_on_out_east(buffer_on_out_east_30),
    .flit_outport_south(flit_outport_south_30),
    .valid_outport_south(valid_outport_south_30),
    .buffer_on_out_south(buffer_on_out_south_30),
    .flit_outport_west(flit_outport_west_30),
    .valid_outport_west(valid_outport_west_30),
    .buffer_on_out_west(buffer_on_out_west_30),
    .flit_outport_local(flit_outport_local_30),
    .valid_outport_local(valid_outport_local_30),
    .buffer_on_out_local(buffer_on_out_local_30),
    .valid_downstream_ports(valid_downstream_ports_30)
    );



    router #(
        .BUFFER_SIZE_ROUTER(buffer_depth),
        .X_CURRENT(3'b011),
        .Y_CURRENT(3'b001)
    )
    router_31 (
    .clk(clk),
    .rst(rst),
    .flit_inport_north(flit_outport_south_32),
    .valid_in_north(valid_outport_south_32),
    .buffer_on_in_north(buffer_on_out_south_32),
    .flit_inport_east(flit_inport_east_31),
    .valid_in_east(valid_in_east_31),
    .buffer_on_in_east(buffer_on_in_east_31),
    .flit_inport_south(flit_outport_north_30),
    .valid_in_south(valid_outport_north_30),
    .buffer_on_in_south(buffer_on_out_north_30),
    .flit_inport_west(flit_outport_east_21),
    .valid_in_west(valid_outport_east_21),
    .buffer_on_in_west(buffer_on_out_east_21),
    .flit_inport_local(flit_inport_local_31),
    .valid_in_local(valid_in_local_31),
    .buffer_on_in_local(buffer_on_in_local_31),
    .flit_outport_north(flit_outport_north_31),
    .valid_outport_north(valid_outport_north_31),
    .buffer_on_out_north(buffer_on_out_north_31),
    .flit_outport_east(flit_outport_east_31),
    .valid_outport_east(valid_outport_east_31),
    .buffer_on_out_east(buffer_on_out_east_31),
    .flit_outport_south(flit_outport_south_31),
    .valid_outport_south(valid_outport_south_31),
    .buffer_on_out_south(buffer_on_out_south_31),
    .flit_outport_west(flit_outport_west_31),
    .valid_outport_west(valid_outport_west_31),
    .buffer_on_out_west(buffer_on_out_west_31),
    .flit_outport_local(flit_outport_local_31),
    .valid_outport_local(valid_outport_local_31),
    .buffer_on_out_local(buffer_on_out_local_31),
    .valid_downstream_ports(valid_downstream_ports_31)
    );




    router #(
        .BUFFER_SIZE_ROUTER(buffer_depth),
        .X_CURRENT(3'b011),
        .Y_CURRENT(3'b010)
    )
    router_32 (
    .clk(clk),
    .rst(rst),
    .flit_inport_north(flit_outport_south_33),
    .valid_in_north(valid_outport_south_33),
    .buffer_on_in_north(buffer_on_out_south_33),
    .flit_inport_east(flit_inport_east_32),
    .valid_in_east(valid_in_east_32),
    .buffer_on_in_east(buffer_on_in_east_32),
    .flit_inport_south(flit_outport_north_31),
    .valid_in_south(valid_outport_north_31),
    .buffer_on_in_south(buffer_on_out_north_31),
    .flit_inport_west(flit_outport_east_22),
    .valid_in_west(valid_outport_east_22),
    .buffer_on_in_west(buffer_on_out_east_22),
    .flit_inport_local(flit_inport_local_32),
    .valid_in_local(valid_in_local_32),
    .buffer_on_in_local(buffer_on_in_local_32),
    .flit_outport_north(flit_outport_north_32),
    .valid_outport_north(valid_outport_north_32),
    .buffer_on_out_north(buffer_on_out_north_32),
    .flit_outport_east(flit_outport_east_32),
    .valid_outport_east(valid_outport_east_32),
    .buffer_on_out_east(buffer_on_out_east_32),
    .flit_outport_south(flit_outport_south_32),
    .valid_outport_south(valid_outport_south_32),
    .buffer_on_out_south(buffer_on_out_south_32),
    .flit_outport_west(flit_outport_west_32),
    .valid_outport_west(valid_outport_west_32),
    .buffer_on_out_west(buffer_on_out_west_32),
    .flit_outport_local(flit_outport_local_32),
    .valid_outport_local(valid_outport_local_32),
    .buffer_on_out_local(buffer_on_out_local_32),
    .valid_downstream_ports(valid_downstream_ports_32)
    );



    router #(
        .BUFFER_SIZE_ROUTER(buffer_depth),
        .X_CURRENT(3'b011),
        .Y_CURRENT(3'b011)
    )
    router_33 (
    .clk(clk),
    .rst(rst),
    .flit_inport_north(flit_inport_north_33),
    .valid_in_north(valid_in_north_33),
    .buffer_on_in_north(buffer_on_in_north_33),
    .flit_inport_east(flit_inport_east_33),
    .valid_in_east(valid_in_east_33),
    .buffer_on_in_east(buffer_on_in_east_33),
    .flit_inport_south(flit_outport_north_32),
    .valid_in_south(valid_outport_north_32),
    .buffer_on_in_south(buffer_on_out_north_32),
    .flit_inport_west(flit_outport_east_23),
    .valid_in_west(valid_outport_east_23),
    .buffer_on_in_west(buffer_on_out_east_23),
    .flit_inport_local(flit_inport_local_33),
    .valid_in_local(valid_in_local_33),
    .buffer_on_in_local(buffer_on_in_local_33),
    .flit_outport_north(flit_outport_north_33),
    .valid_outport_north(valid_outport_north_33),
    .buffer_on_out_north(buffer_on_out_north_33),
    .flit_outport_east(flit_outport_east_33),
    .valid_outport_east(valid_outport_east_33),
    .buffer_on_out_east(buffer_on_out_east_33),
    .flit_outport_south(flit_outport_south_33),
    .valid_outport_south(valid_outport_south_33),
    .buffer_on_out_south(buffer_on_out_south_33),
    .flit_outport_west(flit_outport_west_33),
    .valid_outport_west(valid_outport_west_33),
    .buffer_on_out_west(buffer_on_out_west_33),
    .flit_outport_local(flit_outport_local_33),
    .valid_outport_local(valid_outport_local_33),
    .buffer_on_out_local(buffer_on_out_local_33),
    .valid_downstream_ports(valid_downstream_ports_33)
    );

    always #5 clk = ~clk;

    initial
    begin
        //dump_output();
	    initialize();
	   	repeat(num_cycles)
	    begin
	       	inject_flits();
	        @(posedge clk);
	   	end
	    count_scores();
        

        $finish;
    end

    task initialize();
        clk     <= 0;
        rst     = 1;

         score_00=0;
		 score_01=0;
		 score_02=0;
		 score_03=0;
		 score_10=0;
		 score_11=0;
		 score_12=0;
		 score_13=0;
		 score_20=0;
		 score_21=0;
		 score_22=0;
		 score_23=0;
		 score_30=0;
		 score_31=0;
		 score_32=0;
		 score_33=0;
		 fin_score=0;

        flit_inport_local_00=0;
        valid_in_local_00=0;
        buffer_on_in_local_00=1;

        flit_inport_local_01=0;
        valid_in_local_01=0;
        buffer_on_in_local_01=1;

        flit_inport_local_02=0;
        valid_in_local_02=0;
        buffer_on_in_local_02=1;

        flit_inport_local_03=0;
        valid_in_local_03=0;
        buffer_on_in_local_03=1;

        flit_inport_local_10=0;
        valid_in_local_10=0;
        buffer_on_in_local_10=1;

        flit_inport_local_11=0;
        valid_in_local_11=0;
        buffer_on_in_local_11=1;

        flit_inport_local_12=0;
        valid_in_local_12=0;
        buffer_on_in_local_12=1;

        flit_inport_local_13=0;
        valid_in_local_13=0;
        buffer_on_in_local_13=1;

        flit_inport_local_20=0;
        valid_in_local_20=0;
        buffer_on_in_local_20=1;

        flit_inport_local_21=0;
        valid_in_local_21=0;
        buffer_on_in_local_21=1;

        flit_inport_local_22=0;
        valid_in_local_22=0;
        buffer_on_in_local_22=1;

        flit_inport_local_23=0;
        valid_in_local_23=0;
        buffer_on_in_local_23=1;

        flit_inport_local_30=0;
        valid_in_local_30=0;
        buffer_on_in_local_30=1;

        flit_inport_local_31=0;
        valid_in_local_31=0;
        buffer_on_in_local_31=1;

        flit_inport_local_32=0;
        valid_in_local_32=0;
        buffer_on_in_local_32=1;

        flit_inport_local_33=0;
        valid_in_local_33=0;
        buffer_on_in_local_33=1;

        repeat(2) @(posedge clk);
            rst <= 0;
    endtask


    task create_flit();
        flit_written[63:62] = $urandom_range(0,3);
        flit_written[61:60] = $urandom_range(0,3);
        flit_written[59:0] = $urandom_range(0,1000000);
    endtask

    task inject_flits();
    		rnd = $urandom_range(0,99);
	        if (rnd < inj_rate)
	        begin
	        	create_flit();
	        	flit_inport_local_00=flit_written;
	        	valid_in_local_00=1;
	        end
	        else begin
	        	valid_in_local_00=0;
	        end

	        rnd = $urandom_range(0,99);
	        if (rnd < inj_rate)
	        begin
	        	create_flit();
	        	flit_inport_local_01=flit_written;
	        	valid_in_local_01=1;
	        	
	        end
	        else begin
	        	valid_in_local_01=0;
	        end

	        rnd = $urandom_range(0,99);
	        if (rnd < inj_rate)
	        begin
	        	create_flit();
	        	flit_inport_local_02=flit_written;
	        	valid_in_local_02=1;
	        	
	        end
	        else begin
	        	valid_in_local_02=0;
	        end

	        rnd = $urandom_range(0,99);
	        if (rnd < inj_rate)
	        begin
	        	create_flit();
	        	flit_inport_local_03=flit_written;
	        	valid_in_local_03=1;
	        	
	        end
	        else begin
	        	valid_in_local_03=0;
	        end

	        rnd = $urandom_range(0,99);
	        if (rnd < inj_rate)
	        begin
	        	create_flit();
	        	flit_inport_local_10=flit_written;
	        	valid_in_local_10=1;
	        	
	        end
	        else begin
	        	valid_in_local_10=0;
	        end

	        rnd = $urandom_range(0,99);
	        if (rnd < inj_rate)
	        begin
	        	create_flit();
	        	flit_inport_local_11=flit_written;
	        	valid_in_local_11=1;
	        	
	        end
	        else begin
	        	valid_in_local_11=0;
	        end

	        rnd = $urandom_range(0,99);
	        if (rnd < inj_rate)
	        begin
	        	create_flit();
	        	flit_inport_local_12=flit_written;
	        	valid_in_local_12=1;
	        	
	        end
	        else begin
	        	valid_in_local_12=0;
	        end

	        rnd = $urandom_range(0,99);
	        if (rnd < inj_rate)
	        begin
	        	create_flit();
	        	flit_inport_local_13=flit_written;
	        	valid_in_local_13=1;
	        	
	        end
	        else begin
	        	valid_in_local_13=0;
	        end

	        rnd = $urandom_range(0,99);
	        if (rnd < inj_rate)
	        begin
	        	create_flit();
	        	flit_inport_local_20=flit_written;
	        	valid_in_local_20=1;
	        	
	        end
	        else begin
	        	valid_in_local_20=0;
	        end

	        rnd = $urandom_range(0,99);
	        if (rnd < inj_rate)
	        begin
	        	create_flit();
	        	flit_inport_local_21=flit_written;
	        	valid_in_local_21=1;
	        	
	        end
	        else begin
	        	valid_in_local_21=0;
	        end

	        rnd = $urandom_range(0,99);
	        if (rnd < inj_rate)
	        begin
	        	create_flit();
	        	flit_inport_local_22=flit_written;
	        	valid_in_local_22=1;
	        	
	        end
	        else begin
	        	valid_in_local_22=0;
	        end

	        rnd = $urandom_range(0,99);
	        if (rnd < inj_rate)
	        begin
	        	create_flit();
	        	flit_inport_local_23=flit_written;
	        	valid_in_local_23=1;
	        	
	        end
	        else begin
	        	valid_in_local_23=0;
	        end

	        rnd = $urandom_range(0,99);
	        if (rnd < inj_rate)
	        begin
	        	create_flit();
	        	flit_inport_local_30=flit_written;
	        	valid_in_local_30=1;
	        	
	        end
	        else begin
	        	valid_in_local_30=0;
	        end

	        rnd = $urandom_range(0,99);
	        if (rnd < inj_rate)
	        begin
	        	create_flit();
	        	flit_inport_local_31=flit_written;
	        	valid_in_local_31=1;
	        	
	        end
	        else begin
	        	valid_in_local_31=0;
	        end

	        rnd = $urandom_range(0,99);
	        if (rnd < inj_rate)
	        begin
	        	create_flit();
	        	flit_inport_local_32=flit_written;
	        	valid_in_local_32=1;
	        	
	        end
	        else begin
	        	valid_in_local_32=0;
	        end

	        rnd = $urandom_range(0,99);
	        if (rnd < inj_rate)
	        begin
	        	create_flit();
	        	flit_inport_local_33=flit_written;
	        	valid_in_local_33=1;
	        	
	        end
	        else begin
	        	valid_in_local_33=0;
	        end

	    if (valid_outport_local_00 == 1)
	    	score_00 = score_00 + 1;
	    if (valid_outport_local_01 == 1)
	    	score_01 = score_01 + 1;
	    if (valid_outport_local_02 == 1)
	    	score_02 = score_02 + 1;
	    if (valid_outport_local_03 == 1)
	    	score_03 = score_03 + 1;

	    if (valid_outport_local_10 == 1)
	    	score_10 = score_10 + 1;
	    if (valid_outport_local_11 == 1)
	    	score_11 = score_11 + 1;
	    if (valid_outport_local_12 == 1)
	    	score_12 = score_12 + 1;
	    if (valid_outport_local_13 == 1)
	    	score_13 = score_13 + 1;

	    if (valid_outport_local_20 == 1)
	    	score_20 = score_20 + 1;
	    if (valid_outport_local_21 == 1)
	    	score_21 = score_21 + 1;
	    if (valid_outport_local_22 == 1)
	    	score_22 = score_22 + 1;
	    if (valid_outport_local_23 == 1)
	    	score_23 = score_23 + 1;

	    if (valid_outport_local_30 == 1)
	    	score_30 = score_30 + 1;
	    if (valid_outport_local_31 == 1)
	    	score_31 = score_31 + 1;
	    if (valid_outport_local_32 == 1)
	    	score_32 = score_32 + 1;
	    if (valid_outport_local_33 == 1)
	    	score_33 = score_33 + 1; 

    endtask

    task check_buffer_status();
    	        //left most column
        if (!buffer_on_out_north_00)
        	$display("buffer_on_out_north_00 off");
        if (!buffer_on_out_east_00)
        	$display("buffer_on_out_east_00 off");

        if (!buffer_on_out_north_01)
        	$display("buffer_on_out_north_01 off");
        if (!buffer_on_out_east_01)
        	$display("buffer_on_out_east_01 off");
        if (!buffer_on_out_south_01)
        	$display("buffer_on_out_south_01 off");

        if (!buffer_on_out_north_02)
        	$display("buffer_on_out_north_02 off");
        if (!buffer_on_out_east_02)
        	$display("buffer_on_out_east_02 off");
        if (!buffer_on_out_south_02)
        	$display("buffer_on_out_south_02 off");

        if (!buffer_on_out_east_03)
        	$display("buffer_on_out_east_00 off");
        if (!buffer_on_out_south_03)
        	$display("buffer_on_out_south_00 off");

        // middle left column
        if (!buffer_on_out_north_10)
        	$display("buffer_on_out_north_10 off");
        if (!buffer_on_out_east_10)
        	$display("buffer_on_out_east_10 off");
        if (!buffer_on_out_west_10)
        	$display("buffer_on_out_west_10 off");

        if (!buffer_on_out_north_11)
        	$display("buffer_on_out_north_11 off");
        if (!buffer_on_out_east_11)
        	$display("buffer_on_out_east_11 off");
        if (!buffer_on_out_south_11)
        	$display("buffer_on_out_south_11 off");
        if (!buffer_on_out_west_11)
        	$display("buffer_on_out_west_11 off");

        if (!buffer_on_out_north_12)
        	$display("buffer_on_out_north_12 off");
        if (!buffer_on_out_east_12)
        	$display("buffer_on_out_east_12 off");
        if (!buffer_on_out_south_12)
        	$display("buffer_on_out_south_12 off");
        if (!buffer_on_out_west_12)
        	$display("buffer_on_out_west_12 off");

		if (!buffer_on_out_east_13)
        	$display("buffer_on_out_east_13 off");
        if (!buffer_on_out_south_13)
        	$display("buffer_on_out_south_13 off");
        if (!buffer_on_out_west_13)
        	$display("buffer_on_out_west_13 off");

        // middle right
        if (!buffer_on_out_north_20)
        	$display("buffer_on_out_north_20 off");
        if (!buffer_on_out_east_20)
        	$display("buffer_on_out_east_20 off");
        if (!buffer_on_out_west_20)
        	$display("buffer_on_out_west_20 off");

        if (!buffer_on_out_north_21)
        	$display("buffer_on_out_north_21 off");
        if (!buffer_on_out_east_21)
        	$display("buffer_on_out_east_21 off");
        if (!buffer_on_out_south_21)
        	$display("buffer_on_out_south_21 off");
        if (!buffer_on_out_west_21)
        	$display("buffer_on_out_west_21 off");

        if (!buffer_on_out_north_22)
        	$display("buffer_on_out_north_22 off");
        if (!buffer_on_out_east_22)
        	$display("buffer_on_out_east_22 off");
        if (!buffer_on_out_south_22)
        	$display("buffer_on_out_south_22 off");
        if (!buffer_on_out_west_22)
        	$display("buffer_on_out_west_22 off");

		if (!buffer_on_out_east_23)
        	$display("buffer_on_out_east_23 off");
        if (!buffer_on_out_south_23)
        	$display("buffer_on_out_south_23 off");
        if (!buffer_on_out_west_23)
        	$display("buffer_on_out_west_23 off");

        //right column

        if (!buffer_on_out_north_30)
        	$display("buffer_on_out_north_30 off");
        if (!buffer_on_out_west_30)
        	$display("buffer_on_out_west_30 off");

        if (!buffer_on_out_north_31)
        	$display("buffer_on_out_north_31 off");
        if (!buffer_on_out_south_31)
        	$display("buffer_on_out_south_31 off");
        if (!buffer_on_out_west_31)
        	$display("buffer_on_out_west_31 off");

        if (!buffer_on_out_north_32)
        	$display("buffer_on_out_north_32 off");
        if (!buffer_on_out_south_32)
        	$display("buffer_on_out_south_32 off");
        if (!buffer_on_out_west_32)
        	$display("buffer_on_out_west_32 off");

        if (!buffer_on_out_south_33)
        	$display("buffer_on_out_north_33 off");
        if (!buffer_on_out_west_33)
        	$display("buffer_on_out_west_33 off");

    endtask

    task count_scores();
		fin_score = score_00+score_01+score_02+score_03+score_10+score_11+score_12+score_13+score_20+score_21+score_22+score_23+score_30+score_31+score_32+score_33;
        $display("total flits received is = %d",fin_score);
    endtask


    task loopit();
    	int i;
    	for (i = 2; i < 101; i = i + 2)
    	begin
    		//$display("injection rate %d",i);
	    	initialize();
	        inj_rate = i;
	        repeat(num_cycles)
	        begin
	        	inject_flits();
	        	@(posedge clk);
	        end
	        count_scores();
	    end


    endtask



endmodule