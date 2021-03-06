/*
   This file was generated automatically by the Mojo IDE version B1.3.6.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module mojo_top_0 (
    input clk,
    input rst_n,
    output reg [7:0] led,
    output reg spi_miso,
    output reg [3:0] spi_channel,
    output reg avr_rx,
    output reg [2:0] output_,
    input sum,
    input carry,
    output reg [23:0] io_led,
    output reg [7:0] io_seg,
    output reg [3:0] io_sel,
    input [4:0] io_button,
    input [23:0] io_dip
  );
  
  
  
  reg rst;
  
  wire [1-1:0] M_reset_cond_out;
  reg [1-1:0] M_reset_cond_in;
  reset_conditioner_1 reset_cond (
    .clk(clk),
    .in(M_reset_cond_in),
    .out(M_reset_cond_out)
  );
  localparam IDLE_testState = 4'd0;
  localparam A_testState = 4'd1;
  localparam B_testState = 4'd2;
  localparam C_testState = 4'd3;
  localparam AB_testState = 4'd4;
  localparam AC_testState = 4'd5;
  localparam BC_testState = 4'd6;
  localparam ABC_testState = 4'd7;
  localparam O_testState = 4'd8;
  localparam FAIL_testState = 4'd9;
  
  reg [3:0] M_testState_d, M_testState_q = IDLE_testState;
  wire [3-1:0] M_ctr_value;
  counter_2 ctr (
    .clk(clk),
    .rst(rst),
    .value(M_ctr_value)
  );
  reg [26:0] M_counter_d, M_counter_q = 1'h0;
  
  wire [8-1:0] M_num_to_seg_out;
  reg [3-1:0] M_num_to_seg_in;
  decoder_3 num_to_seg (
    .in(M_num_to_seg_in),
    .out(M_num_to_seg_out)
  );
  
  always @* begin
    M_testState_d = M_testState_q;
    M_counter_d = M_counter_q;
    
    M_num_to_seg_in = M_ctr_value;
    io_seg = 8'hff;
    io_sel = 4'h1;
    M_reset_cond_in = ~rst_n;
    rst = M_reset_cond_out;
    led = 8'h00;
    spi_miso = 1'bz;
    spi_channel = 4'bzzzz;
    avr_rx = 1'bz;
    io_led = 24'h000000;
    output_[0+2-:3] = io_dip[16+0+2-:3];
    io_led[16+0+0-:1] = sum;
    io_led[16+1+0-:1] = carry;
    if (io_dip[16+0+0-:1] ^ io_dip[16+1+0-:1] ^ io_dip[16+2+0-:1] == sum) begin
      io_led[16+7+0-:1] = 1'h1;
    end
    if ((io_dip[16+0+0-:1] & io_dip[16+1+0-:1]) | ((io_dip[16+0+0-:1] ^ io_dip[16+1+0-:1]) & io_dip[16+2+0-:1]) == carry) begin
      io_led[16+6+0-:1] = 1'h1;
    end
    if (M_counter_q[0+25-:26] == 1'h0) begin
      
      case (M_testState_q)
        O_testState: begin
          if (carry == 1'h0 & sum == 1'h0) begin
            M_testState_d = IDLE_testState;
          end else begin
            M_testState_d = FAIL_testState;
          end
        end
        ABC_testState: begin
          if (carry == 1'h1 & sum == 1'h1) begin
            M_testState_d = O_testState;
          end else begin
            M_testState_d = FAIL_testState;
          end
        end
        AC_testState: begin
          if (carry == 1'h1 & sum == 1'h0) begin
            M_testState_d = ABC_testState;
          end else begin
            M_testState_d = FAIL_testState;
          end
        end
        BC_testState: begin
          if (carry == 1'h1 & sum == 1'h0) begin
            M_testState_d = AC_testState;
          end else begin
            M_testState_d = FAIL_testState;
          end
        end
        AB_testState: begin
          if (carry == 1'h1 & sum == 1'h0) begin
            M_testState_d = BC_testState;
          end else begin
            M_testState_d = FAIL_testState;
          end
        end
        C_testState: begin
          if (carry == 1'h0 & sum == 1'h1) begin
            M_testState_d = AB_testState;
          end else begin
            M_testState_d = FAIL_testState;
          end
        end
        B_testState: begin
          if (carry == 1'h0 & sum == 1'h1) begin
            M_testState_d = C_testState;
          end else begin
            M_testState_d = FAIL_testState;
          end
        end
        A_testState: begin
          if (carry == 1'h0 & sum == 1'h1) begin
            M_testState_d = B_testState;
          end else begin
            M_testState_d = FAIL_testState;
          end
        end
        IDLE_testState: begin
          if (io_button[1+0-:1] == 1'h1) begin
            M_testState_d = A_testState;
          end
        end
        FAIL_testState: begin
          if (M_counter_q == 1'h0) begin
            M_testState_d = IDLE_testState;
          end
        end
      endcase
    end
    M_counter_d = M_counter_q + 1'h1;
    
    case (M_testState_q)
      O_testState: begin
        output_[0+2-:3] = 1'h0;
        io_seg = 8'h80;
        io_sel = 4'he;
      end
      ABC_testState: begin
        output_[0+2-:3] = 7'h6f;
        io_seg = 8'hf8;
        io_sel = 4'he;
      end
      AC_testState: begin
        output_[0+2-:3] = 7'h65;
        io_seg = 8'h82;
        io_sel = 4'he;
      end
      BC_testState: begin
        output_[0+2-:3] = 7'h6e;
        io_seg = 8'h92;
        io_sel = 4'he;
      end
      AB_testState: begin
        output_[0+2-:3] = 4'hb;
        io_seg = 8'h99;
        io_sel = 4'he;
      end
      C_testState: begin
        output_[0+2-:3] = 7'h64;
        io_seg = 8'hb0;
        io_sel = 4'he;
      end
      B_testState: begin
        output_[0+2-:3] = 4'ha;
        io_seg = 8'ha4;
        io_sel = 4'he;
      end
      A_testState: begin
        output_[0+2-:3] = 1'h1;
        io_seg = 8'hcf;
        io_sel = 4'he;
      end
      IDLE_testState: begin
        io_seg = ~M_num_to_seg_out;
        io_sel = 4'h0;
      end
      FAIL_testState: begin
        if (M_counter_q[24+0-:1] == 1'h1) begin
          io_sel = 4'h0;
          io_seg = 8'h8e;
        end
      end
    endcase
  end
  
  always @(posedge clk) begin
    M_counter_q <= M_counter_d;
    
    if (rst == 1'b1) begin
      M_testState_q <= 1'h0;
    end else begin
      M_testState_q <= M_testState_d;
    end
  end
  
endmodule
