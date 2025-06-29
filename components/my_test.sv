    class my_test extends uvm_test;
        my_env e1;
        my_sequence s5;
        `uvm_component_utils(my_test);
        virtual intf my_vif;

        function new(string name = "my_test", uvm_component parent = null) ;
            super.new(name,parent);
        endfunction

         function void build_phase (uvm_phase phase) ;
            super.build_phase (phase);
            e1 = my_env::type_id::create("e1",this);
            s5 =my_sequence::type_id::create("s5",this);
            
            if(!uvm_config_db #(virtual intf)::get(this,"", "my_vif", my_vif))
                `uvm_fatal(get_type_name(), "get failed for resource in this scope");
            uvm_config_db #(virtual intf)::set(this,"e1", "my_vif", my_vif);
            
            $display("my_test build_phase phase");
        endfunction

        function void connect_phase (uvm_phase phase);
            super.connect_phase(phase);
            $display("my_test connect_phase phase");
        endfunction

        task run_phase (uvm_phase phase);
            super.run_phase(phase);
            $display("my_test run phase");
            phase.raise_objection(this);
                s5.start(e1.a1.s1);
            phase.drop_objection(this);
        endtask
    endclass 
