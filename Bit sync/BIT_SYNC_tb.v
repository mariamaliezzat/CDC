`timescale 1ns/1ns
module BIT_SYNC_tb ;
    parameter BUS_WIDTH  = 'd2;
    parameter NUM_STAGES = 'd2;
    parameter PERIOD = 'd50;
    
    reg                                     CLK_tb;
    reg                                     RST_tb;
    reg          [BUS_WIDTH-'d1:0]          ASYNC_tb;
    wire         [BUS_WIDTH-'d1:0]          SYNC_tb; 
    initial 
        begin
            CLK_tb = 'd1;
            #(PERIOD/2)
            RST_tb = 'd0;
            #PERIOD
            if (SYNC_tb == 'd0) 
                begin
                    $display("passed");
                end 
            else 
                begin
                    $display("failed");
                end
            RST_tb   = 'd1;
            ASYNC_tb = 'd1;
            #PERIOD
            #PERIOD
            if (SYNC_tb == 'd1) 
                begin
                    $display("passed");
                end 
            else 
                begin
                    $display("failed");
                end 
            #PERIOD
            $finish;

        end
    always #(PERIOD/2) CLK_tb = !CLK_tb ;
BIT_SYNC  #(.BUS_WIDTH(BUS_WIDTH),.NUM_STAGES(NUM_STAGES)) DUT  (
    .CLK(CLK_tb),
    .RST(RST_tb),
    .ASYNC(ASYNC_tb),
    .SYNC(SYNC_tb)
);  
endmodule