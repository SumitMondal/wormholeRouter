//Engineer     : Sumit Mondal
//Date         : April 2020
//Name of file : buffer_tb.sv
//Description  : Circular Buffer Testbench

`timescale 1ns / 1ps


module buffer_tb #(
    parameter BUFFER_SIZE = 16
);

    int i,j;
    int num_operation;
    
    logic clk,rst;
    logic push;
    logic pop;

    logic [63:0]  flit_queue[$];
    logic [63:0]  flit_written;
    logic [63:0]  flit_read;
    logic [63:0]  flit_x;

    logic [63:0]  flit_in;
    logic [63:0]  flit_out;

    wire full;
    wire empty;
    wire buffer_on;
    localparam MESH_SIZE_X = 4;
    localparam DEST_ADDR_SIZE_X = $clog2(MESH_SIZE_X);
    localparam DEST_ADDR_SIZE_Y = $clog2(MESH_SIZE_X);

    always #5 clk = ~clk;

    buffer #(
        .BUFFER_SIZE(BUFFER_SIZE)
    )
    buffer (
        .flit_in(flit_in),
        .push(push),
        .pop(pop),
        .rst(rst),
        .clk(clk),
        .flit_o(flit_out),
        .full(full),
        .empty(empty),
        .buffer_on(buffer_on)
    );

    initial begin
        //dump_output();
        initialize();
        clear_reset();
        fork
        begin
            repeat(10)
                random_operation();
        end
        join      
        #20 $finish;
    end

    task initialize();
        clk     <= 0;
        rst     = 1;
        push  = 0;
        pop = 0;
        num_operation = 0;
    endtask

    // test read !
    task clear_reset();
        repeat(1) @(posedge clk);
            rst <= 0;
    endtask

    task read();
        if(i == 0)
            return;
        else
        begin
            flit_read=flit_queue.pop_front();
            @(posedge clk);
            push <= 0;
            pop <= 1;
            flit_in <= flit_x;
            i = i - 1;
            num_operation = num_operation + 1;
            @(negedge clk);
            if(~check_flits())
                $display("[READ] FAILED");
            else
                $display("[READ] PASSED");
        end
    endtask

    task write();
        if(i == BUFFER_SIZE - 1)
            return;
        else
        begin
            create_flit();
            @(posedge clk);
            push <= 1;
            pop <= 0;
            flit_in <= flit_written;
            flit_queue.push_back(flit_written);
            if(empty & flit_queue.size() > 2)
                $display("[WRITE] FAILED");
            else
                $display("[WRITE] PASSED");
            i = i + 1;
            num_operation = num_operation + 1;
        end
    endtask

        /*
    The read write combines the two operations above
    */
    task read_write();
        begin
            if(i == 0)
                return;
            else
            begin
                flit_read=flit_queue.pop_front();
                create_flit();
                @(posedge clk);
                push <= 1;
                pop <= 1;
                flit_in <= flit_written;
                flit_queue.push_back(flit_written);
                num_operation = num_operation + 1;
                @(negedge clk);
                if(check_flits() & ~empty)
                    $display("[READ AND WRITE] PASSED");
                else
                    $display("[READ AND WRITE] FAILED");
            end
        end
    endtask

    task random_operation();
        j = $urandom_range(8,0);
        if(j >= 6)
            read_write();
        else if (j <= 2)
            write();
        else
            read();
    endtask

    task create_flit();
        flit_written[63:62] <= num_operation;
        flit_written[61:60] <= num_operation;
        flit_written[59:0] <= $urandom_range(0,1000000);
    endtask

    function logic check_flits();
        if(flit_read == flit_out)
            check_flits = 1;
        else
            check_flits = 0;   
    endfunction 

endmodule
