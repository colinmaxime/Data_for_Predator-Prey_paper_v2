#This is to change the name of all the wrfrst files from a ***_original_version name to a simple ***_yyyy-mm-dd name.

import glob
import os
import shutil

#experiment = '0140_Restart_QVAPOR_based_on_sim0138'
#data_DIR = '/srv/ccrc/data46/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging/' + experiment + '/modifying_restart_files'
data_DIR = os.getcwd()

os.chdir(data_DIR)

list_of_restart_files = glob.glob('wrfrst_d01_2007-08*_original_version')

for file in list_of_restart_files:
    print "Dealing with ", file
    shorter_filename = file[0:30]
    shutil.copy(file, shorter_filename)

