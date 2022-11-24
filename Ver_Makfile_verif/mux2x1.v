module mux2x1(input a,b,sel, output y);
  assign y = (~sel&a)|(sel&b);
endmodule
