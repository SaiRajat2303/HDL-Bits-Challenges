module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  

    parameter s0 =0, s1 =1 ;
    reg state, next_state;

    always @(*) 
    begin
        case(state)
            s0 : begin
                if(bump_left == 1'b1)
                    begin
                        if(bump_right == 1'b1 || bump_right == 1'b0)
                            next_state = s1;
                    end
                else
                    next_state = s0;
            end
            s1 : begin
                if(bump_right == 1'b1)
                    begin
                        if(bump_left == 1'b1 || bump_left == 1'b0)
                            next_state = s0;
                    end
                else
                    next_state = s1;
            end
        endcase
    end

    always @(posedge clk, posedge areset) 
    begin
        if(areset == 1'b1)
            state = s0;
        else
            state = next_state;
    end

    // Output logic
    assign walk_left = !(state);
    assign walk_right = state;

endmodule
