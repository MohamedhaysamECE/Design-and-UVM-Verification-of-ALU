module ALU_TOP;
    import ALU_pkg::*;
    import uvm_pkg::*;
    
    intf intf1();
    ALU A1 (intf1.A, intf1.B, intf1.OP, intf1.ALU_OUTPUT);
    initial begin
        uvm_config_db #(virtual intf)::set(null, "uvm_test_top", "my_vif", intf1);
        run_test("my_test");
    end
endmodule
