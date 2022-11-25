module log_gat(input i_a, i_b, i_c, output out);
  

assign out = ~((i_a & i_b)& i_c);
endmodule
