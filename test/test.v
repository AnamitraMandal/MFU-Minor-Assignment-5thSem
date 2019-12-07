`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    18:30:36 11/09/2019
// Design Name:
// Module Name:    test
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

//compute modes
`define addition 3'b000
`define sub 3'b001
`define bitwiseor 3'b010
`define bitwiseand 3'b011
`define bitnot 3'b100
`define logicalleft 3'b101
`define logicalright 3'b110

module test(
    input [7:0] input_bus,//input bus
	 input mode_input_num1,//input mode for first number
	 input mode_input_num2,//input mode for second number
	 input mode_compute,
	 input mode_display,
	 input mode_reset,
	 input clock,//clock input
    output [7:0] result//final result
);

//declarations and intitialisations
reg [25:0] debounce = 0;//initalize debounce register
reg [1:0] state = 2'b00;//define different display states
reg [7:0] display_num;//register to store final number to be displayed
reg [7:0] num1;//register to store first input
reg [7:0] num2;//register to store second input
reg [7:0] temp_result;//regsiter to store computed answer
reg [7:0] compute_mode;//register to select computation mode


assign result = display_num;

//for every positive egde of clock increment debounce
always @(posedge clock)
	begin
		if(mode_input_num1  == 1)
			begin
				//insert a
				num1 = input_bus;
				state = 2'b00;
				debounce <= debounce+1;
			end

		else if(mode_input_num2  == 1)
			begin
				//insert b
				num2 = input_bus;
				state = 2'b00;
				debounce <= debounce+1;
			end

		else if(mode_compute  == 1)
			begin
				debounce <= debounce+1;
				state = 2'b00;
				compute_mode = input_bus;
					case(compute_mode[2:0])
					  `addition://Addition
								temp_result = num1 + num2;
					  `sub: //Subtraction
							temp_result = num1 - num2 ;
					  `bitwiseor: //bit wise or
							temp_result = num1 | num2;
					  `bitwiseand://bit wise and
							temp_result = num1&num2;
					  `bitnot: //invert first number
							temp_result = ~num1;
					  `logicalright: //Logical shift right first number
							temp_result = num1>>1;
					  `logicalleft: //Logical shift left first number
							temp_result = num1<<1;

					  default: temp_result = num1 + num2;//default case addition
				  endcase
			end
			else if(mode_reset == 1)
				//reset mode
				begin
					state = 2'b00;
					display_num = 0;
					num1 = 0;
					num2 = 0;
					temp_result = 0;
					debounce <= debounce+1;
				end
			else if(debounce == 26'b11_1111_1111_1111_1111_1111_1111)
				//when debounce register is equal to the above number then enter this block
				begin
				if(mode_display == 1)
				//check if mode is display
					begin
						//reset debounce to 0 so that this block doesn't run again until the unwanted pulses die-out
						debounce <= 0;
						case(state)
							2'b00:
								begin
									display_num = num1;//display first number
									state = 2'b01;//move to next state
								end
							2'b01:
								begin
									display_num = num2;//display second number
									state = 2'b10;//move to next state
								end
							2'b10:
								begin
									display_num = temp_result;//display computed result
									state = 2'b11;//move to next state
								end
							2'b11:
								begin
									display_num = 8'b00000000;//display 0, i.e turn off all o/p leds
									state = 2'b00;//reset state
								end
						endcase
					end
			end

			else debounce<=debounce+1;//for every clock pulse increment debounce
		end
endmodule
