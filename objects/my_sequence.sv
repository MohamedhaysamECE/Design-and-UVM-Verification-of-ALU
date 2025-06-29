    class my_sequence extends uvm_sequence;
        `uvm_object_utils(my_sequence);
        my_sequence_item my_seq;
        function new(string name = "my_sequence") ;
            super.new(name);
        endfunction

        task pre_body; //as build phase in component
            my_seq = my_sequence_item::type_id::create("my_seq");
        endtask
        
        task body(); //as run phase in component
            `uvm_info(get_type_name(), "my_sequence body", UVM_MEDIUM);
            for(int i = 0; i < 1000; i++) begin
                start_item(my_seq);
                my_seq.randomize();
                `uvm_info(get_type_name(), $sformatf("my_sequence body: %0d", my_seq), UVM_MEDIUM);
                finish_item(my_seq);
            end
        endtask    
    endclass 
