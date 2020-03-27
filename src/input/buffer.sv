--Engineer     : Sumit Mondal
--Date         : 
--Name of file : buffer.vhd
--Description  : Buffer and buffer logic for input side of NoC Router


module buffer
 #(BUFFER_SIZE = 4)
 (
    input logic [63:0] flit_in
    input logic read_i
    input logic write_i
    input reset
    input clk
    output logic [63:0] flit_o
    output logic is_full
    output logic is_empty
    output logic on_off
 );

localparam POINTER_SIZE = $clog2(BUFFER_SIZE);


    
