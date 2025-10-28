module bcd(
    input wire clk,
    input wire reset,
    input wire button,
    output wire [3:0] tens,
    output wire [3:0] units,
    output wire [3:0] hund,
    output wire [3:0] thous
);

wire tick_1;
counter tick_gen (
        .clk(clk),
        .rst(reset),
        .tick_1(tick_1)
    );
    
    reg [15:0]count1;
    reg counting_down;
    reg reaction_done;
   
    
  always@(posedge clk or posedge reset)
    begin
        if(reset)
        begin   
            count1<=16'd3000;
            counting_down<=1'b1;
            reaction_done<=1'b1;
        end
        else if(tick_1==1'b1)
            begin
                 if(counting_down)
                 begin
                        if(count1==16'd0000)begin
                            counting_down<=1'b0;
                            count1<=16'd0000;
                        end
                        else 
                            count1<=count1-1;
                    
                 end
                 else if(reaction_done)
                 begin
                            if(button==1'b1)
                            begin
                                reaction_done<=1'b0;
                            end
                            else if (count1<16'd9999)
                            begin
                                  count1<=count1+1;
                            end
                 end
            
        end
    end
  
   assign thous = (count1 / 1000) % 10;  // Get thousands digit only
assign hund  = (count1 / 100) % 10;   // Get hundreds digit only
assign tens  = (count1 / 10) % 10;    // Get tens digit only
assign units = count1 % 10;           // Get units digit only
endmodule

