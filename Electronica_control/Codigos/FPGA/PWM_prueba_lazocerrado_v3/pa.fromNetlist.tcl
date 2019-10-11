
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name PWM_prueba_lazocerrado_v3 -dir "D:/URJC/4.CUARTO/TFG/TRABAJO/FPGA/PWM_prueba_lazocerrado_v3/planAhead_run_2" -part xc3s100etq144-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "D:/URJC/4.CUARTO/TFG/TRABAJO/FPGA/PWM_prueba_lazocerrado_v3/juntar.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {D:/URJC/4.CUARTO/TFG/TRABAJO/FPGA/PWM_prueba_lazocerrado_v3} }
set_property target_constrs_file "BasysRevEGeneralYo.ucf" [current_fileset -constrset]
add_files [list {BasysRevEGeneralYo.ucf}] -fileset [get_property constrset [current_run]]
link_design
