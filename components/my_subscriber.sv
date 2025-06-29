    class my_subscriber extends uvm_subscriber #(my_sequence_item);
        `uvm_component_utils(my_subscriber);
        //uvm_analysis_imp#(my_sequence_item, my_subscriber) sup_ap;
        my_sequence_item my_seq;
        covergroup ALU_cov;
            option.auto_bin_max = 0;
            cov_A:coverpoint my_seq.A {
                bins A_max = {32767};
                bins A_min = {-32768};
                bins A_any_value=default;
            } 
            cov_B:coverpoint my_seq.B {
                bins B_max = {32767};
                bins B_min = {-32768};
                bins B_any_value=default;
                bins B_zero = {16'd0};
            }
            cov_op:coverpoint my_seq.OP {
                bins op_add = {3'b000};
                bins op_sub = {3'b001};
                bins op_mul = {3'b010};
                bins op_div = {3'b011};
                bins op_or  = {3'b100};
                bins op_and = {3'b101};
                bins op_not_a = {3'b110};
                bins op_not_b = {3'b111};
            }
            cov_cross:cross cov_A, cov_B, cov_op {
                bins add_max = binsof(cov_A.A_max) && binsof(cov_B.B_max) && binsof(cov_op.op_add);
                bins add_min = binsof(cov_A.A_min) && binsof(cov_B.B_min) && binsof(cov_op.op_sub);

                bins sub_max = binsof(cov_A.A_max) && binsof(cov_B.B_max) && binsof(cov_op.op_sub);
                bins sub_min = binsof(cov_A.A_min) && binsof(cov_B.B_min) && binsof(cov_op.op_sub);
                
                bins mul_max = binsof(cov_A.A_max) && binsof(cov_B.B_max) && binsof(cov_op.op_mul);
                bins mul_min = binsof(cov_A.A_min) && binsof(cov_B.B_min) && binsof(cov_op.op_mul);

                bins div_max = binsof(cov_A.A_max) && binsof(cov_B.B_max) && binsof(cov_op.op_div);
                bins div_min = binsof(cov_A.A_min) && binsof(cov_B.B_min) && binsof(cov_op.op_div);

                bins div_zero = binsof(cov_A.A_max) && binsof(cov_B.B_zero) && binsof(cov_op.op_div);
            }
        endgroup
        function new(string name = "my_subscriber", uvm_component parent = null) ;
            super.new(name,parent);
           // sup_ap = new("sup_ap", this); 
           ALU_cov = new();           
        endfunction

        function void build_phase (uvm_phase phase) ;
            super.build_phase (phase);
            $display("my_subscriber build_phase phase");
        endfunction
        function void connect_phase (uvm_phase phase);
            super.connect_phase(phase);
             $display("my_subscriber connect_phase phase");
        endfunction

        task run_phase (uvm_phase phase);
            super.run_phase(phase);
            $display("my_subscriber run phase");
        endtask
        function void write(my_sequence_item t);
           `uvm_info("subscriber", $sformatf("Received data: %0d", t), UVM_MEDIUM);
           $cast(my_seq, t);
           ALU_cov.sample();
        endfunction
    endclass 
