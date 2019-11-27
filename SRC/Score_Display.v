module hex_decoder(hex_digit, segments);
    input [3:0] hex_digit;
    output reg [6:0] segments;
   
    always @(*)
        case (hex_digit)
            4'h0: segments = 7'b100_0000;
            4'h1: segments = 7'b111_1001;
            4'h2: segments = 7'b010_0100;
            4'h3: segments = 7'b011_0000;
            4'h4: segments = 7'b001_1001;
            4'h5: segments = 7'b001_0010;
            4'h6: segments = 7'b000_0010;
            4'h7: segments = 7'b111_1000;
            4'h8: segments = 7'b000_0000;
            4'h9: segments = 7'b001_1000;
            4'hA: segments = 7'b000_1000;
            4'hB: segments = 7'b000_0011;
            4'hC: segments = 7'b100_0110;
            4'hD: segments = 7'b010_0001;
            4'hE: segments = 7'b000_0110;
            4'hF: segments = 7'b000_1110;   
            default: segments = 7'h7f;
        endcase
endmodule

/*
//Checks if the ball is in the goal and updates the score
module updateScore(clock, ball_x, ball_y, p1_score, p2_score, p1_score_out, p2_score_out, newGame);
	input clock, newGame;
	input [7:0] ball_x;
	input [6:0] ball_y;
	input [3:0] p1_score, p2_score;
	output reg [3:0] p1_score_out, p2_score_out;

	//size of ball
	localparam ball_size = 2'b10;
	//goal borders
	localparam left_border = 8'b00001000; 
	localparam right_border = 8'b10011000;
	localparam goal_top = 7'b101100;
	localparam goal_bot = 7'b1001110;
	
	
	always @ (posedge clock) begin
		if(ball_x + ball_size >= right_border && ball_y >= goal_top && ball_y <= goal_bot)
			p1_score_out <= p1_score + 1'b1;
		else if(ball_x <= left_border && ball_y >= goal_top && ball_y <= goal_bot)
			p2_score_out <= p2_score + 1'b1;
		else if(!newGame) begin
			p1_score_out <= 4'b0;
			p2_score_out <= 4'b0;
		end
		else begin
			p1_score_out <= p1_score;
			p2_score_out <= p2_score;
		end
	end

endmodule
*/