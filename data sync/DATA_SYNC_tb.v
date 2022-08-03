`timescale 1ns/1ns
module DATA_SYNC_tb;
    parameter BUS_WIDTH  = 'd2;
    parameter NUM_STAGES = 'd2;
    parameter PERIOD = 'd50;
    reg                            CLK_tb;
    reg                            RST_tb;
    reg       [BUS_WIDTH-1:0]      unsync_bus_tb;
    reg                            bus_enable_tb;
    wire      [BUS_WIDTH-1:0]      sync_bus_tb;
    wire                           enable_pulse_tb;
initial 
    begin
        CLK_tb = 'd1;
        #(PERIOD/2)
        RST_tb = 'd0;
        #PERIOD
        if (sync_bus_tb== 'd0) 
            begin
                $display("passed");
            end 
        else 
            begin
                $display("failed");
            end
        RST_tb        = 'd1;
        bus_enable_tb = 'd1;
        unsync_bus_tb = 'd1;
        repeat (5) @(posedge CLK_tb);
        if (sync_bus_tb== 'd1) 
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
DATA_SYNC #(.BUS_WIDTH(BUS_WIDTH),.NUM_STAGES(NUM_STAGES)) DUT (
    .CLK(CLK_tb),
    .RST(RST_tb),
    .unsync_bus(unsync_bus_tb),
    .bus_enable(bus_enable_tb),
    .sync_bus(sync_bus_tb),
    .enable_pulse(enable_pulse_tb)
);
endmodule