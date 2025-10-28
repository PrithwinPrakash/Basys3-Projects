
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.10.2025 18:32:31
// Design Name: 
// Module Name: top_bcd
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_bcd(
input clk,rst,button,
output reg[6:0]seg,
output reg[3:0] an

);
    wire [3:0] tens,units,hund,thous;
     
    bcd BC1(.clk(clk),.reset(rst),.button(button),.tens(tens),.units(units),.hund(hund),.thous(thous));
    reg [3:0]current_digits;
    reg [19:0] refresh;
    wire [1:0]scan;
    
    always@(posedge clk or posedge rst)
        if(rst)begin
            refresh<=20'd0;
        end
        else begin
            refresh<=refresh+1'b1;  
        end
     assign scan=refresh[19:18]; 
  always @(*) begin
        case(scan)
            2'b00: begin
                an = 4'b1110;
                current_digits = units;
            end
            2'b01: begin
                an = 4'b1101;
                current_digits = tens;
            end
            2'b10: begin
                an = 4'b1011;
                current_digits = hund;
            end
            2'b11: begin
                an = 4'b0111;
                current_digits = thous;
            end
            
        endcase
        seg=digit_seg(current_digits);
       end
    function [6:0] digit_seg;
        input [3:0] digit;
        reg  [6:0] seg;
        
         begin   
            case (digit)
            4'b0001 : seg = 7'b1111001;   // 1
            4'b0010 : seg = 7'b0100100;   // 2
            4'b0011 : seg = 7'b0110000;   // 3
            4'b0100 : seg = 7'b0011001;   // 4
            4'b0101 : seg = 7'b0010010;   // 5
            4'b0110 : seg = 7'b0000010;   // 6
            4'b0111 : seg = 7'b1111000;   // 7
            4'b1000 : seg = 7'b0000000;   // 8
            4'b1001 : seg = 7'b0010000;   // 9
            default : seg = 7'b1000000;   // 0
            endcase
            digit_seg=seg;
        end
   endfunction
  
endmodule

