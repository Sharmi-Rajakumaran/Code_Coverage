module log_gat_tb();

reg a_i_tb, b_i_tb, c_i_tb;
wire out_tb;

integer i;

log_gat DUT( .i_a(a_i_tb), .i_b(b_i_tb), .i_c(c_i_tb), .out(out_tb));

initial
begin

for(i=0; i < 8; i = i+1)
begin
        {a_i_tb, b_i_tb,c_i_tb} = i;
        #10;
end

end

initial
        $monitor ($time, "Input a = %d, b = %d, c = %d ", a_i_tb, b_i_tb, c_i_tb);

endmodule
