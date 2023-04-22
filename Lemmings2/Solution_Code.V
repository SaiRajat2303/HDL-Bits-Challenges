module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
    parameter s0 = 2'b00 , s1 = 2'b01 , s2 = 2'b10 , s3 = 2'b11;
    //s0 - walking left , s1 - walking right
    //s2 - left to underground , s3 -right to underground
 
    reg [1:0] state , next_state ;
    
    
    always@(*) //state transition logic
        begin
            case(state)
                s0 : begin
                    if(ground == 1'b0)
                        next_state = s2;
                    
                    else
                        begin
                        if(bump_left == 1'b1)
                            next_state = s1;
                            else
                                next_state = s0;
                        end
                end
                
                s1: begin
                    if(ground == 1'b0)
                        next_state = s3;
                    
                    else
                        begin
                            if(bump_right == 1'b1)
                                next_state = s0;
                            else
                                next_state = s1;
                        end
                end
                
                s2:begin
                    if(ground == 1'b1)
                        next_state = s0;
                    else
                        next_state = s2;
                end
                
                s3:begin
                    if(ground == 1'b1)
                        next_state = s1;
                    else
                        next_state = s3;
                end
            endcase
        end
    
    always@(posedge clk , posedge areset)
        begin
            if(areset == 1'b1)
                state = s0;
            else
                state = next_state;
        end
    
    assign walk_left = (!state[0])&(!state[1]);
    assign walk_right = (state[0]&(!state[1]));
    assign aaah = state[1];
                      
    

endmodule
