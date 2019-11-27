//Moves character on 160x120 vga
module move_character(
	clock, 
	left,
	right,
	up, 
	down,
	xPos_in,
	yPos_in,
	xPos_out,
	yPos_out, 
	resetn,
	resetGame,
	player, 
	allowed_move_r,
	allowed_move_l,
	allowed_move_u,
	allowed_move_d
	);

	//speed controlled clock
	input clock;

	//user control inputs
	input left, right, up, down;

	//game control inputs
	input resetn, resetGame, player;
	
	//movement control inputs
	input allowed_move_r, allowed_move_l, allowed_move_u, allowed_move_d; 
	
	//takes current position of the character
	input [7:0] xPos_in;
	input [6:0] yPos_in;

	//output position of the character
	output reg [7:0] xPos_out;
	output reg [6:0] yPos_out;
//========================================================================================================================	
	
//the x axis scale that the character moves by
  localparam x_ms = 1;

 //the y axis scale that the character moves by
  localparam y_ms = 1;
  
  //player size used to determine if the player is out of bounds
  localparam player_size = 3'b101;

 //border bounds
  localparam left_border = 8'b00001000; 
  localparam right_border = 8'b10011000;
  localparam top_border = 7'b0001000; 
  localparam bottom_border = 7'b1110000; 
  
  //player starting positions
  localparam p1_start_x = 8'b00101000;
  localparam p1_start_y = 7'b0111000;
  localparam p2_start_x = 8'b01111000;
  localparam p2_start_y = 7'b0111000;
//========================================================================================================================	
	always @(posedge clock) begin
		//moves left
		if(left && !right && !up && !down) begin
			if(xPos_in == left_border || !allowed_move_l)
				xPos_out <= xPos_in;
			else
				xPos_out <= xPos_in - x_ms;
		end
		//moves right
		if(!left && right && !up && !down) begin
			if(xPos_in == right_border - player_size || !allowed_move_r)
				xPos_out <= xPos_in;
			else
				xPos_out <= xPos_in + x_ms;
		end
		//moves up
		if(!left && !right && up && !down) begin
			if(yPos_in == top_border || !allowed_move_u)
				yPos_out <= yPos_in;
			else
				yPos_out <= yPos_in - y_ms;
		end
		
		//moves down
		if(!left && !right && !up && down) begin
			if(yPos_in == bottom_border - player_size || !allowed_move_d)
				yPos_out <= yPos_in;
			else
				yPos_out <= yPos_in + y_ms;
		end
		
		//resets the player positions once reset key or someone scores
		if (!resetn || resetGame) begin
			if(player == 1'b1)
				xPos_out <= p1_start_x;
			else
				xPos_out <= p2_start_x;
				
			yPos_out <= p2_start_y;
		end
	end
endmodule

//========================================================================================================================	
//This controls how fast we want the characters to move using a downcounter
module rateDivider(clock, speed, q);
	input clock;
	input [26:0] speed;
	output reg [26:0] q;
	always @(posedge clock) begin
		if(q == 27'b0)
			q <= speed;
		else
			q <= q - 1;
	end
endmodule

