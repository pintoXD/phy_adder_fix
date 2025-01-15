if {![namespace exists ::IMEX]} { namespace eval ::IMEX {} }
set ::IMEX::dataVar [file dirname [file normalize [info script]]]
set ::IMEX::libVar ${::IMEX::dataVar}/libs

create_library_set -name fast\
   -timing\
    [list ${::IMEX::libVar}/mmmc/fast_vdd1v2_basicCells.lib]
create_library_set -name slow\
   -timing\
    [list ${::IMEX::libVar}/mmmc/slow_vdd1v0_basicCells.lib]
create_opcond -name oc_fast -process 1 -voltage 1.32 -temperature 0
create_opcond -name oc_slow -process 1 -voltage 0.9 -temperature 125
create_timing_condition -name slow_timing\
   -library_sets [list slow]\
   -opcond oc_slow
create_timing_condition -name fast_timing\
   -library_sets [list fast]\
   -opcond oc_fast
create_rc_corner -name rc_best\
   -cap_table ${::IMEX::libVar}/mmmc/gpdk045.basic.CapTbl\
   -pre_route_res 1\
   -post_route_res 1\
   -pre_route_cap 1\
   -post_route_cap 1\
   -post_route_cross_cap 1\
   -pre_route_clock_res 0\
   -pre_route_clock_cap 0\
   -temperature 0
create_rc_corner -name rc_worst\
   -cap_table ${::IMEX::libVar}/mmmc/gpdk045.basic.CapTbl\
   -pre_route_res 1\
   -post_route_res 1\
   -pre_route_cap 1\
   -post_route_cap 1\
   -post_route_cross_cap 1\
   -pre_route_clock_res 0\
   -pre_route_clock_cap 0\
   -temperature 125
create_delay_corner -name slow_max\
   -timing_condition {slow_timing}\
   -rc_corner rc_worst
create_delay_corner -name fast_min\
   -timing_condition {fast_timing}\
   -rc_corner rc_best
create_constraint_mode -name normal_genus_slow_max\
   -sdc_files\
    [list /dev/null]
create_analysis_view -name analysis_normal_fast_min -constraint_mode normal_genus_slow_max -delay_corner fast_min
create_analysis_view -name analysis_normal_slow_max -constraint_mode normal_genus_slow_max -delay_corner slow_max
set_analysis_view -setup [list analysis_normal_slow_max] -hold [list analysis_normal_fast_min]
