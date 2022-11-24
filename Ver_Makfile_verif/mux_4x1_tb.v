module mux4_1_tb();

   //Global variables declared for driving the DUT
   reg [3:0] a;
   reg [1:0] sel;
   wire y;
   integer i;

   //Internal variables used for iteration purpose 
   integer i,j;

   //Step1 : Instantiate the Design using instantion by name method

   mux4_1 DUT(.a_in(a),.sel_in(sel),.y_out(y));
   /*Step2 : Write initial block for stimulus generation
             Initialise inputs
             Use nested 'for' loops for generating stimulus for "a" & "sel" 
             respectively at an interval of 10ns */
        task initialize();
                begin
                        a =4'b0;
                        sel=2'b0;
                end
        endtask

        initial

        begin
                initialize;

                for(i=0; i<4; i = i+1)
                begin
                    for (i=0;i<16,i=i+1)
                                begin
                                        a = i;
                                        #10;
                                end
                end
   //Step3 : Use $finish task to terminate the simulation at 1000ns
                #1000 $finish;
   //Process to monitor the changes in the outputs
   initial
      $monitor("Input a=%b,sel=%b,Output y=%b",a,sel,y);


endmodule
