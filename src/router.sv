//Engineer     : Sumit Mondal
//Date         : April 2020
//Name of file : router.sv
//Description  : Router, instantiates 5 input ports, xbar, & switch allocator. Generates valid_downstream ports.

module router #(
    parameter BUFFER_SIZE_ROUTER = 8,
    parameter X_CURRENT = 3'b000,
    parameter Y_CURRENT = 3'b000
)(
	input clk,
	input rst,
    input [63:0] flit_inport_north,
    input valid_in_north,
    input buffer_on_in_north,
    input [63:0] flit_inport_east,
    input valid_in_east,
    input buffer_on_in_east,
    input [63:0] flit_inport_south,
    input valid_in_south,
    input buffer_on_in_south,
    input [63:0] flit_inport_west,
    input valid_in_west,
    input buffer_on_in_west,
    input [63:0] flit_inport_local,
    input valid_in_local,
    input buffer_on_in_local,
    output [63:0] flit_outport_north,
    output valid_outport_north,
    output buffer_on_out_north,
    output [63:0] flit_outport_east,
    output valid_outport_east,
    output buffer_on_out_east,
    output [63:0] flit_outport_south,
    output valid_outport_south,
    output buffer_on_out_south,
    output [63:0] flit_outport_west,
    output valid_outport_west,
    output buffer_on_out_west,
    output [63:0] flit_outport_local,
    output valid_outport_local,
    output buffer_on_out_local,
    output logic [4:0] valid_downstream_ports
	);
    
    logic sw_req_north;
    logic sw_req_east;
    logic sw_req_south;
    logic sw_req_west;
    logic sw_req_local;

    logic [63:0] flit_out_north;
    logic [63:0] flit_out_east;
    logic [63:0] flit_out_south;
    logic [63:0] flit_out_west;
    logic [63:0] flit_out_local;

    logic [4:0] outport_north;
    logic [4:0] outport_east;
    logic [4:0] outport_south;
    logic [4:0] outport_west;
    logic [4:0] outport_local;

    logic valid_out_north;
    logic valid_out_east;
    logic valid_out_south;
    logic valid_out_west;
    logic valid_out_local;

    logic [4:0] sa_grant;

    inport_v3 #(
        .PORT_DIR(5'b00001),
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

    inport_v3 #(
        .PORT_DIR(5'b00010 ),
        .X_CURRENT_INPORT(X_CURRENT),
        .Y_CURRENT_INPORT(Y_CURRENT),
        .BUFFER_SIZE_INPORT(BUFFER_SIZE_ROUTER)
    )
    inport_east(
    .flit_in(flit_inport_east),
    .rst(rst),
    .clk(clk),
    .valid_downstream_ports(valid_downstream_ports),
    .valid_flit_in(valid_in_east),
    .sa_grant(sa_grant),
    .flit_o(flit_out_east),
    .buffer_on(buffer_on_out_east),
    .sa_request(sw_req_east),
    .outport(outport_east),
    .valid_flit_out(valid_out_east)
    );

    inport_v3 #(
        .PORT_DIR(5'b00100 ),
        .X_CURRENT_INPORT(X_CURRENT),
        .Y_CURRENT_INPORT(Y_CURRENT),
        .BUFFER_SIZE_INPORT(BUFFER_SIZE_ROUTER)
    )
    inport_south(
    .flit_in(flit_inport_south),
    .rst(rst),
    .clk(clk),
    .valid_downstream_ports(valid_downstream_ports),
    .valid_flit_in(valid_in_south),
    .sa_grant(sa_grant),
    .flit_o(flit_out_south),
    .buffer_on(buffer_on_out_south),
    .sa_request(sw_req_south),
    .outport(outport_south),
    .valid_flit_out(valid_out_south)
    );

    inport_v3 #(
        .PORT_DIR(5'b01000 ),
        .X_CURRENT_INPORT(X_CURRENT),
        .Y_CURRENT_INPORT(Y_CURRENT),
        .BUFFER_SIZE_INPORT(BUFFER_SIZE_ROUTER)
    )
    inport_west(
    .flit_in(flit_inport_west),
    .rst(rst),
    .clk(clk),
    .valid_downstream_ports(valid_downstream_ports),
    .valid_flit_in(valid_in_west),
    .sa_grant(sa_grant),
    .flit_o(flit_out_west),
    .buffer_on(buffer_on_out_west),
    .sa_request(sw_req_west),
    .outport(outport_west),
    .valid_flit_out(valid_out_west)
    );

    inport_v3 #(
        .PORT_DIR(5'b10000 ),
        .X_CURRENT_INPORT(X_CURRENT),
        .Y_CURRENT_INPORT(Y_CURRENT),
        .BUFFER_SIZE_INPORT(BUFFER_SIZE_ROUTER)
    )
    inport_local(
    .flit_in(flit_inport_local),
    .rst(rst),
    .clk(clk),
    .valid_downstream_ports(valid_downstream_ports),
    .valid_flit_in(valid_in_local),
    .sa_grant(sa_grant),
    .flit_o(flit_out_local),
    .buffer_on(buffer_on_out_local),
    .sa_request(sw_req_local),
    .outport(outport_local),
    .valid_flit_out(valid_out_local)
    );


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

    crossbar crossbar(
    .flit_in_north(flit_out_north),
    .flit_in_east(flit_out_east),
    .flit_in_south(flit_out_south),
    .flit_in_west(flit_out_west),
    .flit_in_local(flit_out_local),
    .sa_grant(sa_grant),
    .outport_north(outport_north),
    .outport_east(outport_east),
    .outport_south(outport_south),
    .outport_west(outport_west),
    .outport_local(outport_local),
    .valid_in_north(valid_out_north),
    .valid_in_east(valid_out_east),
    .valid_in_south(valid_out_south),
    .valid_in_west(valid_out_west),
    .valid_in_local(valid_out_local),
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
