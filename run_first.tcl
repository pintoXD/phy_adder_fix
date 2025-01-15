
export DESIGNS="somador" ;# put here the name of current design
export USER=$USER;# put here YOUR user name at this machine
export PROJECT_DIR=${PWD}
export BACKEND_DIR=${PROJECT_DIR}/backend
export TECH_DIR=/home/tools/cadence/gpdk;# techonology dependant comand only valid for UFC guys. Uncomment this line if you are from UFC.
export HDL_NAME=${DESIGNS}
export VLOG_LIST="$BACKEND_DIR/synthesis/deliverables/${DESIGNS}.v  $BACKEND_DIR/synthesis/deliverables/${DESIGNS}_io.v  $BACKEND_DIR/synthesis/deliverables/${DESIGNS}_chip.v"
export LIB_DIR=${TECH_DIR}/gsclib045_svt_v4.4/lan/flow/t1u1/reference_libs/GPDK045/gsclib045_svt_v4.4/gsclib045/timing

# loading modules
# module add cdn/genus/genus211 		;# GENUS
# module add cdn/xcelium/xcelium2409 	;# XCELIUM
# module add cdn/innovus/innovus211 	;# INNOVUS
#module add cdn/ic/ic231 		;# VIRTUOSO
#module add cdn/assura/assura41		;# ASSURA


# Para executar o XCELIUM
cd ${PROJECT_DIR}/frontend
### run HDL
#xrun -64bit -v200x -v93 ${DESIGNS}.vhd Util_package.vhd ${DESIGNS}_tb.vhd -top ${DESIGNS}_tb -access +rwc -gui
### run netlist (logic synthesis)
#xrun -64bit -v200x -v93 ${TECH_DIR}/gsclib045_all_v4.4/gsclib045/verilog/slow_vdd1v0_basicCells.v ${PROJECT_DIR}/backend/synthesis/deliverables/${DESIGNS}.v Util_package.vhd ${DESIGNS}_tb.vhd -top ${DESIGNS}_tb -access +rwc -gui
### run netlist (logic syntesis) with compiled SDF 
#xmsdfc -iocondsort -compile ${PROJECT_DIR}/backend/synthesis/deliverables/${DESIGNS}_worst.sdf & xrun -timescale 1ns/10ps -mess -64bit -v200x -v93 -noneg_tchk ${TECH_DIR}/gsclib045_all_v4.4/gsclib045/verilog/slow_vdd1v0_basicCells.v ${PROJECT_DIR}/backend/synthesis/deliverables/${DESIGNS}.v Util_package.vhd ${DESIGNS}_tb.vhd -top ${DESIGNS}_tb -access +rwc -sdf_cmd_file ${PROJECT_DIR}/frontend/sdf_cmd_file.cmd -gui 



# Para executar o GENUS
#cd ${PROJECT_DIR}/backend/synthesis/work
## apenas o programa
#genus -abort_on_error -lic_startup Genus_Synthesis -lic_startup_options Genus_Physical_Opt -log genus -overwrite
# programa e carrega script para síntese automatizada
# genus -abort_on_error -lic_startup Genus_Synthesis -lic_startup_options Genus_Physical_Opt -log genus -overwrite -files ${PROJECT_DIR}/backend/synthesis/scripts/${DESIGNS}.tcl



# Para executar o INNOVUS
# cd ${PROJECT_DIR}/backend/layout/work
## apenas o programa
# innovus
innovus -stylus -file ${PROJECT_DIR}/backend/layout/scripts/layout.tcl










