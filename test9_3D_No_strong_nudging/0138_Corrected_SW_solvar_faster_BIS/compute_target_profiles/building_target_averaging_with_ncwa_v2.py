###-----------------------------------------------------------------------------------
# This script will compute a NETCDF file of the TARGET PROFILES of T,q,u,v so as to do STRONG_NUDGING
# in the following restarts.
#
# It will average horizontally as well as on 20 days, in order to get a 1D profile that only depends
# on z, for each variable T,q,u,v.
# We choose the 20 days by taking the 10 days before the restart AND the 10 days after the restart of
# the control simulation (see file_list[i:i+20] and file_list[10,-10]).
###-----------------------------------------------------------------------------------



import glob
import os
import shutil
import subprocess as sub
import netCDF4 as nc4
import numpy as np

import tempfile
import sys
#import uuid

from contextlib import closing
#import settings as cfg

sub.check_call('module load cdo', shell=True)
sub.check_call('module load nco', shell=True)


###-------------------------PICK AN EXPERIMENT--------------------------------------------------------

#data_DIR_appendix = "0120_Restart_U_V_W_QVAPOR_MU_based_on_sim0107"
#name_output_file  = "wrfout_d01_U_V_W_QVAPOR_MU_day1.nc"

prefix_DIR = "/srv/ccrc/data46/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging/"
data_DIR   = prefix_DIR + "0138_Corrected_SW_solvar_faster"
#output_DIR = prefix_DIR + "0138_Corrected_SW_solvar_faster/compute_target_profiles"
output_DIR =  "/srv/ccrc/data08/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging/0138_Corrected_SW_solvar_faster_BIS/compute_target_profiles"

###---------------------------FUNCTIONS AND OBJECT---------------------------------------------------



class Preprocess(object):

    def __init__(self, vname_array, input_dir_path, output_dir_path, alternate_name=None):
        self.input_dir_path = input_dir_path
        self.output_dir_path = output_dir_path
        if len(vname_array) != 8:
            print "Error: The size of vname_array is expected to be 8"
            sys.exit()
#        for vname in vname_array:
#            self.vname = vname
        self.vname_array = vname_array
        self.alternate_name = alternate_name

        self.step0_output_dir = os.path.join(self.output_dir_path, 'step0')
        self.step1_output_dir = os.path.join(self.output_dir_path, 'step1')
        self.step2_output_dir = os.path.join(self.output_dir_path, 'step2')
        self.step3_output_dir = os.path.join(self.output_dir_path, 'step3')



    def cleanup(self):
        if os.path.exists( self.step0_output_dir ):
            sub.check_call('rm -rf %s' % self.step0_output_dir, shell=True)

        if os.path.exists( self.step1_output_dir ):
            sub.check_call('rm -rf %s' % self.step1_output_dir, shell=True) 

        if os.path.exists( self.step2_output_dir ):
            sub.check_call('rm -rf %s' % self.step2_output_dir, shell=True) 

        if os.path.exists( self.step3_output_dir ):
            sub.check_call('rm -rf %s' % self.step3_output_dir, shell=True) 



    def step0_select_var(self):
        file_list = glob.glob(self.input_dir_path + "/" + 'wrfout_d01_2007-*_05:00:00')
        output_dir = os.path.join(self.output_dir_path, 'step0')

        if not os.path.exists( output_dir ):
            os.makedirs( output_dir )

        for fn in file_list:
            output_path = os.path.join(output_dir, "%s--selected_var" % (os.path.basename(fn)))
            sub.check_call('cdo selname,%s,%s,%s,%s,%s,%s,%s,%s %s %s' % (self.vname_array[0], self.vname_array[1], self.vname_array[2], self.vname_array[3], self.vname_array[4], self.vname_array[5], self.vname_array[6], self.vname_array[7], fn, output_path), shell=True) 



    def step1_file_average(self): 
        file_list = glob.glob(os.path.join(self.output_dir_path, 'step0', 'wrfout_d01_2007-*_05:00:00--selected_var'))
        file_list.sort()
        print os.path.join(self.output_dir_path, 'step0', 'wrfout_d01_2007-*_05:00:00--selected_var')
        print "file_list in step1 is: ", file_list

        # We choose to average over 20 days around file time, so we get rid of the first and last 10 dates! 2016-02-03 Maxime Colin
        sublist = file_list[10:-10]
        print "sublist is: ", sublist
        output_dir = os.path.join(self.output_dir_path, 'step1')

        if not os.path.exists( output_dir ):
            os.makedirs( output_dir )

        for i, fn in enumerate(sublist):
            
            line_for_CDO = " "
            # We choose to average over 20 days around file time! 2016-02-03 Maxime Colin
            for file in file_list[i:i+20]:
                line_for_CDO = line_for_CDO + file + "  "
            print ""
            print "line_for_CDO is: ", line_for_CDO

            output_path = os.path.join(output_dir, "20day_file_mean--%s" % (os.path.basename(fn)))
            sub.check_call('cdo ensmean ' + line_for_CDO + ' ' + output_path, shell=True)



    def step2_horizontal_average(self):
        file_list = glob.glob(os.path.join(self.output_dir_path, 'step1', '20day_file_mean-*'))
        output_dir = os.path.join(self.output_dir_path, 'step2')

        if not os.path.exists( output_dir ):
            os.makedirs( output_dir )        

        for i, fn in enumerate(file_list):
            output_path = os.path.join(output_dir, "fld_mean--%s" % (os.path.basename(fn)))
            sub.check_call('cdo fldmean ' + fn + ' ' + output_path, shell=True)



    def step3_time_average(self):
        file_list = glob.glob(os.path.join(self.output_dir_path, 'step2', 'fld_mean-*'))
        output_dir = os.path.join(self.output_dir_path, 'step3')

        if not os.path.exists( output_dir ):
            os.makedirs( output_dir )

        for i, fn in enumerate(file_list):
            output_path = os.path.join(output_dir, "time_mean--%s" % (os.path.basename(fn)))
            sub.check_call('cdo timmean ' + fn + ' ' + output_path, shell=True)



    def step4_remove_degenerated_dimensions(self):
        file_list = glob.glob(os.path.join(self.output_dir_path, 'step3', 'time_mean-*'))
        output_dir = os.path.join(self.output_dir_path, 'step4')
        copy_dir = os.path.join(self.output_dir_path, 'targets')

        if not os.path.exists( output_dir ):
            os.makedirs( output_dir )
        if not os.path.exists( copy_dir ):
            os.makedirs( copy_dir )

        for i, fn in enumerate(file_list):
            output_path1 = os.path.join(output_dir, "ncwa_lon--%s" % (os.path.basename(fn)))
            output_path2 = os.path.join(output_dir, "ncwa_lat--%s" % (os.path.basename(fn)))
            output_path3 = os.path.join(output_dir, "ncwa_Times--%s" % (os.path.basename(fn)))
            sub.check_call('module load nco', shell=True)
            print "I am just before using ncwa from NCO"
            print "os.path.basename(output_path1) is ", os.path.basename(output_path1)
            print "output_path1 is ", output_path1
            sub.check_call('ncwa -a lon ' + fn +  ' ' + output_path1, shell=True)
            print "We are after the 1st call to ncwa"
            sub.check_call('ncwa -a lat ' + output_path1 +  ' ' + output_path2, shell=True)
            print "We are after the 2nd call to ncwa"
            sub.check_call('ncwa -a Times ' + output_path2 +  ' ' + output_path3, shell=True)
            print "We are after the 3rd call to ncwa"
            #sub.check_call('ncwa -a lon ' + fn +  ' ' + os.path.basename(output_path1), shell=True)
            #sub.check_call('ncwa -a lat ' + os.path.basename(output_path1) +  ' ' + os.path.basename(output_path2), shell=True)
            #sub.check_call('ncwa -a Times ' + os.path.basename(output_path2) +  ' ' + os.path.basename(output_path3), shell=True)

            copy_path = os.path.join(copy_dir, "target_prof--" + os.path.basename(output_path3))
            print "copy_path is ", copy_path
            print "output_path3 is ", output_path3
            shutil.copyfile(output_path3, copy_path)





    def do_work(self):
        self.cleanup()
        self.step0_select_var()
        self.step1_file_average()
        self.step2_horizontal_average()
        self.step3_time_average()
        self.step4_remove_degenerated_dimensions()

        




###------------------------ DOING THE WORK -----------------------------------------------------------




#if with_org == True: 
#    ensemble_start_day = 1
#    ensemble_end_day = 9
#else:
#    ensemble_start_day = 13
#    ensemble_end_day = 30
#
#if with_org == True:
#    ensemble_DIR = 'With_clustering/stddev_and_mean_method2/'
#else:
#    ensemble_DIR = 'No_organisation/stddev_and_mean_method2/'

#tmp_dir = output_DIR + "/tmp"


target_var = np.array(['T','QVAPOR','U','V','PH','PHB','P','PB'])
target_var_shape = target_var.shape
#vname_number_array = np.array(['Th_2','qvapor','u_2','v_2'])

# ACTION NOW
pp = Preprocess(target_var, data_DIR, output_DIR)
pp.do_work()

exit()




