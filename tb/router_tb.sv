//Engineer     : Sumit Mondal
//Date         : April 2020
//Name of file : router_tb.sv
//Description  : Router Testbench

`timescale 1ns / 1ps

module router_tb #(
    parameter BUFFER_SIZE_ROUTER = 8,
    parameter X_CURRENT = 3'b001,
    parameter Y_CURRENT = 3'b001
);

	logic clk;
	logic rst;
    logic [63:0] flit_inport_north;
    logic valid_in_north;
    logic buffer_on_in_north;
    logic [63:0] flit_inport_east;
    logic valid_in_east;
    logic buffer_on_in_east;
    logic [63:0] flit_inport_south;
    logic valid_in_south;
    logic buffer_on_in_south;
    logic [63:0] flit_inport_west;
    logic valid_in_west;
    logic buffer_on_in_west;
    logic [63:0] flit_inport_local;
    logic valid_in_local;
    logic buffer_on_in_local;
    logic [63:0] flit_outport_north;
    logic valid_outport_north;
    logic buffer_on_out_north;
    logic [63:0] flit_outport_east;
    logic valid_outport_east;
    logic buffer_on_out_east;
    logic [63:0] flit_outport_south;
    logic valid_outport_south;
    logic buffer_on_out_south;
    logic [63:0] flit_outport_west;
    logic valid_outport_west;
    logic buffer_on_out_west;
    logic [63:0] flit_outport_local;
    logic valid_outport_local;
    logic buffer_on_out_local;
    logic [4:0] valid_downstream_ports;

    logic [63:0] flit_written;

    router #(
    	.BUFFER_SIZE_ROUTER(8),
    	.X_CURRENT(3'b001),
    	.Y_CURRENT(3'b001)
    )
    router_11 (
    .clk(clk),
	.rst(rst),
    .flit_inport_north(flit_inport_north),
    .valid_in_north(valid_in_north),
    .buffer_on_in_north(buffer_on_in_north),
    .flit_inport_east(flit_inport_east),
    .valid_in_east(valid_in_east),
    .buffer_on_in_east(buffer_on_in_east),
    .flit_inport_south(flit_inport_south),
    .valid_in_south(valid_in_south),
    .buffer_on_in_south(buffer_on_in_south),
    .flit_inport_west(flit_inport_west),
    .valid_in_west(valid_in_west),
    .buffer_on_in_west(buffer_on_in_west),
    .flit_inport_local(flit_inport_local),
    .valid_in_local(valid_in_local),
    .buffer_on_in_local(buffer_on_in_local),
    .flit_outport_north(flit_outport_north),
    .valid_outport_north(valid_outport_north),
    .buffer_on_out_north(buffer_on_out_north),
    .flit_outport_east(flit_outport_east),
    .valid_outport_east(valid_outport_east),
    .buffer_on_out_east(buffer_on_out_east),
    .flit_outport_south(flit_outport_south),
    .valid_outport_south(valid_outport_south),
    .buffer_on_out_south(buffer_on_out_south),
    .flit_outport_west(flit_outport_west),
    .valid_outport_west(valid_outport_west),
    .buffer_on_out_west(buffer_on_out_west),
    .flit_outport_local(flit_outport_local),
    .valid_outport_local(valid_outport_local),
    .buffer_on_out_local(buffer_on_out_local),
    .valid_downstream_ports(valid_downstream_ports)
    );

        always #5 clk = ~clk;

    initial begin

        initialize();

        //create_flit();
        flit_inport_north = {2'b01,2'b01,60'b0};
        valid_in_north=1;
        //create_flit();
        flit_inport_east = {2'b00,2'b01,60'b0};
        valid_in_east=1;
        //create_flit();
        flit_inport_south = {2'b01,2'b10,60'b0};
        valid_in_south=1;
        //create_flit();
        flit_inport_west = {2'b10,2'b01,60'b0};
        valid_in_west=1;


        @(posedge clk)
        create_flit();
        flit_inport_north = flit_written;
        valid_in_north=1;
        create_flit();
        flit_inport_east = flit_written;
        valid_in_east=1;
        create_flit();
        flit_inport_south = flit_written;
        valid_in_south=1;
        create_flit();
        flit_inport_west = flit_written;
        valid_in_west=1;
        create_flit();
        flit_inport_local = flit_written;
        valid_in_local=1;
        @(posedge clk)
        create_flit();
        flit_inport_north = flit_written;
        valid_in_north=1;
        create_flit();
        flit_inport_east = flit_written;
        valid_in_east=1;
        create_flit();
        flit_inport_south = flit_written;
        valid_in_south=1;
        create_flit();
        flit_inport_west = flit_written;
        valid_in_west=1;
        create_flit();
        flit_inport_local = flit_written;
        valid_in_local=1;
        @(posedge clk)
        create_flit();
        flit_inport_north = flit_written;
        valid_in_north=1;
        create_flit();
        flit_inport_east = flit_written;
        valid_in_east=1;
        create_flit();
        flit_inport_south = flit_written;
        valid_in_south=1;
        create_flit();
        flit_inport_west = flit_written;
        valid_in_west=1;
        create_flit();
        flit_inport_local = flit_written;
        valid_in_local=1;
        @(posedge clk)
        valid_in_east = 0;
        valid_in_north = 0;
        valid_in_south = 0;
        valid_in_west = 0;



        #100 $finish;
    end

    task initialize();
        clk     <= 0;
        rst     = 1;

        flit_inport_north =0;
        valid_in_north=0;
        flit_inport_east =0;
        valid_in_east=0;
        flit_inport_south =0;
        valid_in_south=0;
        flit_inport_west =0;
        valid_in_west=0;
        flit_inport_local =0;
        valid_in_local=0;
        buffer_on_in_north = 1;
        buffer_on_in_east = 1;
        buffer_on_in_south = 1;
        buffer_on_in_west = 1;
        buffer_on_in_local = 1;

        repeat(2) @(posedge clk);
            rst <= 0;
    endtask


    task create_flit();
        flit_written[63:62] = $urandom_range(0,3);
        flit_written[61:60] = $urandom_range(0,3);
        flit_written[59:0] = $urandom_range(0,1000000);
    endtask

endmodule