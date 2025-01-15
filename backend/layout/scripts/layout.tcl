
#-----------------------------------------------------------------------------
# Initial configurations
#-----------------------------------------------------------------------------
# see file ${PROJECT_DIR}/backend/synthesis/scripts/run_first.tcl

#-----------------------------------------------------------------------------
# (!) same as $DESIGNS.tcl (!) Main Custom Variables Design Dependent (set local)
#-----------------------------------------------------------------------------
set PROJECT_DIR $env(PROJECT_DIR)
set TECH_DIR $env(TECH_DIR)
set LIB_DIR $env(LIB_DIR)
set DESIGNS $env(DESIGNS)
set HDL_NAME $env(HDL_NAME)
set INTERCONNECT_MODE ple

#-----------------------------------------------------------------------------
# (!) same as $DESIGNS.tcl (!) MAIN Custom Variables to be used in SDC (constraints file)
#-----------------------------------------------------------------------------
set MAIN_CLOCK_NAME clk
set MAIN_RST_NAME rst_n
set BEST_LIB_OPERATING_CONDITION PVT_1P32V_0C
set WORST_LIB_OPERATING_CONDITION PVT_0P9V_125C
set period_clk 100.0  ;# (100 ns = 10 MHz) (10 ns = 100 MHz) (2 ns = 500 MHz) (1 ns = 1 GHz)
set clk_uncertainty 0.05 ;# ns ("a guess")
set clk_latency 0.10 ;# ns ("a guess")
set in_delay 0.30 ;# ns
set out_delay 0.30;#ns
set out_load 0.045 ;#pF
set slew "146 164 264 252" ;#minimum rise, minimum fall, maximum rise and maximum fall
set slew_min_rise 0.146 ;# ns
set slew_min_fall 0.164 ;# ns
set slew_max_rise 0.264 ;# ns
set slew_max_fall 0.252 ;# ns

# set TECH_DIR /home/tools/cadence/gpdk;
# set LIB_DIR ${TECH_DIR}/gsclib045_svt_v4.4/lan/flow/t1u1/reference_libs/GPDK045/gsclib045_svt_v4.4/gsclib045/timing
# # set PROJECT_DIR /home/cinovador/Downloads/somador_fisico/somador
# set PROJECT_DIR $env(PROJECT_DIR)
# set BACKEND_DIR $env(PROJECT_DIR)/backend
# set LAYOUT_DIR  $BACKEND_DIR/layout
# set DESIGNS "somador"

#-----------------------------------------------------------------------------
# Load Path File
#-----------------------------------------------------------------------------
source ${PROJECT_DIR}/backend/synthesis/scripts/common/path.tcl

#-----------------------------------------------------------------------------
# set tech files to be used in ".globals" and ".view"
#-----------------------------------------------------------------------------
set WORST_LIST ${LIB_DIR}/slow_vdd1v0_basicCells.lib
set BEST_LIST ${LIB_DIR}/fast_vdd1v2_basicCells.lib
set LEF_INIT "${TECH_DIR}/gsclib045_svt_v4.4/lan/flow/t1u1/reference_libs/GPDK045/gsclib045_svt_v4.4/gsclib045/lef/gsclib045_tech.lef ${TECH_DIR}/gsclib045_svt_v4.4/lan/flow/t1u1/reference_libs/GPDK045/gsclib045_svt_v4.4/gsclib045/lef/gsclib045_macro.lef" ;# LEF_LIST
set CAP_MAX ${TECH_DIR}/gpdk045_v_6_0/soce/gpdk045.basic.CapTbl
set CAP_MIN ${TECH_DIR}/gpdk045_v_6_0/soce/gpdk045.basic.CapTbl
set QRC_LIST ${TECH_DIR}/gpdk045_v_6_0/qrc/rcworst/qrcTechFile

#-----------------------------------------------------------------------------
# set power nets
#-----------------------------------------------------------------------------
set NET_ZERO VSS
set NET_ONE VDD

#-----------------------------------------------------------------------------
# Loads the design main files (netlist, LEFs, timing libraries)
#-----------------------------------------------------------------------------
source ${LAYOUT_DIR}/scripts/${DESIGNS}.globals

# #-----------------------------------------------------------------------------
# # Initiates the design files loaded above
# #-----------------------------------------------------------------------------
# init_design


#-----------------------------------------------------------------------------
# Initiates the design files (netlist, LEFs, timing libraries)
#-----------------------------------------------------------------------------
set_db init_power_nets $NET_ONE
set_db init_ground_nets $NET_ZERO
read_mmmc ${LAYOUT_DIR}/scripts/${DESIGNS}.view
read_physical -lef $LEF_INIT
read_netlist ${BACKEND_DIR}/synthesis/deliverables/${DESIGNS}.v
init_design
connect_global_net $NET_ONE -type pg_pin -pin_base_name $NET_ONE -inst_base_name *
connect_global_net $NET_ZERO -type pg_pin -pin_base_name $NET_ZERO -inst_base_name *

#-----------------------------------------------------------------------------
# Tells Innovus the technology being used
#-----------------------------------------------------------------------------
# setDesignMode -process 45
set_db design_process_node 45

#-----------------------------------------------------------------------------
# Specify floorplan
#-----------------------------------------------------------------------------
create_floorplan -core_margins_by die -site CoreSite -core_density_size 1 0.7 2.5 2.5 2.5 2.5
# graphical

# floorplan: aims aspect ratio = 1 and moves IO pads 8.0 microns from the outside edge of the core core box. core utilization = 0.85

#-----------------------------------------------------------------------------
# Add ring (Power planning)
#-----------------------------------------------------------------------------
# graphical or command
set_db add_rings_skip_shared_inner_ring none
set_db add_rings_avoid_short 1
set_db add_rings_ignore_rows 0
set_db add_rings_extend_over_row 0
add_rings -type core_rings -jog_distance 0.6 -threshold 0.6 -nets "$NET_ONE $NET_ZERO" -follow core -layer {bottom Metal11 top Metal11 right Metal10 left Metal10} -width 0.7 -spacing 0.4 -offset 0.6

#-----------------------------------------------------------------------------
# Add stripes (Power planning)
#-----------------------------------------------------------------------------
# graphical or command
add_stripes -block_ring_top_layer_limit Metal11 -max_same_layer_jog_length 0.44 -pad_core_ring_bottom_layer_limit Metal9 -set_to_set_distance 7 -pad_core_ring_top_layer_limit Metal11 -spacing 0.4 -layer Metal10 -block_ring_bottom_layer_limit Metal9 -width 0.22 -start_offset 1 -nets "$NET_ONE $NET_ZERO"

#-----------------------------------------------------------------------------
# Sroute
#-----------------------------------------------------------------------------
# graphical or command
route_special -connect core_pin -layer_change_range { Metal1(1) Metal11(11) } -block_pin_target nearest_target -core_pin_target first_after_row_end -allow_jogging 1 -crossover_via_layer_range { Metal1(1) Metal11(11) } -nets "$NET_ONE $NET_ZERO" -allow_layer_change 1 -target_via_layer_range { Metal1(1) Metal11(11) }


#-----------------------------------------------------------------------------
# Save Design: 01_power.enc
#-----------------------------------------------------------------------------
# graphical or command
write_db 01_power.enc


#-----------------------------------------------------------------------------
# Placement
#-----------------------------------------------------------------------------
# graphical or command
set_db place_global_place_io_pins 1
set_db place_global_reorder_scan 0
place_design


#-----------------------------------------------------------------------------
# Save Design: 02_placement.enc
#-----------------------------------------------------------------------------
# graphical or command
write_db 02_placement.enc


#-----------------------------------------------------------------------------
# Extract RC
#-----------------------------------------------------------------------------
# graphical or command
set_db extract_rc_engine pre_route
extract_rc ;# generates RC database for timing analysis and signal integrity (SI) anaysis


#-----------------------------------------------------------------------------
# preCTS optimization
#-----------------------------------------------------------------------------
#set_db opt_drv_fix_max_cap true ; set_db opt_drv_fix_max_tran true ; set_db opt_fix_fanout_load false
#opt_design -pre_cts


#-----------------------------------------------------------------------------
# Pre-CTS timing verification
#-----------------------------------------------------------------------------
set_db timing_analysis_type best_case_worst_case
time_design -pre_cts


#-----------------------------------------------------------------------------
# CTS - Clock Concurrent Optimization Flow
#-----------------------------------------------------------------------------
get_db clock_trees
create_clock_tree_spec ;# creates a database cts spec
get_db clock_trees
ccopt_design ;# creates the clock tree
#delete_clock_tree_spec ;# removes the already loaded cts specification (reset_cts_config)


#-----------------------------------------------------------------------------
# Post-CTS timing verification
#-----------------------------------------------------------------------------
set_db timing_analysis_type best_case_worst_case
set_db timing_analysis_clock_propagation_mode sdc_control
time_design -post_cts
time_design -post_cts -hold

#-----------------------------------------------------------------------------
# postCTS optimization
#-----------------------------------------------------------------------------
#opt_design -post_cts


#-----------------------------------------------------------------------------
# Save Design: 03_cts.enc
#-----------------------------------------------------------------------------
# graphical or command
write_db 03_cts.enc
# graphical

#-----------------------------------------------------------------------------
# Power nets (Power planning) creating power, grounds rings and stripes
#-----------------------------------------------------------------------------
# graphical


#-----------------------------------------------------------------------------
# Power nets (Power planning) creating power, grounds rings and stripes
#-----------------------------------------------------------------------------
# graphical


#-----------------------------------------------------------------------------
# Add Ring (Power planning)
#-----------------------------------------------------------------------------
# graphical


#-----------------------------------------------------------------------------
# Sroute
#-----------------------------------------------------------------------------
# graphical


#-----------------------------------------------------------------------------
# Save Design: 01_power.enc
#-----------------------------------------------------------------------------
# graphical

gui_show