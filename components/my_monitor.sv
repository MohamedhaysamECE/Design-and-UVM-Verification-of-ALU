    class my_monitor extends uvm_monitor;
        `uvm_component_utils(my_monitor);
        virtual intf my_vif;
        uvm_analysis_port#(my_sequence_item) mon_ap;
        my_sequence_item my_seq;

        function new(string name = "my_monitor", uvm_component parent = null) ;
            super.new(name,parent);
            mon_ap= new("mon_ap", this);
        endfunction

        function void build_phase (uvm_phase phase) ;
            super.build_phase (phase);
            $display("my_monitor build_phase phase");
            my_seq = my_sequence_item::type_id::create("my_seq");
            if(!uvm_config_db #(virtual intf)::get(this,"", "my_vif", my_vif))
                `uvm_fatal(get_type_name(), "get failed for resource in this scope");

        endfunction
        function void connect_phase (uvm_phase phase);
            super.connect_phase(phase);
            $display("my_monitor connect_phase phase");
        endfunction

        task run_phase (uvm_phase phase);
           //my_sequence_item txn = new;
            super.run_phase(phase);
            $display("my_monitor run phase");
            forever begin
                #10ns; //wait for ALU to compute
                my_seq.A = my_vif.A;
                my_seq.B = my_vif.B;
                my_seq.OP = my_vif.OP;
                my_seq.ALU_OUTPUT = my_vif.ALU_OUTPUT;
                #1ns;
                $display("monitor A = %0d, B = %0d, OP = %0d", my_seq.A, my_seq.B, my_seq.OP);
                $display("monitor ALU_OUTPUT = %p", my_seq.ALU_OUTPUT);
                mon_ap.write(my_seq);
            end         
        endtask
    endclass 
