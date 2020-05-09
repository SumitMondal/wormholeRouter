//Engineer     : Dongjun Luo -- Minor edits by Sumit Mondal
//Date         : 
//Name of file : switch_allocator.sv
//Description  : Round Robin Arbiter acting as SA

//Using Two Simple Priority Arbiters with a Mask - scalable
//author: dongjun_luo@hotmail.com
module round_robin_arbiter (
	input rst,
	input clk,
	input logic req_00001,
	input logic req_00010,
	input logic req_00100,
	input logic req_01000,
	input logic req_10000,
	output logic [4:0] grant
);

parameter N = 5;

logic [N-1:0] req;
reg	[N-1:0]	rotate_ptr;
wire	[N-1:0]	mask_req;
wire	[N-1:0]	mask_grant;
wire	[N-1:0]	grant_comb;
wire		no_mask_req;
wire	[N-1:0] nomask_grant;
wire		update_ptr;
genvar i;

always_comb
begin
	//cur_req = {req_1000,req_0100,req_0010,req_0001};
	req = {req_10000,req_01000,req_00100,req_00010,req_00001};
end



// rotate pointer update logic
assign update_ptr = |grant[N-1:0];
always @ (posedge clk or posedge rst)
begin
	if (rst)
		rotate_ptr[N-1:0] <= {N{1'b1}};
	else if (update_ptr)
	begin
		// note: N must be at least 2
		rotate_ptr[0] <= grant[N-1];
		rotate_ptr[1] <= grant[N-1] | grant[0];
	end
end

generate
for (i=2;i<N;i=i+1)
always @ (posedge clk or posedge rst)
begin
	if (rst)
		rotate_ptr[i] <= 1'b1;
	else if (update_ptr)
		rotate_ptr[i] <= grant[N-1] | (|grant[i-1:0]);
end
endgenerate

// mask grant generation logic
assign mask_req[N-1:0] = req[N-1:0] & rotate_ptr[N-1:0];

assign mask_grant[0] = mask_req[0];
generate
for (i=1;i<N;i=i+1)
	assign mask_grant[i] = (~|mask_req[i-1:0]) & mask_req[i];
endgenerate

// non-mask grant generation logic
assign nomask_grant[0] = req[0];
generate
for (i=1;i<N;i=i+1)
	assign nomask_grant[i] = (~|req[i-1:0]) & req[i];
endgenerate

// grant generation logic
assign no_mask_req = ~|mask_req[N-1:0];
assign grant_comb[N-1:0] = mask_grant[N-1:0] | (nomask_grant[N-1:0] & {N{no_mask_req}});

always @ (posedge clk or posedge rst)
begin
	if (rst)	grant[N-1:0] <= {N{1'b0}};
	else		grant[N-1:0] <= grant_comb[N-1:0] & ~grant[N-1:0];
end
endmodule




