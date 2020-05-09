//Engineer     : Sumit Mondal
//Date         : April 2020
//Name of file : simpler_router.sv
//Description  : This file was created to verify the inport module.

module simpler_router #(
    parameter BUFFER_SIZE_ROUTER = 8,
    parameter X_CURRENT = 3'b000,
    parameter Y_CURRENT = 3'b000
)(
	input clk,
	input rst,
    input [63:0] flit_inport_north,
    input valid_in_north,
    input buffer_on_in_north,
    input buffer_on_in_east,
    input buffer_on_in_south,
    input buffer_on_in_west,
    input buffer_on_in_local,
    output [63:0] flit_outport_north,
    output [63:0] flit_outport_east,
    output [63:0] flit_outport_south,
    output [63:0] flit_outport_west,
    output [63:0] flit_outport_local,
    output valid_outport_north,
    output valid_outport_east,
    output valid_outport_south,
    output valid_outport_west,
    output valid_outport_local,
    output buffer_on_out_north,
    output logic [4:0] valid_downstream_ports
	);


    logic [63:0] flit_out_north;


    logic sw_req_north;
    logic sw_req_east = 0;
    logic sw_req_south = 0;
    logic sw_req_west = 0;
    logic sw_req_local = 0;

	logic error_north;

	logic [4:0] outport_north;
    logic [4:0] outport_east = 0;
    logic [4:0] outport_south = 0;
    logic [4:0] outport_west = 0;
    logic [4:0] outport_local = 0;

	logic [4:0] sa_grant;

    logic valid_out_north;


	round_robin_arbiter switch_allocator(
	.req_00001(sw_req_north),
	.req_00010(sw_req_east),
	.req_00100(sw_req_south),
	.req_01000(sw_req_west),
    .req_10000(sw_req_local),
	.grant(sa_grant),
	.clk(clk),
	.rst(rst)
    );

    inport_v3 #(
        .PORT_DIR(4'b0001),
        .X_CURRENT_INPORT(X_CURRENT),
        .Y_CURRENT_INPORT(Y_CURRENT),
        .BUFFER_SIZE_INPORT(BUFFER_SIZE_ROUTER)
    )
    inport_north(
    .flit_in(flit_inport_north),
    .rst(rst),
    .clk(clk),
    .valid_downstream_ports(valid_downstream_ports),
    .valid_flit_in(valid_in_north),
    .sa_grant(sa_grant),
    .flit_o(flit_out_north),
    .buffer_on(buffer_on_out_north),
    .sa_request(sw_req_north),
    .outport(outport_north),
    .valid_flit_out(valid_out_north)
    );

    crossbar crossbar(
    .flit_in_north(flit_out_north),
    .flit_in_east(64'b0),
    .flit_in_south(64'b0),
    .flit_in_west(64'b0),
    .flit_in_local(64'b0),
    .sa_grant(sa_grant),
    .outport_north(outport_north),
    .outport_east(outport_east),
    .outport_south(outport_south),
    .outport_west(outport_west),
    .outport_local(outport_local),
    .valid_in_north(valid_out_north),
    .valid_in_east(1'b0),
    .valid_in_south(1'b0),
    .valid_in_west(1'b0),
    .valid_in_local(1'b0),
    .flit_out_north(flit_outport_north),
    .flit_out_east(flit_outport_east),
    .flit_out_south(flit_outport_south),
    .flit_out_west(flit_outport_west),
    .flit_out_local(flit_outport_local),
    .valid_outport_north(valid_outport_north),
    .valid_outport_east(valid_outport_east),
    .valid_outport_south(valid_outport_south),
    .valid_outport_west(valid_outport_west),
    .valid_outport_local(valid_outport_local)
    );

    // Propagating on/off flow control signals to all input ports ..
    always_comb
    begin
        valid_downstream_ports = {buffer_on_in_local,buffer_on_in_west,buffer_on_in_south,buffer_on_in_east,buffer_on_in_north};
    end



endmodule




