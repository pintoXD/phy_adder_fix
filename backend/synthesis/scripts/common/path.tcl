
#-----------------------------------------------------------------------------
# Common path variables (directory structure dependent)
#-----------------------------------------------------------------------------
set BACKEND_DIR ${PROJECT_DIR}/backend
set SYNT_DIR ${BACKEND_DIR}/synthesis
set SCRIPT_DIR ${SYNT_DIR}/scripts
set RPT_DIR ${SYNT_DIR}/reports
set DEV_DIR ${SYNT_DIR}/deliverables
set LAYOUT_DIR ${BACKEND_DIR}/layout

#-----------------------------------------------------------------------------
# Setting rtl search directories
#-----------------------------------------------------------------------------
set FRONTEND_DIR ${PROJECT_DIR}/frontend
set OTHERS ""
lappend FRONTEND_DIR $OTHERS

#-----------------------------------------------------------------------------
# Setting technology directories - Uncomment the line from your university and comment out the lines from the others universities
#-----------------------------------------------------------------------------
# set LIB_DIR ${TECH_DIR}/gsclib045_svt_v4.4/gsclib045/timing
# The following set is only for UFC guys
set LIB_DIR ${TECH_DIR}/gsclib045_svt_v4.4/lan/flow/t1u1/reference_libs/GPDK045/gsclib045_svt_v4.4/gsclib045/timing

# The following set is only for UFCG guys
# set LIB_DIR ${TECH_DIR}/gsclib045_all_v4_4/gsclib045/timing

# The following set is only for UFSM guys
# set LIB_DIR ${TECH_DIR}/gsclib045_all_v4.7/gsclib045/timing

##########################################################
############### Setting the LEF_DIR PATH
# set LEF_DIR ${TECH_DIR}/gsclib045_svt_v4.4/gsclib045/lef
# The following set is only for UFC guys
set LEF_DIR ${TECH_DIR}/gsclib045_svt_v4.4/lan/flow/t1u1/reference_libs/GPDK045/gsclib045_svt_v4.4/gsclib045/lef

# The following set is only for UFCG guys
# set LEF_DIR ${TECH_DIR}/gsclib045_all_v4_4/gsclib045/lef

# The following set is only for UFSM guys
# set LEF_DIR ${TECH_DIR}/gsclib045_all_v4.7/gsclib045/lef


################ appeding the LEF_DIR path
# lappend LEF_DIR ${TECH_DIR}/giolib045_v3.3/lef

# UFC guys
# lappend LEF_DIR ${TECH_DIR}/giolib045_v3.3/lef

#UFCG guys
# lappend LEF_DIR ${TECH_DIR}/giolib045_v3.3/lef