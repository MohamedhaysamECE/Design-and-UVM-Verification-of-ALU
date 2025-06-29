   class my_driver extends uvm_driver #(my_sequence_item);
        `uvm_component_utils(my_driver);
        virtual intf my_vif;
        my_sequence_item my_seq;
        function new(string name = "my_driver", uvm_component parent = null) ;
            super.new(name,parent);
        endfunction

        function void build_phase (uvm_phase phase) ;
            super.build_phase (phase);
            $display("my_driver build_phase phase");
            if(!uvm_config_db #(virtual intf)::get(this,"", "my_vif", my_vif))
                `uvm_fatal(get_type_name(), "get failed for resource in this scope");
        endfunction
        function void connect_phase (uvm_phase phase);
            super.connect_phase(phase);
            $display("my_driver connect_phase phase");
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            $display("my_driver run phase");
            forever begin
              seq_item_port.get_next_item(my_seq);
              $display("driver item = %p", my_seq);
              my_vif.A = my_seq.A; 
              my_vif.B = my_seq.B; 
              my_vif.OP = my_seq.OP;
              #10ns; //wait for ALU to compute
              $display("driver A = %0d, B = %0d, OP = %0d", $signed(my_seq.A), $signed(my_seq.B), $signed(my_seq.OP));
              my_vif.ALU_OUTPUT = my_seq.ALU_OUTPUT;
              $display("driver ALU_OUTPUT = %p", $signed(my_vif.ALU_OUTPUT));
              seq_item_port.item_done();
            end
        endtask
    endclass
