module player_collision(clock, x, y, other_x, other_y, ball_x, ball_y, move_right, move_left, move_up, move_down);
	input clock;
	
	//current player position
	input [7:0] x;
	input [6:0] y;
	
	//takes current positon of other player (for player collision)
	input [7:0] other_x, ball_x;
	input [6:0] other_y, ball_y;
	
	output reg move_right, move_left, move_up, move_down;
	
	//player size used to determine if the player is colliding
	localparam player_size = 3'b101;
	localparam offset = 1'b1;
	
	always @(posedge clock) begin
	
	//player collison ===================================================================================================
		//moving right collision
		if(x == other_x - player_size - offset && y == other_y)
			move_right <= 0;
		else if(x == other_x - player_size - offset && y >= other_y && y <= other_y + player_size + offset )
			move_right <= 0;
		else if(x == other_x - player_size - offset  && y >= other_y - player_size - offset  && y <= other_y)
			move_right <= 0;
		else if(x + player_size == ball_x && ball_y >= y && ball_y <= y + player_size)
			move_right <= 0;
		else
			move_right <= 1;
			
		//moving left collision
		if(x == other_x + player_size + offset  && y == other_y)
			move_left <= 0;
		else if(x == other_x + player_size + offset  && y >= other_y && y <= other_y + player_size + offset )
			move_left <= 0;
		else if(x == other_x + player_size + offset  && y >= other_y - player_size - offset  && y <= other_y)
			move_left <= 0;
		else if(x == ball_x + offset && ball_y >= y && ball_y <= y + player_size)
			move_left <= 0;
		else
			move_left <= 1;
		
		//moving up collison
		if(y == other_y + player_size + offset && x == other_x)
			move_up <= 0;
		else if(y == other_y + player_size + offset && x >= other_x && x <= other_x + player_size + offset)
			move_up <= 0;
		else if(y == other_y + player_size + offset && x >= other_x - player_size - offset && x <= other_x)
			move_up <= 0;
		else if(ball_y + offset == y && ball_x >= x && ball_x <= x + player_size)
			move_up <= 0;
		else
			move_up <= 1;
			
		//moving down collision
		if(y == other_y - player_size - offset  && x == other_x)
			move_down <= 0;
		else if(y == other_y - player_size - offset  && x >= other_x && x <= other_x + player_size + offset)
			move_down <= 0;
		else if(y == other_y - player_size - offset  && x >= other_x - player_size - offset  && x <= other_x)
			move_down <= 0;
		else if(ball_y == y + player_size && ball_x >= x && ball_x <= x + player_size)
			move_down <= 0;
		else
			move_down <= 1;		
end
endmodule
