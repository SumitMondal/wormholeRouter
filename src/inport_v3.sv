//Engineer     : Sumit Mondal
//Date         : April 2020
//Name of file : inport_v3.sv
//Description  : Input Port, surrounds the buffer, and pipeline/FSM logic


module inport_v3
 #(parameter BUFFER_SIZE_INPORT = 16,
    parameter X_CURRENT_INPORT = 0,
    parameter Y_CURRENT_INPORT = 0,
    parameter PORT_DIR = 5'b00001)
 (
    input logic [63:0] flit_in,
    input rst, 
    input clk,
    input [4:0] valid_downstream_ports,
    input valid_flit_in,
    input [4:0] sa_grant,
    output logic [63:0] flit_o,
    output logic buffer_on,
    output logic sa_request,
    output logic [4:0] outport,
    output logic valid_flit_out
 );

    enum logic [2:0] {BW, RCSA, ST} state, state_next;
    //enum logic [2:0] {LOCAL, NORTH, SOUTH, WEST, EAST} outport_next;

    //logic [VC_SIZE-1:0] downstream_vc_next;

    logic read, write;

    logic [63:0] flit_read;


    logic full;
    logic empty;
    logic empty_next;

    logic [2:0] x_dest;
    logic [2:0] y_dest;
    logic [2:0] x_offset;
    logic [2:0] y_offset;


    buffer #(
        .BUFFER_SIZE(BUFFER_SIZE_INPORT)
    )
    buffer(
        .flit_in(flit_in),
        .push(write),
        .pop(read),
        .rst(rst),
        .clk(clk),
        .flit_o(flit_read),
        .full(full),
        .empty(empty),
        .empty_next(empty_next),
        .buffer_on(buffer_on)
    );

    // Sequential Logic ..

    always_ff @(posedge clk, posedge rst)
    begin
        if(rst)
        begin
            state               <= BW;
        end
        else
        begin
            state               <= state_next;
        end
    end


    // Combinational Logic ..
    always_comb
    begin
        read = 0;
        write = 0;
        sa_request = 0;
        if(valid_flit_in)
            write = 1;
        flit_o = flit_read;
        state_next = state;

        unique case(state)
            BW:
            begin
                valid_flit_out = 0;
                read = 0;
                if (write) //& empty)
                begin
                        state_next = RCSA;
                end
            end
            
            RCSA:
            begin
                valid_flit_out = 0;
                ///////////////////////////////////////
                // Dimenson Ordered Routing Algorithm
                //////////////////////////////////////
                x_dest = flit_read[63:62];
                y_dest = flit_read[61:60];
                x_offset = x_dest - X_CURRENT_INPORT;
                y_offset = y_dest - Y_CURRENT_INPORT;
                    unique if (x_offset > 3)    // don't feel like dealing with 2's complement ,this means its negative
                    begin
                        //outport_next = WEST;
                        outport = 5'b01000;
                    end
                    else if (x_offset > 0 & x_offset < 4)
                    begin
                        //outport_next = EAST;
                        outport= 5'b00010;
                    end
                    else if (x_offset == 0 & (y_offset > 0 & y_offset < 4))
                    begin
                        //outport_next = NORTH;
                        outport = 5'b00001;
                    end
                    else if (x_offset == 0 & y_offset > 3)
                    begin
                        //outport_next = SOUTH;
                        outport = 5'b00100;;
                    end
                    else
                    begin
                        //outport_next = LOCAL;
                        outport = 5'b10000;
                    end
                    //$display("did it get to here ?");
                sa_request = 1;
                read = 0;

                if(sa_grant == PORT_DIR & ((outport & valid_downstream_ports) != 0) )
                begin
                    sa_request = 0;
                    state_next = ST;
                    valid_flit_out = 1;
                end


            end


            ST:
            begin
                read = 1;
                valid_flit_out = 0;
                if (empty_next) begin
                    state_next = BW;
                end
                else begin
                    state_next = RCSA;
                end
            end

            default:
            begin
                //$display("you broke it !!");
                state_next = BW;
                //error = 1;
            end

        endcase // state  machine

    end

endmodule : inport_v3











