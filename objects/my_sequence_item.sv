    class my_sequence_item extends uvm_sequence_item;
        `uvm_object_utils(my_sequence_item);

        function new(string name = "my_sequence_item") ;
            super.new(name);
        endfunction

        rand logic signed [15:0] A, B;
        randc logic [2:0] OP;
        logic signed [31:0] ALU_OUTPUT;

        constraint c1{ A dist { -32768 := 5000 , 32767 := 5000, [-32767:32766] :/ 5000 };
                        B dist { -32768 := 5000 , 32767 := 5000 ,0 := 5000 , [-32767:32766] :/ 5000 };}

    endclass
