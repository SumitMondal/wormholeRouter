//Engineer     : Sumit Mondal
//Date         : April 2020
//Name of file : crossbar.sv
//Description  : Crossbar (input port to output)

module crossbar
 (
    input logic [63:0] flit_in_north,
    input logic [63:0] flit_in_east,
    input logic [63:0] flit_in_south,
    input logic [63:0] flit_in_west,
    input logic [63:0] flit_in_local,
    input logic [4:0] sa_grant,
    input logic [4:0] outport_north,
    input logic [4:0] outport_east,
    input logic [4:0] outport_south,
    input logic [4:0] outport_west,
    input logic [4:0] outport_local,
    input logic valid_in_north,
    input logic valid_in_east,
    input logic valid_in_south,
    input logic valid_in_west,
    input logic valid_in_local,
    output logic [63:0] flit_out_north,
    output logic [63:0] flit_out_east,
    output logic [63:0] flit_out_south,
    output logic [63:0] flit_out_west,
    output logic [63:0] flit_out_local,
    output logic valid_outport_north,
    output logic valid_outport_east,
    output logic valid_outport_south,
    output logic valid_outport_west,
    output logic valid_outport_local
 );

 always_comb
 begin
 	case(sa_grant)
 		5'b00001:
 		begin
 			//$display("did it enter the grant case");
 			case(outport_north)
 				5'b00001:
 				begin
 					flit_out_north = flit_in_north;
 					flit_out_east = 0;
 					flit_out_south = 0;
 					flit_out_west = 0;
 					flit_out_local = 0;
 					valid_outport_north = valid_in_north;
 					valid_outport_east = 0;
 					valid_outport_south = 0;
 					valid_outport_west = 0;
 					valid_outport_local = 0;
 				end
 				5'b00010:
 				begin
 					flit_out_north = 0;
 					flit_out_east =flit_in_north;
 					flit_out_south = 0;
 					flit_out_west = 0;
 					flit_out_local = 0;
 					valid_outport_north = 0;
 					valid_outport_east = valid_in_north;
 					valid_outport_south = 0;
 					valid_outport_west = 0;
 					valid_outport_local = 0;
 					//$display("did it enter the east outport case");
 				end
 				5'b00100:
 				begin
 					flit_out_north = 0;
 					flit_out_east = 0;
 					flit_out_south = flit_in_north;
 					flit_out_west = 0;
 					flit_out_local = 0;
 					valid_outport_north = 0;
 					valid_outport_east = 0;
 					valid_outport_south = valid_in_north;
 					valid_outport_west = 0;
 					valid_outport_local = 0;
 				end
 				5'b01000:
 				begin
 					flit_out_north = 0;
 					flit_out_east = 0;
 					flit_out_south = 0;
 					flit_out_west = flit_in_north;
 					flit_out_local = 0;
 					valid_outport_north = 0;
 					valid_outport_east = 0;
 					valid_outport_south = 0;
 					valid_outport_west = valid_in_north;
 					valid_outport_local = 0;
 				end
 				5'b10000:
 				begin
 					flit_out_north = 0;
 					flit_out_east = 0;
 					flit_out_south = 0;
 					flit_out_west = 0;
 					flit_out_local = flit_in_north;
 					valid_outport_north = 0;
 					valid_outport_east = 0;
 					valid_outport_south = 0;
 					valid_outport_west = 0;
 					valid_outport_local = valid_in_north;
 					//$display("did it enter the local outport case");
 				end
 				default:
 				begin
 				 	flit_out_north = 0;
 					flit_out_east = 0;
 					flit_out_south = 0;
 					flit_out_west = 0;
 					flit_out_local = 0;
 					valid_outport_north = 0;
 					valid_outport_east = 0;
 					valid_outport_south = 0;
 					valid_outport_west = 0;
 					valid_outport_local = 0;
 					//$display("did it enter the default outport case");
 				end
 			endcase
 		end

 		5'b00010:
 		begin
 			case(outport_east)
 				5'b00001:
 				begin
 					flit_out_north = flit_in_east;
 					flit_out_east = 0;
 					flit_out_south = 0;
 					flit_out_west = 0;
 					flit_out_local = 0;
 					valid_outport_north = valid_in_east;
 					valid_outport_east = 0;
 					valid_outport_south = 0;
 					valid_outport_west = 0;
 					valid_outport_local = 0;
 				end
 				5'b00010:
 				begin
 					flit_out_north = 0;
 					flit_out_east =flit_in_east;
 					flit_out_south = 0;
 					flit_out_west = 0;
 					flit_out_local = 0;
 					valid_outport_north = 0;
 					valid_outport_east = valid_in_east;
 					valid_outport_south = 0;
 					valid_outport_west = 0;
 					valid_outport_local = 0;
 				end
 				5'b00100:
 				begin
 					flit_out_north = 0;
 					flit_out_east = 0;
 					flit_out_south = flit_in_east;
 					flit_out_west = 0;
 					flit_out_local = 0;
 					valid_outport_north = 0;
 					valid_outport_east = 0;
 					valid_outport_south = valid_in_east;
 					valid_outport_west = 0;
 					valid_outport_local = 0;
 				end
 				5'b01000:
 				begin
 					flit_out_north = 0;
 					flit_out_east = 0;
 					flit_out_south = 0;
 					flit_out_west = flit_in_east;
 					flit_out_local = 0;
 					valid_outport_north = 0;
 					valid_outport_east = 0;
 					valid_outport_south = 0;
 					valid_outport_west = valid_in_east;
 					valid_outport_local = 0;
 				end
 				5'b10000:
 				begin
 					flit_out_north = 0;
 					flit_out_east = 0;
 					flit_out_south = 0;
 					flit_out_west = 0;
 					flit_out_local = flit_in_east;
 					valid_outport_north = 0;
 					valid_outport_east = 0;
 					valid_outport_south = 0;
 					valid_outport_west = 0;
 					valid_outport_local = valid_in_east;
 				end
 				default:
 				begin
 				 	flit_out_north = 0;
 					flit_out_east = 0;
 					flit_out_south = 0;
 					flit_out_west = 0;
 					flit_out_local = 0;
 					valid_outport_north = 0;
 					valid_outport_east = 0;
 					valid_outport_south = 0;
 					valid_outport_west = 0;
 					valid_outport_local = 0;
 				end
 			endcase
 		end

 		5'b00100:
 		begin
 			 case(outport_south)
 				5'b00001:
 				begin
 					flit_out_north = flit_in_south;
 					flit_out_east = 0;
 					flit_out_south = 0;
 					flit_out_west = 0;
 					flit_out_local = 0;
 					valid_outport_north = valid_in_south;
 					valid_outport_east = 0;
 					valid_outport_south = 0;
 					valid_outport_west = 0;
 					valid_outport_local = 0;
 				end
 				5'b00010:
 				begin
 					flit_out_north = 0;
 					flit_out_east =flit_in_south;
 					flit_out_south = 0;
 					flit_out_west = 0;
 					flit_out_local = 0;
 					valid_outport_north = 0;
 					valid_outport_east = valid_in_south;
 					valid_outport_south = 0;
 					valid_outport_west = 0;
 					valid_outport_local = 0;
 				end
 				5'b00100:
 				begin
 					flit_out_north = 0;
 					flit_out_east = 0;
 					flit_out_south = flit_in_south;
 					flit_out_west = 0;
 					flit_out_local = 0;
 					valid_outport_north = 0;
 					valid_outport_east = 0;
 					valid_outport_south = valid_in_south;
 					valid_outport_west = 0;
 					valid_outport_local = 0;
 				end
 				5'b01000:
 				begin
 					flit_out_north = 0;
 					flit_out_east = 0;
 					flit_out_south = 0;
 					flit_out_west = flit_in_south;
 					flit_out_local = 0;
 					valid_outport_north = 0;
 					valid_outport_east = 0;
 					valid_outport_south = 0;
 					valid_outport_west = valid_in_south;
 					valid_outport_local = 0;
 				end
 				5'b10000:
 				begin
 					flit_out_north = 0;
 					flit_out_east = 0;
 					flit_out_south = 0;
 					flit_out_west = 0;
 					flit_out_local = flit_in_south;
 					valid_outport_north = 0;
 					valid_outport_east = 0;
 					valid_outport_south = 0;
 					valid_outport_west = 0;
 					valid_outport_local = valid_in_south;
 				end
 				default:
 				begin
 				 	flit_out_north = 0;
 					flit_out_east = 0;
 					flit_out_south = 0;
 					flit_out_west = 0;
 					flit_out_local = 0;
 					valid_outport_north = 0;
 					valid_outport_east = 0;
 					valid_outport_south = 0;
 					valid_outport_west = 0;
 					valid_outport_local = 0;
 				end
 			endcase
 		end

 		5'b01000:
 		begin
 			case(outport_west)
 				5'b00001:
 				begin
 					flit_out_north = flit_in_west;
 					flit_out_east = 0;
 					flit_out_south = 0;
 					flit_out_west = 0;
 					flit_out_local = 0;
 					valid_outport_north = valid_in_west;
 					valid_outport_east = 0;
 					valid_outport_south = 0;
 					valid_outport_west = 0;
 					valid_outport_local = 0;
 				end
 				5'b00010:
 				begin
 					flit_out_north = 0;
 					flit_out_east =flit_in_west;
 					flit_out_south = 0;
 					flit_out_west = 0;
 					flit_out_local = 0;
 					valid_outport_north = 0;
 					valid_outport_east = valid_in_west;
 					valid_outport_south = 0;
 					valid_outport_west = 0;
 					valid_outport_local = 0;
 				end
 				5'b00100:
 				begin
 					flit_out_north = 0;
 					flit_out_east = 0;
 					flit_out_south = flit_in_west;
 					flit_out_west = 0;
 					flit_out_local = 0;
 					valid_outport_north = 0;
 					valid_outport_east = 0;
 					valid_outport_south = valid_in_west;
 					valid_outport_west = 0;
 					valid_outport_local = 0;
 				end
 				5'b01000:
 				begin
 					flit_out_north = 0;
 					flit_out_east = 0;
 					flit_out_south = 0;
 					flit_out_west = flit_in_west;
 					flit_out_local = 0;
 					valid_outport_north = 0;
 					valid_outport_east = 0;
 					valid_outport_south = 0;
 					valid_outport_west = valid_in_west;
 					valid_outport_local = 0;
 				end
 				5'b10000:
 				begin
 					flit_out_north = 0;
 					flit_out_east = 0;
 					flit_out_south = 0;
 					flit_out_west = 0;
 					flit_out_local = flit_in_west;
 					valid_outport_north = 0;
 					valid_outport_east = 0;
 					valid_outport_south = 0;
 					valid_outport_west = 0;
 					valid_outport_local = valid_in_west;
 				end
 				default:
 				begin
 				 	flit_out_north = 0;
 					flit_out_east = 0;
 					flit_out_south = 0;
 					flit_out_west = 0;
 					flit_out_local = 0;
 					valid_outport_north = 0;
 					valid_outport_east = 0;
 					valid_outport_south = 0;
 					valid_outport_west = 0;
 					valid_outport_local = 0;
 				end
 			endcase
 		end

 		5'b10000:
 		begin
 			case(outport_local)
 				5'b00001:
 				begin
 					flit_out_north = flit_in_local;
 					flit_out_east = 0;
 					flit_out_south = 0;
 					flit_out_west = 0;
 					flit_out_local = 0;
 					valid_outport_north = valid_in_local;
 					valid_outport_east = 0;
 					valid_outport_south = 0;
 					valid_outport_west = 0;
 					valid_outport_local = 0;
 				end
 				5'b00010:
 				begin
 					flit_out_north = 0;
 					flit_out_east =flit_in_local;
 					flit_out_south = 0;
 					flit_out_west = 0;
 					flit_out_local = 0;
 					valid_outport_north = 0;
 					valid_outport_east = valid_in_local;
 					valid_outport_south = 0;
 					valid_outport_west = 0;
 					valid_outport_local = 0;
 				end
 				5'b00100:
 				begin
 					flit_out_north = 0;
 					flit_out_east = 0;
 					flit_out_south = flit_in_local;
 					flit_out_west = 0;
 					flit_out_local = 0;
 					valid_outport_north = 0;
 					valid_outport_east = 0;
 					valid_outport_south = valid_in_local;
 					valid_outport_west = 0;
 					valid_outport_local = 0;
 				end
 				5'b01000:
 				begin
 					flit_out_north = 0;
 					flit_out_east = 0;
 					flit_out_south = 0;
 					flit_out_west = flit_in_local;
 					flit_out_local = 0;
 					valid_outport_north = 0;
 					valid_outport_east = 0;
 					valid_outport_south = 0;
 					valid_outport_west = valid_in_local;
 					valid_outport_local = 0;
 				end
 				5'b10000:
 				begin
 					flit_out_north = 0;
 					flit_out_east = 0;
 					flit_out_south = 0;
 					flit_out_west = 0;
 					flit_out_local = flit_in_local;
 					valid_outport_north = 0;
 					valid_outport_east = 0;
 					valid_outport_south = 0;
 					valid_outport_west = 0;
 					valid_outport_local = valid_in_local;
 				end
 				default:
 				begin
 				 	flit_out_north = 0;
 					flit_out_east = 0;
 					flit_out_south = 0;
 					flit_out_west = 0;
 					flit_out_local = 0;
 					valid_outport_north = 0;
 					valid_outport_east = 0;
 					valid_outport_south = 0;
 					valid_outport_west = 0;
 					valid_outport_local = 0;
 				end
 			endcase	
 		end
 		default:
 		begin
 		 			flit_out_north = 0;
 					flit_out_east = 0;
 					flit_out_south = 0;
 					flit_out_west = 0;
 					flit_out_local = 0;
 					valid_outport_north = 0;
 					valid_outport_east = 0;
 					valid_outport_south = 0;
 					valid_outport_west = 0;
 					valid_outport_local = 0;
 		end
 	endcase
 end

 endmodule

