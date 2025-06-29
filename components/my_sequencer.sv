
    class my_sequencer extends uvm_sequencer #(my_sequence_item);
        `uvm_component_utils(my_sequencer);

        function new(string name = "my_sequencer", uvm_component parent = null) ;
            super.new(name,parent);
        endfunction
        
        function void build_phase (uvm_phase phase) ;
            super.build_phase (phase);
            $display("my_sequencer build_phase phase");
        endfunction
        function void connect_phase (uvm_phase phase);
            super.connect_phase(phase);
            $display("my_sequencer connect_phase phase");
        endfunction

        task run_phase (uvm_phase phase);
            super.run_phase(phase);
            $display("my_sequencer run phase");
        endtask
    endclass 
