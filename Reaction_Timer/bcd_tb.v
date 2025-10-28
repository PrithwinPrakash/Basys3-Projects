module tb_bcd;
    reg clk;
    reg reset;
    reg button;
    wire [3:0] tens;
    wire [3:0] units;
    wire [3:0] hund;
    wire [3:0] thous;

    // Define 1 microsecond (1000 ns) for convenience
    // This is based on your 100MHz clk and count_max=99
    localparam us = 1000; 
    
    bcd uut(
        .clk(clk),
        .reset(reset),
        .tens(tens),
        .units(units),
        .hund(hund),
        .thous(thous),
        .button(button)
    );
    
    // 100MHz Clock (10ns period)
    initial begin
        clk=1'b0;
        forever #5 clk=~clk;
    end
    
    initial begin
        // 1. Reset the system
        reset = 1'b1;
        button = 1'b0;
        #10;
        reset = 1'b0;

        // 2. Wait for the 3000-tick countdown to finish
        //    (3000 ticks * 1us/tick = 3000us)
        //    We wait a little extra (3001us) just to be safe.
        #(3001 * us);

        // 3. The counter is now at 0 and counting UP.
        //    Simulate a reaction time of 150 ticks (150us).
        //    The display should freeze at 0150.
        #(150 * us);
        
        // 4. Press the button to stop the counter
        button = 1'b1;
        
        // 5. Hold the button for 10 ticks (10us)
        #(10 * us);
        button = 1'b0;

        // 6. Wait 100us more to see the counter is frozen
        #(100 * us);
        $finish;
    end
    
endmodule