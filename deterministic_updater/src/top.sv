`timescale 1ns / 1ps

module top(
    x_0,
    x_1,
    delta_0,
    delta_1,
    start,
    done,
    clk,
    rst
    );

parameter m = 2;
parameter n = 2;
parameter bl = 10;
parameter signed dG_equivalent = 25;

input unsigned [7:0] x_0, x_1, delta_0, delta_1;
input start;
input clk;
input rst;
output reg done; 

reg signed [8:0] x_t_0, x_t_1, delta_t_0, delta_t_1;
reg signed [8:0] x_t_0_next, x_t_1_next, delta_t_0_next, delta_t_1_next;

reg [m-1:0] mem_x [bl-1:0];
reg [n-1:0] mem_delta [bl-1:0];
reg [m-1:0] mem_x_next [bl-1:0];
reg [n-1:0] mem_delta_next [bl-1:0];
reg [$clog2(bl)-1:0] row_address, row_address_next; 

typedef enum logic [3:0] {IDLE, START, MEM_LOAD, RELU_x, RELU_delta, x_DECISION, delta_DECISION, DONE} ss_fsm;

ss_fsm state, state_next;
/*
generate
genvar ii;
for (ii = 0; ii<bl; ii++) begin
    always_ff @(posedge clk) begin
        if (rst) begin
            mem_x[ii] <= '0;
            mem_delta[ii] <= '0;
        end else begin
        
        end
        end  
         
end
endgenerate
*/

always_ff @(posedge clk) begin
    if (rst) begin
        state <= IDLE;
    end else begin
        state <= state_next;
    end    
end 


always_ff @(posedge clk) begin
    if (rst) begin
        for (int i = 0; i<bl; i++) begin
            mem_x[i] <= '0;
            mem_delta[i] <= '0;
        end
        x_t_0       <= '0;
        x_t_1       <= '0;
        delta_t_0   <= '0;
        delta_t_1   <= '0;
        row_address <= '0;
    end else begin
        for (int i = 0; i<bl; i++) begin
            mem_x[i] <= mem_x_next[i];
            mem_delta[i] <= mem_delta_next[i];
        end
        x_t_0       <= x_t_0_next;
        x_t_1       <=  x_t_1_next;
        delta_t_0   <= delta_t_0_next;
        delta_t_1   <= delta_t_1_next;
        row_address <= row_address_next;
    end    
end
    
always_comb begin
    for (int i = 0; i<bl; i++) begin
            mem_x_next[i] =  mem_x[i];
            mem_delta_next[i] =  mem_delta[i];
    end
    state_next = state;
    done = 1'b0;
    x_t_0_next=x_t_0;
    x_t_1_next=x_t_1;
    delta_t_0_next=delta_t_0;
    delta_t_1_next= delta_t_1;
    row_address_next = row_address;
    
    case (state) 
        IDLE : begin
            if (start) begin
                state_next = START;
            end
            row_address_next = '0;
        end
        START : begin
            
            x_t_0_next = $signed({1'b0,x_0});
            x_t_1_next=$signed({1'b0, x_1});
            delta_t_0_next=$signed({1'b0, delta_0});
            delta_t_1_next= $signed({1'b0, delta_1});
            
            state_next = MEM_LOAD;
        end
        MEM_LOAD : begin
            if (x_t_0 > 0) begin
                mem_x_next[row_address][0] = 1'b1;
            end else begin
                mem_x_next[row_address][0] = 1'b0;
            end
            
            if (x_t_1 > 0) begin
                mem_x_next[row_address][1] = 1'b1;
            end else begin
                mem_x_next[row_address][1] = 1'b0;
            end
            
            if (delta_t_0 > 0) begin
                mem_delta_next[row_address][0] = 1'b1;
            end else begin
                mem_delta_next[row_address][0] = 1'b0;
            end
            
            if (delta_t_1 > 0) begin
                mem_delta_next[row_address][1] = 1'b1;
            end else begin
                mem_delta_next[row_address][1] = 1'b0;
            end
            
            state_next = RELU_x;
        end
        RELU_x : begin
               
               if( (x_t_0 - dG_equivalent) > 0) begin
                    x_t_0_next = x_t_0-dG_equivalent;
               end else begin
                    x_t_0_next = '0;
               end
               if( (x_t_1 - dG_equivalent) > 0) begin
                    x_t_1_next = x_t_1-dG_equivalent;
               end else begin
                    x_t_1_next = '0;
               end
            
               state_next = x_DECISION;
        end
        x_DECISION : begin
            
            if ((x_t_0 == 0) && (x_t_1 == 0)) begin
                state_next = RELU_delta;
            end else begin
                state_next = delta_DECISION;
            end
            
        end
        RELU_delta : begin 
             x_t_0_next = $signed({1'b0,x_0});
             x_t_1_next=$signed({1'b0, x_1});
             
             if( (delta_t_0 - dG_equivalent) > 0) begin
                    delta_t_0_next = delta_t_0-dG_equivalent;
              end else begin
                    delta_t_0_next = '0;
              end
              if( (delta_t_1 - dG_equivalent) > 0) begin
                    delta_t_1_next = delta_t_1-dG_equivalent;
              end else begin
                    delta_t_1_next = '0;
              end
            
               state_next = delta_DECISION;
        end
        delta_DECISION : begin
            if ((delta_t_0 == 0) && (delta_t_1 == 0)) begin
                state_next = DONE;
            end else begin
                if ((row_address + 1 ) == bl) begin 
                    state_next = DONE;
                end else begin
                    row_address_next = row_address + 1;
                    state_next = MEM_LOAD;
   
                end
            end
        end
        DONE : begin
            done = 1'b1;
            state_next = IDLE;
        end
        default : begin
                
        end
    endcase
    
    
end

    
endmodule