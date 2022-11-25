module d_ff(input d0, d1, sel, clk, rst, q);
  input d0,d1,sel,clk,rst;
  output reg q;
  reg d;
  
  always@(d0 or d1 or sel)
    begin
      case (sel)
          0 : d = d0;
          1 : d = d1;
          default: d = 1'b0;
      endcase
    end
  
  always@(posedge clk or posedge rst)
  
    begin
      if(rst)
        q<=1'b0;
      else
      q <= d;
    end
        assign qbar = ~q;
        
    
        
   endmodule
   
  
