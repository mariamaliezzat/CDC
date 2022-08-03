module DATA_SYNC #(
    parameter BUS_WIDTH  = 'd8,
    parameter NUM_STAGES = 'd8
) (
    input                            CLK,
    input                            RST,
    input       [BUS_WIDTH-1:0]      unsync_bus,
    input                            bus_enable,
    output reg  [BUS_WIDTH-1:0]      sync_bus,
    output reg                       enable_pulse
);
wire synchronizer_out;
wire pulse_gen_out;
BIT_SYNC #(.NUM_STAGES(NUM_STAGES),.BUS_WIDTH(1)) BIT_SYNC1(
    .CLK(CLK),
    .RST(RST),
    .ASYNC(bus_enable),
    .SYNC(synchronizer_out)
);

pulse_gen pulse_gen1 (
    .CLK(CLK),
    .RST(RST),
    .IN(synchronizer_out),
    .out(pulse_gen_out)
);
reg [BUS_WIDTH-1:0] mux_out;
integer i;
always @(*) 
    begin
    for (i =0 ;i<BUS_WIDTH ;i=i+1 ) 
        begin
            if (pulse_gen_out) 
            begin
            
                mux_out[i] = unsync_bus[i];
            end 
        else
            begin
                mux_out[i] = sync_bus[i];
            end
        end
       
    end
always @(posedge CLK, negedge RST) 
    begin
        if (!RST) 
            begin
               sync_bus <= 0; 
            end 
        else 
            begin
               sync_bus <= mux_out;
            end    
    end
always @(posedge CLK, negedge RST) 
    begin
        if (!RST) 
            begin
               enable_pulse <= 0; 
            end 
        else 
            begin
               enable_pulse <= pulse_gen_out;
            end    
    end
endmodule