`timescale 1ns/1ns
module RST_SYNC_tb ;
    reg                                      CLK_tb;
    reg                                      RST_tb;
    wire                                     RST_SYNC_tb;
    parameter NUM_STAGES = 'd2;
    parameter PERIOD     = 'd50;
    initial 
        begin
            CLK_tb = 'd1;
            #(PERIOD/2)
            RST_tb = 'd0;
            #PERIOD
            if (RST_SYNC_tb == 'd0) 
                begin
                    $display("passed");
                end 
            else 
                begin
                    $display("failed");
                end 
            RST_tb = 'd1;
            #PERIOD
            #PERIOD
             if (RST_SYNC_tb == 'd1) 
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
RST_SYNC #(.NUM_STAGES(NUM_STAGES)) DUT (
    .CLK(CLK_tb),
    .RST(RST_tb),
    .RST_SYNC(RST_SYNC_tb)
);
endmodule