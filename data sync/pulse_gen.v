module pulse_gen (
    input                  CLK,
    input                  RST,
    input                  IN,
    output       reg          out
);
    reg Q;
    always @(posedge CLK,negedge RST ) 
        begin
          if (!RST) 
            begin
               Q <= 'd0; 
            end 
          else 
            begin
               Q <= IN;
            end  
          out <= (IN & (!Q)); 
        end

endmodule