    class my_agent extends uvm_agent;
        my_driver d1;
        my_monitor m1;
        my_sequencer s1;
        `uvm_component_utils(my_agent);
        uvm_analysis_port#(my_sequence_item) agent_ap;
        virtual intf my_vif;

        function new(string name = "my_agent", uvm_component parent = null) ;
            super.new(name,parent);
        endfunction

        function void build_phase (uvm_phase phase) ;
            super.build_phase (phase);
            d1 = my_driver::type_id::create("d1", this);
            m1 = my_monitor::type_id::create("m1", this);
            s1 = my_sequencer::type_id::create("s1", this);
            agent_ap = new("agent_ap", this);
            if(!uvm_config_db #(virtual intf)::get(this,"", "my_vif", my_vif))
                `uvm_fatal(get_type_name(), "get failed for resource in this scope");
            uvm_config_db #(virtual intf)::set(this,"d1", "my_vif", my_vif);
            uvm_config_db #(virtual intf)::set(this,"m1", "my_vif", my_vif);
            $display("my_agent build_phase phase");
        endfunction

        function void connect_phase (uvm_phase phase);
            super.connect_phase(phase);
            $display("my_agent connect_phase phase");
            m1.mon_ap.connect(agent_ap);
            d1.seq_item_port.connect(s1.seq_item_export);
        endfunction

        task run_phase (uvm_phase phase);
            super.run_phase(phase);
             $display("my_agent run phase");
        endtask
    endclass 
