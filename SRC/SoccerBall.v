module soccerball(clock, player1_x, player1_y, player2_x, player2_y, p1_kicking, p2_kicking, resetn, resetGame, ball_x, ball_y, ball_x_out, ball_y_out);

	input clock, resetn, resetGame;
	
	input p1_kicking, p2_kicking;

	//takes current position of the character
	input [7:0] player1_x, player2_x, ball_x;
	input [6:0] player1_y, player2_y, ball_y;
	
	output reg [7:0] ball_x_out;
	output reg [6:0] ball_y_out;
	
	//how fast the ball moves
	localparam speed = 1'b1;

	//how far the ball kicks
	localparam kick_speed = 5'b11001;
	
	//player size used to determine if the player is out of bounds
	localparam player_size = 3'b101;	
	
	//size of ball
	localparam ball_size = 2'b10;
	
	//starting positon of ball
	localparam ball_start_x =  8'b01010000;
	localparam ball_start_y =  7'b0111100;
	
	//field borders
	localparam left_border = 8'b00001000; 
	localparam right_border = 8'b10011000;
	localparam top_border = 7'b0001000; 
	localparam bottom_border = 7'b1110001;
	
	//goal borders
	
	always @ (posedge clock) begin
	//if player 1 is moving the ball
		//move ball right
		if((player1_x + player_size == (ball_x - 1)) && (ball_y >= player1_y - ball_size) && (ball_y <= player1_y + player_size)) begin
			if((ball_x + ball_size) >= right_border)
				ball_x_out <= ball_x;
			else if(((ball_x + ball_size + kick_speed) > right_border) && p1_kicking)
				ball_x_out <= right_border;
			else if(p1_kicking)
				ball_x_out <= ball_x + kick_speed;
			else 
				ball_x_out <= ball_x + speed;
		end
		//move ball left
		if((player1_x == (ball_x + 1) + ball_size) && (ball_y >= player1_y - ball_size) && (ball_y <= player1_y + player_size)) begin
			if(ball_x <= left_border)
				ball_x_out <= ball_x;
			else if(((ball_x - kick_speed) < left_border) && p1_kicking)
				ball_x_out <= left_border;
			else if(p1_kicking)
				ball_x_out <= ball_x - kick_speed;
			else 
				ball_x_out <= ball_x - speed;
		end
		//move ball up
		if(((ball_y + 1) + ball_size == player1_y) && (ball_x >= player1_x - ball_size) && (ball_x <= player1_x + player_size)) begin
			if(ball_y <= top_border)
				ball_y_out <= ball_y;
			else if(((ball_y - kick_speed) < top_border) && p1_kicking)
				ball_y_out <= top_border;
			else if(p1_kicking)
				ball_y_out <= ball_y - kick_speed;
			else 
				ball_y_out <= ball_y - speed;
		end
		//move ball down
		if(((ball_y - 1) == player1_y + player_size) && (ball_x >= player1_x - ball_size) && (ball_x <= player1_x + player_size)) begin
			if(ball_y + ball_size >= bottom_border)
				ball_y_out <= ball_y;
			else if(((ball_y + ball_size +  kick_speed) > bottom_border) && p1_kicking)
				ball_y_out <= bottom_border;
			else if(p1_kicking)
				ball_y_out <= ball_y + kick_speed;
			else 
				ball_y_out <= ball_y + speed;
		end
		
		//NOT UDPATED
	//if player 2 is moving the ball
		if((player2_x + player_size == (ball_x - 1)) && (ball_y >= player2_y - ball_size) && (ball_y <= player2_y + player_size)) begin
			if((ball_x + ball_size) >= right_border)
				ball_x_out <= ball_x;
			else if(((ball_x + ball_size + kick_speed) > right_border) && p2_kicking)
				ball_x_out <= right_border;
			else if(p2_kicking)
				ball_x_out <= ball_x + kick_speed;
			else 
				ball_x_out <= ball_x + speed;
		end
		//move ball left
		if((player2_x == (ball_x + 1) + ball_size) && (ball_y >= player2_y - ball_size) && (ball_y <= player2_y + player_size)) begin
			if(ball_x <= left_border)
				ball_x_out <= ball_x;
			else if(((ball_x - kick_speed) < left_border) && p2_kicking)
				ball_x_out <= left_border;
			else if(p2_kicking)
				ball_x_out <= ball_x - kick_speed;
			else 
				ball_x_out <= ball_x - speed;
		end
		//move ball up
		if(((ball_y + 1) + ball_size == player2_y) && (ball_x >= player2_x - ball_size) && (ball_x <= player2_x + player_size)) begin
			if(ball_y <= top_border)
				ball_y_out <= ball_y;
			else if(((ball_y - kick_speed) < top_border) && p2_kicking)
				ball_y_out <= top_border;
			else if(p2_kicking)
				ball_y_out <= ball_y - kick_speed;
			else 
				ball_y_out <= ball_y - speed;
		end
		//move ball down
		if(((ball_y - 1) == player2_y + player_size) && (ball_x >= player2_x - ball_size) && (ball_x <= player2_x + player_size)) begin
			if(ball_y + ball_size >= bottom_border)
				ball_y_out <= ball_y;
			else if(((ball_y + ball_size +  kick_speed) > bottom_border) && p2_kicking)
				ball_y_out <= bottom_border;
			else if(p2_kicking)
				ball_y_out <= ball_y + kick_speed;
			else 
				ball_y_out <= ball_y + speed;
		end
		
		//reset
		if(!resetn || resetGame) begin
			ball_x_out <= ball_start_x;
			ball_y_out <= ball_start_y;
		end
	end
endmodule
