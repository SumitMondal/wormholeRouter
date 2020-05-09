//Engineer     : Sumit Mondal
//Date         : April 2020
//Name of file : simpler_router_tb.sv
//Description  : Inport Testbench

`timescale 1ns / 1ps

module simpler_router_tb #(
    parameter BUFFER_SIZE_ROUTER = 8,
    parameter X_CURRENT = 3'b000,
    parameter Y_CURRENT = 3'b000
);

    int i;
    int num_operation;

    logic clk, rst;

    logic [63:0]  flit_in;
    logic valid_flit_in;
    logic buffer_on_in_north;
    logic buffer_on_in_east;
    logic buffer_on_in_south;
    logic buffer_on_in_west;
    logic buffer_on_in_local;


    logic [63:0]  flit_out;
    logic [63:0]  flit_written;

    logic valid_outport_north;
    logic valid_outport_east;
    logic valid_outport_south;
    logic valid_outport_west;
    logic valid_outport_local;

    logic [63:0] flit_outport_north;
    logic [63:0] flit_outport_east;
    logic [63:0] flit_outport_south;
    logic [63:0] flit_outport_west;
    logic [63:0] flit_outport_local;

    logic buffer_on_out;
    logic [4:0] valid_downstream_ports;

    simpler_router #(
    	.BUFFER_SIZE_ROUTER(8),
    	.X_CURRENT(0),
    	.Y_CURRENT(0)
    )
    simpler_router(
	.clk(clk),
	.rst(rst),
    .flit_inport_north(flit_in),
    .valid_in_north(valid_flit_in),
    .buffer_on_in_north(buffer_on_in_north),
    .buffer_on_in_east(buffer_on_in_east),
    .buffer_on_in_south(buffer_on_in_south),
    .buffer_on_in_west(buffer_on_in_west),
    .buffer_on_in_local(buffer_on_in_local),
    .flit_outport_north(flit_outport_north),
    .flit_outport_east(flit_outport_east),
    .flit_outport_south(flit_outport_south),
    .flit_outport_west(flit_outport_west),
    .flit_outport_local(flit_outport_local),
    .buffer_on_out_north(buffer_on_out),
    .valid_downstream_ports(valid_downstream_ports),
    .valid_outport_north(valid_outport_north),
    .valid_outport_east(valid_outport_east),
    .valid_outport_south(valid_outport_south),
    .valid_outport_west(valid_outport_west),
    .valid_outport_local(valid_outport_local)
    );

    always #5 clk = ~clk;

    initial begin
        //dump_output();

        initialize();

        buffer_on_in_north = 1;
        buffer_on_in_east = 1;
        buffer_on_in_south = 1;
        buffer_on_in_west = 1;
        buffer_on_in_local = 1;

        create_flit();
        flit_in = flit_written;
        valid_flit_in=1;
        @(posedge clk)
        create_flit();
        flit_in = flit_written;
        @(posedge clk)
        create_flit();
        flit_in = flit_written;
        @(posedge clk)
        create_flit();
        flit_in = flit_written;
        @(posedge clk)
        create_flit();
        flit_in = flit_written;
        @(posedge clk)
        create_flit();
        flit_in = flit_written;
        @(posedge clk)
        valid_flit_in = 0;
        buffer_on_in_north = 0;
        buffer_on_in_east = 0;
        buffer_on_in_south = 0;
        buffer_on_in_west = 0;
        buffer_on_in_local = 0;
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)        
        @(posedge clk)

        $finish;
    end

    task initialize();
        clk     <= 0;
        rst     = 1;
        i = 0;
        num_operation = 0;
        repeat(2) @(posedge clk);
        rst <= 0;
    endtask

    task clear_reset();

    endtask

    task create_flit();
        flit_written[63:62] = $urandom_range(0,3);
        flit_written[61:60] = $urandom_range(0,3);
        flit_written[59:0] = $urandom_range(0,1000000);
    endtask

endmodule
