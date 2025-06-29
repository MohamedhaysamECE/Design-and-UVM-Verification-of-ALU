    class my_env extends uvm_env;
        my_agent a1;
        my_scoreboard s2;
        my_subscriber s3;
        `uvm_component_utils(my_env);
        virtual intf my_vif;

        function new(string name = "my_env", uvm_component parent = null) ;
            super.new(name,parent);
        endfunction

        function void build_phase (uvm_phase phase) ;
            super.build_phase (phase);
            a1 = my_agent::type_id::create("a1",this);
            s2 = my_scoreboard::type_id::create("s2" , this);
            s3 = my_subscriber::type_id::create("s3" , this);
            if(!uvm_config_db #(virtual intf)::get(this,"", "my_vif", my_vif))
                `uvm_fatal(get_type_name(), "get failed for resource in this scope");                
            uvm_config_db #(virtual intf)::set(this,"a1", "my_vif", my_vif);
            $display("my_env build_phase phase") ;
        endfunction 

        function void connect_phase (uvm_phase phase);
            super.connect_phase(phase);
            $display("my_env connenct phase") ;
            a1.agent_ap.connect(s2.scb_exp);
            a1.agent_ap.connect(s3.analysis_export);
        endfunction

        task run_phase (uvm_phase phase);
            super.run_phase(phase);
            $display("my_env run phase") ;
        endtask        
    endclass
