# Data_for_Predator-Prey_paper_v2
Data used for the predator-prey JAS paper

test9_3D_No_strong_nudging/0138_Corrected_SW_solvar_faster/Analysis/more_variables/19members/compute_Ens_average_One_exp_Improved_More_var/Ens_member_ave_More_variables_test9_0138_Corrected_SW_solvar_faster_19mem_Big_array_v1.nc : This is the netcdf file containing most variables post-processed with NCL about the WRF control "free" run (test9, simu 0138). It is unfortunately too big to be uploaded with GitHub.

test9_3D_No_strong_nudging/0138_Corrected_SW_solvar_faster_BIS/compute_target_profiles/building_target_averaging_with_ncwa_v2.py : Here the Python script used to compute the target profiles for fixed-macrostate runs

test9_3D_No_strong_nudging/0138_Corrected_SW_solvar_faster_BIS/compute_target_profiles/targets/target_prof--ncwa_Times--time_mean--fld_mean--20day_file_mean--wrfout_d01_2007-08-0*_05:00:00--selected_var : The netcdf target files used as strong nudging targets

test9_3D_No_strong_nudging/0138_Corrected_SW_solvar_faster_BIS/compute_target_profiles/Analysis/target_profile_analysis/target_profile_analysis_v5_without_getvar.ncl : This is the NCL script to analyse the target profiles

test9_3D_No_strong_nudging/0138_Corrected_SW_solvar_faster_BIS/compute_target_profiles/Analysis/target_profile_analysis/C02_target_profile_analysis_without_getvar/stats_for_all_day_and_exp_growth_days_and_exp_decay_days.txt : Statistics and information on the target profiles

test9_3D_No_strong_nudging/0138_Corrected_SW_solvar_faster_BIS/compute_target_profiles/Analysis/target_profile_analysis/C02_target_profile_analysis_without_getvar/stats_for_all_day_and_exp_growth_days_and_exp_decay_days_v2.txt : Statistics and information on the target profiles

test9_3D_No_strong_nudging/0138_Corrected_SW_solvar_faster_BIS/compute_target_profiles/Analysis/target_profile_analysis/C02_target_profile_analysis_without_getvar/target_profiles_analysis_output_test9_0138_Corrected_SW_solvar_faster_BIS__v1.nc : Statistics and information on the target profiles

test10_3D_With_strong_nudging/0158.6.6.8_Strong_nudging_first_tests/part1_init_v46_On_tendencies_DJK_Up_to_lev54_All_4_var_40s_From_restart_Old_modules/Analysis/Time_series_together/Time_series_different_variables_together_Easy_v7_for_paper.ncl : NCL script to create the plot for Figure 2: putting all time series together

test9_3D_No_strong_nudging/0144_Restart_QVAPOR_Theta_based_on_sim0138/modifying_restart_files/change_all_file_names_back.py : Python script to rename original restart files so that WRF can use it as input

test9_3D_No_strong_nudging/0144_Restart_QVAPOR_Theta_based_on_sim0138/modifying_restart_files/copy_and_change_wrf_restart_5.py : Python script to homogenise the restart files to feed them to WRF for the homogenisation experiments

test9_3D_No_strong_nudging/0144_Restart_QVAPOR_Theta_based_on_sim0138/modifying_restart_files/pre_run_verification.py : Python script to homogenise the restart files to feed them to WRF for the homogenisation experiments

test9_3D_No_strong_nudging/Ensemble_average/ensemble_averaging.py : Python script to compute the ensemble average over several realisations of the homogenisation experiments (i.e., several days)

test9_3D_No_strong_nudging/Ensemble_average/19members/Average_and_std_error_of_the_mean/standard_deviation_of_hor_mean.py :  Script to compute mean and standard deviation over the ensemble members of a given experiment

test9_3D_No_strong_nudging/Ensemble_average/19members/Average_and_std_error_of_the_mean/stddev_and_mean_method2/ensmean--wrfout_d01_QVAPOR_Theta_day1.nc : Netcdf files resulting from the ensemble mean computation for the experiment where Theta and Qvapor are homogenised

test9_3D_No_strong_nudging/Ensemble_average/19members/Average_and_std_error_of_the_mean/stddev_and_mean_method2/ensstd--wrfout_d01_QVAPOR_Theta_day1.nc : Netcdf files resulting from the ensemble mean computation for the experiment where Theta and Qvapor are homogenised

test10_3D_With_strong_nudging/0158.6.6.8_Strong_nudging_first_tests/part1_init_v46_On_tendencies_DJK_Up_to_lev54_All_4_var_40s_From_restart_Old_modules/Analysis/organisation_cold_pool_diagnostics/plot_organisation_cold_pool_diagnostics.ncl : Script and pictures of OLR snapshots showing instability evolving in time

test10_3D_With_strong_nudging/0158.6.6.8_Strong_nudging_first_tests/part1_init_v46_On_tendencies_DJK_Up_to_lev54_All_4_var_40s_From_restart_Old_modules/Analysis/organisation_cold_pool_diagnostics/movies/plot_olr_big_array_part1_init_v46_On_tendencies_DJK_Up_to_lev54_All_4_var_40s_From_restart_Old_modules_num_day_01_num_output_*_v1.png : Script and pictures of OLR snapshots showing instability evolving in time

Simple_stochastic_convection_model/03.3_Free_1000mem_Varying_VDAMP_Several_realisations_Data_output/Comparison_PP_WRF/comparison_PP_WRF_plot_v2.py : Python script to run the predator-prey model, and plot several figures comparing predator-prey model output and WRF output for sub-cloud layer humidity. This is what was used for Figure 4.

Simple_stochastic_convection_model/03.3_Free_1000mem_Varying_VDAMP_Several_realisations_Data_output/Comparison_PP_WRF_for_CAPE_and_PW_together/comparison_PP_WRF_plot_for_CAPE_and_PW_together.py : Python script to run the predator-prey model, and plot several figures comparing predator-prey model output and WRF output for PW and CAPE. THis is what was used for Figure 5

Simple_stochastic_convection_model/03.2_Free_1000mem_Varying_VDAMP_Several_realisations/conv_mod_pseudo_homog_Str_nudg_to_RCE.py : Python script to run the predator-prey model, and plot several figures for various alpha_damp values. This is what was used for the left-hand side of Figure 6

Simple_stochastic_convection_model/16_No_stochastic_Free_1000mem_Varying_VDAMP/conv_mod_pseudo_homog_Str_nudg_to_RCE_multiplot.py : Python script to run the predator-prey model without stochastic terms, and plot several figures for various alpha_damp values. This is what was used for the right-hand side of Figure 6

test10_3D_With_strong_nudging/0215_Strong_nudging_T_U_V_No_Homogenisation/ensemble_v1.tar.xz : List of important files to run the WRF simulations with strong nudging

test9_3D_No_strong_nudging/0138_Corrected_SW_solvar_faster/part1_init.tar.xz : List of important files to run the WRF control 'free' simulations

test9_3D_No_strong_nudging/0144_Restart_QVAPOR_Theta_based_on_sim0138/ensemble_v1.tar.xz : List of important files to run the WRF homogenisation experiments
