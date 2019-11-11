module main(CLOCK_50, left, right, up);
	input CLOCK_50;

	//user inputs
	input left, right, up;

	wire [9:0] w1;
	wire [8:0] w2;
	
	//player 1 registers
	reg [9:0] player1_x;
	reg [8:0] player1_y;

	//player 2 registers
	reg [9:0] player2_x;
	reg [8:0] player2_y;

	
	
	//preset start positions
	localparam ground = 9'b000110010; // 50 pixels
	localparam p1_start_x = 10'b0110100100; //420 pixels
	localparam p2_start_x = 10'b0011011100; //220 pixels
	
	//Player 1 start values
	initial player1_x = p1_start_x;
	initial player1_y = ground;

	//player 2 start values
	initial player2_x = p2_start_x;
	initial player2_y = ground;

	move_character player1(CLOCK_50, left, right, up, player1_x ,player1_y, w1, w2); // need to change rate being clocked at

	always @ (*) begin
		player1_x <= w1;
		player1_y <= w2;
	end
endmodule

//Moves character
//note standard vga is 640 x 480 pixels
// enable must be from the rate counter to control the speed

module move_character(enable, left, right, up, xPos_in, yPos_in, xPos_out, yPos_out);
	
	input enable;

	//user inputs
	input left, right, up;
	
	//takes current position of the character
	input [9:0] xPos_in;
	input [8:0] yPos_in;

	//output position of the character
	output reg [9:0] xPos_out;
	output reg [8:0] yPos_out;
	
	//the x axis scale that the character moves by
	localparam x_ms = 1;

	//the y axis scale that the character moves by (aka 1 jump = how many pixels)
	localparam y_ms = 12;

	//left border is at pixel 0
	localparam left_border = 10'b0;
	
	//right border is at pixel 640
	localparam right_border = 10'b1010000000;
	
	//ground border is at 50 pixels
	localparam ground = 9'b000110010;

	//gravity scale >>>>> need to make up a scale
	localparam g = y_ms/4;
	

	always @(posedge enable) begin
		
		//falling back down
		if (yPos_in > ground)
			yPos_out <= yPos_in - g;
		//moves left
		if(left && !right && !up) begin
			//at left border, no movement left allowed
			if(xPos_in == left_border)
				xPos_out = xPos_in;
			else
				xPos_out = xPos_in - 1;
		end
		//moves right
		if(!left && right && !up) begin
			//at right border, no movement right allowed
			if(xPos_in == right_border)
				xPos_out <= xPos_in;
			else
				xPos_out <= xPos_in + x_ms;
		end
		//moves up
		if(!left && !right && up) begin
			//no double jump
			if(yPos_in == ground)
				yPos_out <= yPos_in + y_ms;
		end
		//moves left - up
		if(left && !right && up) begin
			//moves left
			xPos_out <= xPos_in - x_ms;
			//moves up only if grounded
			if(yPos_in == ground)
				yPos_out <= yPos_in + y_ms;
		end
		//moves right - up
		if(!left && !right && up) begin
			//moves right
			xPos_out <= xPos_in + x_ms;
			//moves up only if grounded
			if(yPos_in == ground)
				yPos_out <= yPos_in + y_ms;
		end
	end


endmodule

//This controls how fast we want the characters to move
module rateDivider(clock, speed, q);
	input clock;
	input [26:0] speed;
	output reg [26:0] q;
	initial q = 27'b0;
	always @(posedge clock) begin
		if(q == 27'b0)
			q <= speed;
		else
			q = q - 1;
	end

endmodule
