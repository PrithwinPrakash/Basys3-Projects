module led_peripheral(
    input clk, rst,
    input [7:0] write_data,
    input write_enable, 
    input [7:0] write_address,
    output reg [15:0] led
);
    
    
    reg [7:0] led_control;
    reg [7:0] led_data1;
    reg [7:0] led_data2;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            led_control <= 8'd0;
            led_data1   <= 8'd0;
            led_data2   <= 8'd0;
        end 
        else begin
            if (write_enable) begin
                case (write_address)
                    8'h00: led_control <= write_data;
                    8'h01: led_data1   <= write_data;
                    8'h02: led_data2   <= write_data;
                    default: ;
                endcase
            end
        end
    end

    always @(*) begin
        if (led_control[0] == 0)
            led = 16'h0000;
        else
            led = {led_data2, led_data1};
    end

endmodule
