# System clock
set_property -dict { PACKAGE_PIN K17 IOSTANDARD LVCMOS33 } [get_ports { sysclk }];

#set_property -dict { PACKAGE_PIN K18 IOSTANDARD LVCMOS33 } [get_ports { BTN0 }];

# RGB LED LD5   
set_property -dict { PACKAGE_PIN Y11 IOSTANDARD LVCMOS33 } [get_ports { RGB0[0] }]; # red
set_property -dict { PACKAGE_PIN T5 IOSTANDARD LVCMOS33 } [get_ports { RGB0[1] }]; # green
set_property -dict { PACKAGE_PIN Y12 IOSTANDARD LVCMOS33 } [get_ports { RGB0[2] }]; # blue

# RGB LED LD6   
#set_property -dict { PACKAGE_PIN V16 IOSTANDARD LVCMOS33 } [get_ports { RGB1[0] }]; # red
#set_property -dict { PACKAGE_PIN F17 IOSTANDARD LVCMOS33 } [get_ports { RGB1[1] }]; # green
#set_property -dict { PACKAGE_PIN M17 IOSTANDARD LVCMOS33 } [get_ports { RGB1[2] }]; # blue