module ALU(A, B, OP, ALU_OUTPUT);
//input
 input signed [15:0] A, B;
 input signed[2:0] OP;//(operation code)
//output
 output reg signed [31:0] ALU_OUTPUT;
//logical steps
 always @(A, B, OP)
 begin
  case(OP)

  3'b000: ALU_OUTPUT = A+B ; //Addition

  3'b001: ALU_OUTPUT = A-B ; //subtraction

  3'b010: ALU_OUTPUT = A * B ; //multiplication

  3'b011: if (B != 0) 
          ALU_OUTPUT =  {A / B, A % B} ; //division

  3'b100: ALU_OUTPUT = A | B ; //or gate

  3'b101: ALU_OUTPUT = A & B ; //and gate

  3'b110: ALU_OUTPUT = ~A ; //not

  3'b111: ALU_OUTPUT = ~B ; //not

  default: ALU_OUTPUT = 32'b0;

  endcase
 end
endmodule
