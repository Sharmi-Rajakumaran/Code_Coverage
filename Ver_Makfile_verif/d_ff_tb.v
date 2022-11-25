module d_ff_tb();
 reg d0, d1,sel,rstclk;
 wire q;
 
 // Module Instantiation
 d_ff DUT(.d0, d1, sel, clk, rst, q);
 
    
  
