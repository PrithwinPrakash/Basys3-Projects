`include"led_peripheral.v"
module led_peripheral_tb;
    reg clk,rst;
    reg [7:0]write_data;
    reg write_enable;
    reg [7:0]write_address;
    wire [15:0]led;

    led_peripheral lp1 (
            .clk(clk),
            .rst(rst),
            .write_data(write_data),
            .write_enable(write_enable),
            .write_address(write_address),
            .led(led)
        );

    initial begin
        
        rst=0;
        clk=0;
        
    end

    always #5 clk= ~clk;

    initial begin

        $dumpfile("led.vcd");
        $dumpvars(0,led_peripheral_tb);
        rst=1;
        #10;

        rst=0;
        write_enable=0;
        write_data=8'h00;
        write_address=8'h00;
        #10;

        write_enable=1;
        write_data=8'h55;
        write_address=8'h01;
        #10;

        write_data=8'hAA;
        write_address=8'h02;
        #10;

        write_data=8'h01;
        write_address=8'h00;
        #50;

        write_enable=0;
        #30;
        $finish;
    end

endmodule