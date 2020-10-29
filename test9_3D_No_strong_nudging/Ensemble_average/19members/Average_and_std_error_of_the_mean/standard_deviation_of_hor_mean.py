# Script to calculate the ensemble mean, by averaging together several dates.

import glob
import os
import shutil
import subprocess as sub
import netCDF4 as nc4

import tempfile
import uuid

from contextlib import closing

import settings as cfg

#with_org = True                                           # TO CHANGE
#with_org = False                                           # TO CHANGE

#output_dt = 15.0


###-------------------------PICK AN EXPERIMENT--------------------------------------------------------

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

#data_DIR_appendix = "0139_Blank_Restart_based_on_sim0138"
#name_output_file  = "wrfout_d01_Blank_Restart_day1.nc"
#data_DIR = "/srv/ccrc/data46/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging/" + data_DIR_appendix

#data_DIR_appendix = "0138_Corrected_SW_solvar_faster"
#name_output_file  = "wrfout_d01_CONTROL_day1.nc"
#data_DIR = "/srv/ccrc/data46/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging/" + data_DIR_appendix

#data_DIR_appendix = "0140_Restart_QVAPOR_based_on_sim0138"
#name_output_file  = "wrfout_d01_QVAPOR_day1.nc"
#data_DIR = "/srv/ccrc/data46/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging/" + data_DIR_appendix

#data_DIR_appendix = "0141_Restart_Theta_based_on_sim0138"
#name_output_file  = "wrfout_d01_Theta_day1.nc"
#data_DIR = "/srv/ccrc/data46/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging/" + data_DIR_appendix

#data_DIR_appendix = "0142_Restart_U_V_W_based_on_sim0138"
#name_output_file  = "wrfout_d01_U_V_W_day1.nc"
#data_DIR = "/srv/ccrc/data46/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging/" + data_DIR_appendix

#data_DIR_appendix = "0143_Restart_all_hydrometeors_based_on_sim0138"
#name_output_file  = "wrfout_d01_all_hydrometeors_day1.nc"
#data_DIR = "/srv/ccrc/data45/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging/" + data_DIR_appendix

#data_DIR_appendix = "0144_Restart_QVAPOR_Theta_based_on_sim0138"
#name_output_file  = "wrfout_d01_QVAPOR_Theta_day1.nc"
#data_DIR = "/srv/ccrc/data45/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging/" + data_DIR_appendix

#data_DIR_appendix = "0145_Restart_U_V_W_QVAPOR_based_on_sim0138"
#name_output_file  = "wrfout_d01_U_V_W_QVAPOR_day1.nc"
#data_DIR = "/srv/ccrc/data45/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging/" + data_DIR_appendix

data_DIR_appendix = "0146_Restart_U_V_W_Theta_based_on_sim0138"
name_output_file  = "wrfout_d01_U_V_W_Theta_day1.nc"
data_DIR = "/srv/ccrc/data46/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging/" + data_DIR_appendix



###---------------------------FUNCTIONS AND OBJECT---------------------------------------------------


def accum2rates(vname, input_path, output_dir_path, alternate_name=None):
    """
    This converts the accumulated rain (RAINNC) into a rain rate in mm/h, which can then be used for mean and std computations.
    """

    #copy only selected variable to a new directory
    output_path = os.path.join(output_dir_path, "rate--%s--%s" % (uuid.uuid4(), os.path.basename(input_path)))
    sub.check_call('cdo selname,%s %s %s' % (vname, input_path, output_path), shell=True)

    if alternate_name:
        sub.check_call('ncrename -h -O -v %s,%s %s' % (vname, alternate_name, output_path), shell=True)
        vname = alternate_name

    with closing(nc4.Dataset(output_path, 'a')) as ofile:
        data = ofile.variables[vname][:]

        #TO DO...
        data = (data[1:] - data[:-1])*60./cfg.OUTPUT_DT

        ofile.variables[vname][:-1] = data
        ofile.variables[vname][-1]  = -9999999 
        ofile.sync()



class Preprocess(object):

    def __init__(self, vname, input_dir_path, output_dir_path, alternate_name=None):
        self.input_dir_path = input_dir_path
        self.output_dir_path = output_dir_path
        self.vname = vname
        self.alternate_name = alternate_name

        self.step1_output_dir = os.path.join(self.output_dir_path, 'step1')
        self.step2_output_dir = os.path.join(self.output_dir_path, 'step2')
        self.step3_output_dir = os.path.join(self.output_dir_path, 'step3')


    def cleanup(self):
        if os.path.exists( self.step1_output_dir ):
            sub.check_call('rm -rf %s' % self.step1_output_dir, shell=True) 

        if os.path.exists( self.step2_output_dir ):
            sub.check_call('rm -rf %s' % self.step2_output_dir, shell=True) 

        if os.path.exists( self.step3_output_dir ):
            sub.check_call('rm -rf %s' % self.step3_output_dir, shell=True) 


    def step1_accumulation_to_rates(self): 
        file_list = glob.glob(self.input_dir_path + "/" + 'wrfout_d01_2007-08-*_05:00:00')
        file_list.sort()

        sublist = file_list[ensemble_start_day-1:ensemble_end_day]
        output_dir = os.path.join(self.output_dir_path, 'step1')

        if not os.path.exists( output_dir ):
            os.makedirs( output_dir )

        for i, fn in enumerate(sublist):
            accum2rates(self.vname, fn, output_dir, self.alternate_name)


    def step2_horizontal_average(self):
        file_list = glob.glob(os.path.join(self.output_dir_path, 'step1', 'rate-*'))
        output_dir = os.path.join(self.output_dir_path, 'step2')

        if not os.path.exists( output_dir ):
            os.makedirs( output_dir )        

        for i, fn in enumerate(file_list):
            output_path = os.path.join(output_dir, "fldmean--%s" % (os.path.basename(fn)))
            sub.check_call('cdo fldmean ' + fn + ' ' + output_path, shell=True)


    def step3_stddev_and_mean_on_members(self):
        file_list = glob.glob(os.path.join(self.output_dir_path, 'step2', 'fldmean*'))
        output_dir = os.path.join(self.output_dir_path, 'step3')

        line_for_CDO = " "
        for file in file_list:
            line_for_CDO = line_for_CDO + file + "  "
        print ""
        print line_for_CDO

        if not os.path.exists( output_dir ):
            os.makedirs( output_dir )

        output_path = os.path.join(output_dir, "ensmean--%s" % (name_output_file))
        sub.check_call('cdo ensmean ' + line_for_CDO + ' ' + output_path, shell=True)
        shutil.copyfile(output_path, output_DIR + "ensmean--" + name_output_file)

        output_path_2 = os.path.join(output_dir, "ensstd--%s" % (name_output_file))
        sub.check_call('cdo ensstd ' + line_for_CDO + ' ' + output_path_2, shell=True)
        shutil.copyfile(output_path_2, output_DIR + "ensstd--" + name_output_file)


    def do_work(self):
        self.cleanup()
        self.step1_accumulation_to_rates()
        self.step2_horizontal_average()
        self.step3_stddev_and_mean_on_members()

        




###------------------------ DOING THE WORK -----------------------------------------------------------



ensemble_start_day = 1
ensemble_end_day = 19
#if with_org == True: 
#    ensemble_start_day = 1
#    ensemble_end_day = 9
#else:
#    ensemble_start_day = 13
#    ensemble_end_day = 30

ensemble_DIR = 'stddev_and_mean_method2/'
#if with_org == True:
#    ensemble_DIR = 'With_clustering/stddev_and_mean_method2/'
#else:
#    ensemble_DIR = 'No_organisation/stddev_and_mean_method2/'


# OPTIONS TO CHANGE IF NEEDED
output_DIR = "/srv/ccrc/data45/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging/Ensemble_average/19members/Average_and_std_error_of_the_mean/" + ensemble_DIR
tmp_dir = "/srv/ccrc/data45/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging/Ensemble_average/19members/Average_and_std_error_of_the_mean/" + ensemble_DIR + "/tmp"



# ACTION NOW
pp = Preprocess('RAINNC', data_DIR, output_DIR + data_DIR_appendix, 'rain_rate')
pp.do_work()

exit()




## GET THE RELEVANT FILES
#file_list = glob.glob(data_DIR + "/" + 'wrfout_d01_2007-07-*_05:00:00')
#file_list.sort()
#
#sublist = file_list[ensemble_start_day-1:ensemble_end_day]
#
#
#line_for_CDO = " "
#for file in sublist:
#    line_for_CDO = line_for_CDO + file + "  "
#print ""
#print line_for_CDO
#
#
#
## COMPUTE THE HORIZONTAL MEAN
#for file in sublist:
#  sub.check_call('cdo fldmean ' + file + tmp_DIR + "/" + "fldmean." + name_output_file, shell=True)
