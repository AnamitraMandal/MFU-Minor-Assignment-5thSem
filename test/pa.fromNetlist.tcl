
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name test -dir "E:/test/planAhead_run_4" -part xc6slx45csg324-3
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "E:/test/test.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {E:/test} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "test.ucf" [current_fileset -constrset]
add_files [list {test.ucf}] -fileset [get_property constrset [current_run]]
link_design
