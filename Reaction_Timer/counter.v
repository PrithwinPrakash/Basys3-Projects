module counter(
    input clk,rst,
    output reg tick_1
);

    reg [26:0]count;
    
    //parameter count_max=27'd99_999_999;//for normal counter
    parameter count_max=27'd99_999; //reaction time project
    //parameter count_max=27'd99;//testing 
     always@(posedge clk or posedge rst)
     begin
        if(rst)
        begin
            count<=27'd0000_0000;
            tick_1<=1'b0;
        end
        else if(count==count_max) 
        begin
            count<=27'd0000000;
            tick_1<=1'b1;
        end
        else begin
            count<=count+1;
            tick_1<=1'b0;
        end
     end

endmodule
