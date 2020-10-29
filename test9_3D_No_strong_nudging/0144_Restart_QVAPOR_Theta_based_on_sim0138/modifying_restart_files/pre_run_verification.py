#To test which variables have been averaged

import pdb
import sys
import shutil
import numpy as np
import netCDF4 as nc4



var_to_average_array = np.array(['U_2','V_2','W_2','QVAPOR','T_2','QCLOUD','QRAIN','QICE','QSNOW','QGRAUP','PH_2','MU_2','TKE_2'])


def check_average(var):

    #if ('bottom_top' and 'bottom_top_stag') not in var.dimensions:
    if 'bottom_top' not in var.dimensions and 'bottom_top_stag' not in var.dimensions:
        #return False # This is not a variable that has a level dimension so we decide to skip it, which is not perfect

        data = var[:]
        value = data.reshape(-1)[0]

        check = data != value

        if np.any(check):
            print "For this variable without vertical dimension, it is NOT averaged", var._name
            return False # data is not averaged

        return True 

    if 'bottom_top' in var.dimensions:
        name_of_vertical_dimension = 'bottom_top'
    elif 'bottom_top_stag' in var.dimensions:
        name_of_vertical_dimension = 'bottom_top_stag'
    else:
        print("It seems that there is no vertical dimensions, so we can't apply this method to check")

    #print "name_of_vertical_dimension", name_of_vertical_dimension 
    vertical_dim = var.dimensions.index(name_of_vertical_dimension)

    data = var[:]

    if vertical_dim != 0:
        data = np.swapaxes(data, 0, vertical_dim)


    for level in xrange(data.shape[0]):
        level_data = data[level]
        value = level_data.reshape(-1)[0]

        check = level_data != value

        if np.any(check):
            print "For this variable, it is NOT averaged", var._name
            return False #level data is not averaged

    return True



def test_averages(args):

    assert len(args) == 1, "expecting a single command line parameter (file name)"

    ifile = nc4.Dataset(args[0])

    #for vn in ifile.variables.keys():
    for vn in var_to_average_array:

        if vn not in ifile.variables.keys():
            print "This variable doesn't exist in the netCDF file", vn
            continue
 
        if check_average(ifile.variables[vn]):
            print "*************Variable %s is averaged***************" % vn

    print "End of the checks"


if __name__ == '__main__':
        test_averages(sys.argv[1:])
