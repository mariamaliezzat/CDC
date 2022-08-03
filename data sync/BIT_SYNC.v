module BIT_SYNC #(
   parameter  NUM_STAGES = 'd2,
   parameter  BUS_WIDTH  = 'd3
) (
    input                                      CLK,
    input                                      RST,
    input          [BUS_WIDTH-'d1:0]           ASYNC,
    output   reg   [BUS_WIDTH-'d1:0]           SYNC

);
reg [NUM_STAGES-'d1:0] Q [0:BUS_WIDTH-'d1];
integer  i;
integer  j;
integer  k;
    always @(posedge CLK ,negedge RST) 
        begin
            if (!RST) 
                begin
                   for (i =0 ;i<BUS_WIDTH;i=i+1 ) 
                        begin
                           Q[i]<='d0;
                        end 
                end 
            else 
                begin
                   for (i =0 ;i<BUS_WIDTH;i=i+1 ) 
                        begin
                           Q[i][0]<=ASYNC[i];
                           //SYNC[i]<=Q[i][NUM_STAGES-1];
                           for (j=1;j<NUM_STAGES;j=j+1) 
                                begin
                                    Q[i][j]<=Q[i][j-1];
                                end
                        end
                    
                end
        end
        
        always @(*) 
            begin
                for (k = 0;k<BUS_WIDTH ;k=k+1 ) 
                    begin
                        SYNC[k] = Q[k][NUM_STAGES-1];
                    end
            end
       
endmodule