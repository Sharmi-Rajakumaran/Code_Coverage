module d_ff(input d0, d1, sel, clk, rst,output reg q);
  

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

/*
Simulation Result
# Loading work.tb_dff(fast)
# run -all
# Reset is perfect
# Input is perfect
# Reset is perfect
# Input is perfect
# Input is perfect
# Input is perfect
# Input is perfect
# Reset is perfect
# ** Note: $stop    : ../tb/tb_dff.v(118)
#    Time: 995 ns  Iteration: 0  Instance: /tb_dff
# Break at ../tb/tb_dff.v line 118
# Stopped at ../tb/tb_dff.v line 118
#  exit
# End time: 12:44:11 on Nov 25,2022, Elapsed time: 0:00:00
# Errors: 0, Warnings: 0

*/
   
  
