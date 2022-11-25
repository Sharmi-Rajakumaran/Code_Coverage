module tb_coincol ();

   //Global variables declaration for driving stimulus
   reg clock,reset;
   reg [1:0] coin;
   reg [7:0] temp;
   reg [7:0] coin_sum;
   wire done;
   wire [6:0] lsb7seg;
   wire [6:0] msb7seg;

   //State machine instantiation
   coincol DUT(clock,reset,coin,done,
   lsb7seg,msb7seg);

   //Define setup and hold time
   //Define clock time-period
   parameter THOLD   = 5,
             TSETUP  = 5,
             CYCLE   = 20,
             NOCOIN  = 8'd0,
             PAISE25 = 8'd25,
             PAISE50 = 8'd50,
             PAISE75 = 8'd75,
             RUPEE1  = 8'd100;


   //Clock Generation logic
   always
      begin
         #(CYCLE/2) clock = 1'b0;
         #(CYCLE/2) clock = 1'b1;
      end

   //Reset Checking
   task sync_reset;
      begin
         reset = 1'b1;
         coin  = 2'b11;
         coin_sum = 8'd0;
         @(posedge clock);
            #(THOLD);
         if(done !== 1'b0 ||
            lsb7seg !== 7'b1000000 ||
            msb7seg !== 7'b1000000)
         begin
            $display("Reset is not working");
            $display("Error at time %t",$time);
            $stop;
         end
         $display("Reset is perfect \n");
         {reset,coin} = 3'bx;
         #(CYCLE - THOLD - TSETUP);
      end
   endtask

   //Loading coins
   task load_coin;
   input [1:0] data;
      begin
         reset = 1'b0;
         coin  = data;
         //Conversion
         if(coin == 2'b00)
            temp = 8'd25;
         else if(coin == 2'b01)
            temp = 8'd50;
         else if(coin == 2'b10)
            temp = 8'd100;
         else if(coin == 2'b11)
            temp = 8'd0;
         @(posedge clock);
            #(THOLD);
         //Stores total amount
         coin_sum = coin_sum + temp;
         case(coin_sum)
            PAISE25 :
                       begin
                          if(done !== 1'b0 || lsb7seg !== 7'b0100100 || msb7seg !== 7'b0010100)
                             begin
                                $display("Error at time %t",$time);
                                $stop;
                             end
                          $display("Now the Amount is 25 Paise");
                          $display("DONE = %b \n",done);
                       end

            PAISE50 :
                       begin
                          if(done !== 1'b0 || lsb7seg !== 7'b0100010 || msb7seg !== 7'b1000000)
                             begin
                                $display("Error at time %t",$time);
                                $stop;
                             end
                          $display("Now the Amount is 50 Paise");
                          $display("DONE = %b \n",done);
                       end

            PAISE75 :
                       begin
                          if(done !== 1'b0 || lsb7seg !== 7'b1111000 || msb7seg !== 7'b0010010)
                             begin
                                $display("Error at time %t",$time);
                                $stop;
                             end
                          $display("Now the Amount is 75 Paise");
                          $display("DONE = %b \n",done);
                       end

            RUPEE1  :
                       begin
                          if(done !== 1'b1 || lsb7seg !== 7'b0001001 || msb7seg !== 7'b0001000)
                             begin
                                $display("Error at time %t",$time);
                                $stop;
                             end
                          $display("Now the Amount is 1 Rupee");
                          $display("DONE = %b \n",done);
                       end

            NOCOIN  :$display("You have to put some amount");

            default ://Covers the amounts 125, 150 ans 175 
                       begin
                          if(done !== 1'b1 || lsb7seg !== 7'b0001001 || msb7seg !== 7'b0001000)
                             begin
                                $display("Error at time %t",$time);
                                $stop;
                             end
                          $display("Now the Amount is 1 Rupee");
                          $display("DONE = %b \n",done);
                       end

         endcase
         coin <= 2'bx;
         #(CYCLE - THOLD - TSETUP);
      end
   endtask

   //Applying Stimulus
 //Applying Stimulus
   initial
      begin
         sync_reset;
         //check by 25 paise
         load_coin(2'b00);
         load_coin(2'b00);
         load_coin(2'b00);
         load_coin(2'b00);

         sync_reset;
         //check by 50 paise
         load_coin(2'b01);
         load_coin(2'b01);

         sync_reset;
         //check by 1 Rupee
         load_coin(2'b10);

         sync_reset;
         //25 paise then 1 rupee
         load_coin(2'b00);
         load_coin(2'b10);

         sync_reset;
         //50 paise then 1 rupee
         load_coin(2'b01);
         load_coin(2'b10);

         sync_reset;
         //75 paise then 1 rupee
         load_coin(2'b00);
         load_coin(2'b01);
         load_coin(2'b10);

         #50 $stop;
      end


endmodule
                             
