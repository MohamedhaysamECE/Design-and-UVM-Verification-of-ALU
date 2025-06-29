    class my_scoreboard extends uvm_scoreboard;
        `uvm_component_utils(my_scoreboard);
        uvm_analysis_export #(my_sequence_item) scb_exp;
        uvm_tlm_analysis_fifo #(my_sequence_item) my_fifo;
        my_sequence_item my_seq;
        my_sequence_item seq_Q[$];

        function new(string name = "my_scoreboard", uvm_component parent = null) ;
            super.new(name,parent);
        endfunction

        function void build_phase (uvm_phase phase) ;
            super.build_phase (phase);
             $display("my_scoreboard build_phase phase");
             //my_seq = my_sequence_item::type_id::create("my_seq");
             my_fifo = new("my_fifo",this);
             scb_exp = new("scb_exp", this);
        endfunction
        function void connect_phase (uvm_phase phase);
            super.connect_phase(phase);
            $display("my_scoreboard connect_phase phase");
            scb_exp.connect(my_fifo.analysis_export);
        endfunction

        task run_phase (uvm_phase phase);
            super.run_phase(phase);
             $display("my_scoreboard run phase");
                 forever begin
                    my_fifo.get(my_seq);
                    seq_Q.push_back(my_seq);
                    if(seq_Q.size()) begin
                        my_seq = seq_Q.pop_front();
                        compare(my_seq);
                    end
                 end    
                endtask

        function void compare(my_sequence_item seq1);
            logic signed [31:0] Exp_ALU_out;

                    case(seq1.OP)

                    3'b000: Exp_ALU_out = seq1.A + seq1.B ; //Addition

                    3'b001: Exp_ALU_out = seq1.A - seq1.B ; //subtraction

                    3'b010: Exp_ALU_out = seq1.A * seq1.B ; //multiplication

                    3'b011: begin
                        if (seq1.B == 0) begin
                            `uvm_error(get_type_name(), "Division by zero error") ;
                        end else begin
                            Exp_ALU_out = {seq1.A / seq1.B, seq1.A % seq1.B};
                        end
                    end

                    3'b100: Exp_ALU_out = seq1.A | seq1.B ; //or gate

                    3'b101: Exp_ALU_out = seq1.A & seq1.B ; //and gate

                    3'b110: Exp_ALU_out = ~seq1.A ; //not

                    3'b111: Exp_ALU_out = ~seq1.B ; //not

                    default: Exp_ALU_out = 32'b0;

                    endcase

                    if(Exp_ALU_out == seq1.ALU_OUTPUT)
                        `uvm_info(get_type_name(), $sformatf("scoreboard success: Expected = %0d, Actual = %0d", Exp_ALU_out, seq1.ALU_OUTPUT), UVM_LOW)
                    else begin
                        `uvm_info(get_type_name(), $sformatf("scoreboard Failure: Expected = %0d, Actual = %0d", Exp_ALU_out, seq1.ALU_OUTPUT), UVM_LOW)
                    end
        endfunction         

    endclass 
