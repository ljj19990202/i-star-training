module div_rill
(  
  clk,
  rst_n,
  i,
  a,   
  b,  
  temp_a,
  temp_b,
  yshang,  
  yyushu  
);  
input clk;
input rst_n;
input [15:0] a;
input [15:0] b;
output [15:0] yshang;
output [15:0] yyushu;
//for simulation
output [7:0] i;
output [31:0] temp_a, temp_b;
reg [15:0] yshang;
reg [15:0] yyushu;
wire [15:0] tempa, tempb;  
reg [31:0] temp_a, temp_b;  
assign tempa = a;
assign tempb = b;
reg [7:0] i;  
  
always @(posedge clk or negedge rst_n)  
begin
  if(!rst_n)
  begin
    i <= 8'd0;
    temp_a <= 16'h0;  
    temp_b <= 16'h0;  
    yshang <= 16'h0;  
    yyushu <= 16'h0; 
  end
  else case(i)
  8'd0:
  begin
    i = i + 1'b1;
    temp_a = {16'h0000,tempa};  
    temp_b = {tempb,16'h0000};   
  end
  8'd1:
  begin
    i = i + 1'b1;
    temp_a = {temp_a[30:0],1'b0};  
    if(temp_a[31:16] >= tempb)  
      temp_a = temp_a - temp_b + 1'b1;  
    else  
      temp_a = temp_a;   
  end
  8'd17:
  begin
    i = 8'd17;
    yshang <= temp_a[15:0];  
    yyushu <= temp_a[31:16]; 
  end
  default:
  begin
    i = i + 1'b1;
    temp_a = {temp_a[30:0],1'b0};  
    if(temp_a[31:16] >= tempb)  
      temp_a = temp_a - temp_b + 1'b1;  
    else  
      temp_a = temp_a;   
  end
  endcase
end  
  
endmodule  