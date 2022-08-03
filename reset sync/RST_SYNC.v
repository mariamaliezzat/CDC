module RST_SYNC #(
    parameter NUM_STAGES = 2
) (
    input                                      CLK,
    input                                      RST,
    output                                     RST_SYNC
);
integer i;
reg [NUM_STAGES-1:0] Q;
    always @(posedge CLK, negedge RST ) 
        begin
            if (!RST) 
                begin
                    Q <=0;
                end 
            else 
                begin
                    Q[0] <= 1;
                    for (i = 1;i<NUM_STAGES ;i=i+1 ) 
                        begin
                            Q[i]<=Q[i-1];
                        end 
                end
            
        end
    assign RST_SYNC = Q[NUM_STAGES-1];
endmodule