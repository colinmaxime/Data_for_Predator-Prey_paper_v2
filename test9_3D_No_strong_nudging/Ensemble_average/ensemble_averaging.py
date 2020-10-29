# Script to calculate the ensemble mean, by averaging together several dates.

import glob
import os
import shutil
import subprocess as sub

#with_org = True                                           # TO CHANGE
#with_org = False                                           # TO CHANGE
all_members = True

###-------------------------PICK AN EXPERIMENT--------------------------------------------------------

name_output_file_array = []
data_DIR_array = []

#data_DIR_appendix = "0107_2D_Kessler_microphysics_CONTROL"  # TO CHANGE
#name_output_file  = "wrfout_d01_CONTROL_day1.nc"           # TO CHANGE

#data_DIR_appendix = "0108_Blank_Restart_based_on_sim0107" 
#name_output_file  = "wrfout_d01_Blank_Restart_day1.nc"

#data_DIR_appendix = "0109_Restart_U_V_W_QVAPOR_Theta_all_hydrometeors_PH_MU_TKE_based_on_sim0107"
#name_output_file  = "wrfout_d01_U_V_W_QVAPOR_Theta_all_hydrometeors_PH_MU_TKE_day1.nc"

#data_DIR_appendix = "0110_Restart_U_V_W_QVAPOR_Theta_all_hydrometeors_based_on_sim0107"
#name_output_file  = "wrfout_d01_U_V_W_QVAPOR_Theta_all_hydrometeors_day1.nc"

#data_DIR_appendix = "0111_Restart_U_based_on_sim0107"
#name_output_file  = "wrfout_d01_U_day1.nc"

#data_DIR_appendix = "0112_Restart_U_V_W_based_on_sim0107"
#name_output_file  = "wrfout_d01_U_V_W_day1.nc"

#data_DIR_appendix = "0113_Restart_QVAPOR_based_on_sim0107"
#name_output_file  = "wrfout_d01_QVAPOR_day1.nc"

#data_DIR_appendix = "0114_Restart_Theta_based_on_sim0107"
#name_output_file  = "wrfout_d01_Theta_day1.nc"

#data_DIR_appendix = "0115_Restart_all_hydrometeors_based_on_sim0107"
#name_output_file  = "wrfout_d01_all_hydrometeors_day1.nc"

#data_DIR_appendix = "0116_Restart_U_V_W_QVAPOR_based_on_sim0107"
#name_output_file  = "wrfout_d01_U_V_W_QVAPOR_day1.nc"

#data_DIR_appendix = "0117_Restart_U_V_W_QVAPOR_Theta_based_on_sim0107"
#name_output_file  = "wrfout_d01_U_V_W_QVAPOR_Theta_day1.nc"

#data_DIR_appendix = "0118_Restart_U_V_W_QVAPOR_all_hydrometeors_based_on_sim0107"
#name_output_file  = "wrfout_d01_U_V_W_QVAPOR_all_hydrometeors_day1.nc"

#data_DIR_appendix = "0119_Restart_U_V_W_QVAPOR_PH_based_on_sim0107"
#name_output_file  = "wrfout_d01_U_V_W_QVAPOR_PH_day1.nc"

#data_DIR_appendix = "0120_Restart_U_V_W_QVAPOR_MU_based_on_sim0107"
#name_output_file  = "wrfout_d01_U_V_W_QVAPOR_MU_day1.nc"

#data_DIR_appendix = "0121_Restart_U_V_W_QVAPOR_TKE_based_on_sim0107"
#name_output_file  = "wrfout_d01_U_V_W_QVAPOR_TKE_day1.nc"


#--------------------------

#data_DIR_appendix = "0138_Corrected_SW_solvar_faster"
#name_output_file_array.append("wrfout_d01_CONTROL_day1_19mem.nc")
#data_DIR_array.append("/srv/ccrc/data46/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging" + "/" + data_DIR_appendix)

#data_DIR_appendix = "0139_Blank_Restart_based_on_sim0138"
#name_output_file_array.append("wrfout_d01_Blank_Restart_day1_19mem.nc")
#data_DIR_array.append("/srv/ccrc/data46/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging" + "/" + data_DIR_appendix)

#data_DIR_appendix = "0140_Restart_QVAPOR_based_on_sim0138"
#name_output_file_array.append("wrfout_d01_QVAPOR_day1_1mem.nc")
#data_DIR_array.append("/srv/ccrc/data46/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging" + "/" + data_DIR_appendix)

#data_DIR_appendix = "0141_Restart_Theta_based_on_sim0138"
#name_output_file_array.append("wrfout_d01_Theta_day1_1mem.nc")
#data_DIR_array.append("/srv/ccrc/data46/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging" + "/" + data_DIR_appendix)

#data_DIR_appendix = "0142_Restart_U_V_W_based_on_sim0138"
#name_output_file_array.append("wrfout_d01_U_V_W_day1_1mem.nc")
#data_DIR_array.append("/srv/ccrc/data46/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging" + "/" + data_DIR_appendix)

#data_DIR_appendix = "0143_Restart_all_hydrometeors_based_on_sim0138"
#name_output_file_array.append("wrfout_d01_all_hydrometeors_day1_1mem.nc")
#data_DIR_array.append("/srv/ccrc/data45/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging" + "/" + data_DIR_appendix)

#data_DIR_appendix = "0144_Restart_QVAPOR_Theta_based_on_sim0138"
#name_output_file_array.append("wrfout_d01_QVAPOR_Theta_day1_19mem.nc")
#data_DIR_array.append("/srv/ccrc/data45/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging" + "/" + data_DIR_appendix)

#data_DIR_appendix = "0145_Restart_U_V_W_QVAPOR_based_on_sim0138"
#name_output_file_array.append("wrfout_d01_U_V_W_QVAPOR_day1_19mem.nc")
#data_DIR_array.append("/srv/ccrc/data45/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging" + "/" + data_DIR_appendix)

#data_DIR_appendix = "0146_Restart_U_V_W_Theta_based_on_sim0138"
#name_output_file_array.append("wrfout_d01_U_V_W_Theta_day1_19mem.nc")
#data_DIR_array.append("/srv/ccrc/data46/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging" + "/" + data_DIR_appendix)

#-----------------------------

#data_DIR_appendix = "0151_Restart_QVAPOR_Theta_lowest600m_based_on_sim0138"
#name_output_file_array.append("wrfout_d01_0151_QVAPOR_Theta_lowest600m_day1_8mem.nc")
#data_DIR_array.append("/srv/ccrc/data08/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging" + "/" + data_DIR_appendix)

#data_DIR_appendix = "0152_Restart_QVAPOR_Theta_between_600m_700hPa_based_on_sim0138"
#name_output_file_array.append("wrfout_d01_0152_QVAPOR_Theta_between_600m_700hPa_day1_8mem.nc")
#data_DIR_array.append("/srv/ccrc/data08/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging" + "/" + data_DIR_appendix)

#data_DIR_appendix = "0153_Restart_QVAPOR_Theta_above700hPa_based_on_sim0138"
#name_output_file_array.append("wrfout_d01_0153_QVAPOR_Theta_above700hPa_day1_8mem.nc")
#data_DIR_array.append("/srv/ccrc/data08/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging" + "/" + data_DIR_appendix)

#data_DIR_appendix = "0154_Restart_QVAPOR_Theta_lowest850hPa_based_on_sim0138"
#name_output_file_array.append("wrfout_d01_0154_QVAPOR_Theta_lowest850hPa_day1_8mem.nc")
#data_DIR_array.append("/srv/ccrc/data08/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging" + "/" + data_DIR_appendix)

#data_DIR_appendix = "0155_Restart_QVAPOR_Theta_above850hPa_based_on_sim0138"
#name_output_file_array.append("wrfout_d01_0155_QVAPOR_Theta_above850hPa_day1_8mem.nc")
#data_DIR_array.append("/srv/ccrc/data08/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging" + "/" + data_DIR_appendix)

#data_DIR_appendix = "0164_Restart_QVAPOR_Theta_First_layer_only"
#name_output_file_array.append("wrfout_d01_0164_QVAPOR_Theta_1st_layer_day1_8mem.nc")
#data_DIR_array.append("/srv/ccrc/data08/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging" + "/" + data_DIR_appendix)

data_DIR_appendix = "0165_Restart_QVAPOR_Theta_lowest600m_Qvap_Theta_above_ave_only"
name_output_file_array.append("wrfout_d01_0165_QVAPOR_Theta_lowest600m_Qvap_Theta_above_ave_only_day1_8mem.nc")
data_DIR_array.append("/srv/ccrc/data08/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging" + "/" + data_DIR_appendix)



###------------------------ DOING THE WORK -----------------------------------------------------------

#if with_org == True: 
#    ensemble_start_day = 1
#    ensemble_end_day = 9
#else:
#    ensemble_start_day = 13
#    ensemble_end_day = 30
#
#if with_org == True:
#    ensemble_DIR = 'With_clustering'
#else:
#    ensemble_DIR = 'No_organisation'

if (all_members == True):
    ensemble_start_day = 1
    ensemble_end_day = 8       # TO MODIFY IF NECESSARY (to vary ensemble size)
    ensemble_DIR = '8members_layer_CJakob_selected'  # TO MODIFY
    print "ensemble_start_day ", ensemble_start_day
    print "ensemble_end_day ", ensemble_end_day

# OPTIONS TO CHANGE IF NEEDED
output_DIR = "/srv/ccrc/data45/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging/Ensemble_average/" + ensemble_DIR
if not os.path.exists(output_DIR):
    os.makedirs(output_DIR)


# LOOP OVER THE EXPERIMENTS
for i_data, data_DIR in enumerate(data_DIR_array):
    name_output_file = name_output_file_array[i_data]


    # GET THE RELEVANT FILES
    file_list = glob.glob(data_DIR + "/" + 'wrfout_d01_2007-08-*_05:00:00')
    file_list.sort()
    print "data_DIR ", data_DIR

    sublist = file_list[ensemble_start_day-1:ensemble_end_day]


    line_for_CDO = " "
    for file in sublist:
        line_for_CDO = line_for_CDO + file + "  "
    print ""
    print line_for_CDO



    # COMPUTE THE ENSEMBLE MEAN
    sub.check_call('cdo ensmean ' + line_for_CDO + output_DIR + "/" + name_output_file, shell=True)
