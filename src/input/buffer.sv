//Engineer     : Sumit Mondal
//Date         : 
//Name of file : buffer.vhd
//Description  : Buffer and buffer logic for input side of NoC Router


module buffer
 #(BUFFER_SIZE = 16)
 (
    input logic [63:0] flit_in,
    input logic push,
    input logic pop,
    input rst,
    input clk,
    output logic [63:0] flit_o,
    output logic full,
    output logic empty,
    output logic buffer_on
 );

logic [63:0] buffer [BUFFER_SIZE-1:0];

localparam POINTER_SIZE = $clog2(BUFFER_SIZE);
localparam ON_OFF_DELAY = 2;

logic full_next;
logic empty_next;
logic buffer_on_next;

logic [POINTER_SIZE-1:0] read_ptr;
logic [POINTER_SIZE-1:0] read_ptr_next;

logic [POINTER_SIZE-1:0] write_ptr;
logic [POINTER_SIZE-1:0] write_ptr_next;

logic n_flits;
logic n_flits_next;


// Sequential Logic
always_ff @(posedge clk or posedge rst)
begin
 if (rst)
 begin
  full <= 0;
  empty <= 1;
  buffer_on <= 1;
  read_ptr <= 0;
  write_ptr <= 0;
  n_flits <= 0;
 end
 else
  begin
  full <= full_next;
  empty <= empty_next;
  buffer_on <= buffer_on_next;
  read_ptr <= read_ptr_next;
  write_ptr <= write_ptr_next;
  n_flits <= n_flits_next;
   if ((~pop & push & ~full) | (pop & push))
    buffer[write_ptr] = flit_in;
  end 
end


//Combinational Logic
always_comb
begin
 flit_o = buffer[read_ptr];
 if (pop & ~push & ~empty)
 begin: read_check_empty
  if (read_ptr == BUFFER_SIZE - 1) 
   read_ptr_next = 0;
  else
   read_ptr_next = read_ptr + 1;
  if (read_ptr_next == write_ptr)
    empty_next = 1;
  else
    empty_next = 0;
  n_flits_next = n_flits - 1;
  write_ptr_next = write_ptr;
  full_next = 0;
 end
 
 else if (~pop & push & ~full)
 begin: write_check_full
   if (write_ptr == BUFFER_SIZE - 1)
    write_ptr_next = 0;
   else
    write_ptr_next = write_ptr + 1;
   if (write_ptr_next == read_ptr)
    full_next = 1;
   else
    full_next = 0;
   empty_next = 0;
   n_flits_next = n_flits + 1;
   read_ptr_next = read_ptr;
 end

 else if (pop & push & ~ empty)
 begin: read_and_write
  if (read_ptr == BUFFER_SIZE - 1)
   read_ptr_next = 0;
  else
   read_ptr_next = read_ptr + 1; 
  if (write_ptr == BUFFER_SIZE - 1)
   write_ptr_next = 0;
  else
   write_ptr_next = read_ptr + 1;
  full_next = full;
  empty_next = empty;
  n_flits_next = n_flits;    
 end

 else
 begin: no_read_or_write
  full <= full_next;
  empty <= empty_next;
  read_ptr <= read_ptr_next;
  write_ptr <= write_ptr_next;
  n_flits <= n_flits_next;
 end

 begin:on_off_credit_system
 if (n_flits > n_flits_next & n_flits_next < ON_OFF_DELAY)
  buffer_on_next = 1;
 else if (n_flits < n_flits_next & n_flits_next > BUFFER_SIZE - ON_OFF_DELAY)
  buffer_on_next = 0;
 else
  buffer_on_next = buffer_on;
 end

end

endmodule
