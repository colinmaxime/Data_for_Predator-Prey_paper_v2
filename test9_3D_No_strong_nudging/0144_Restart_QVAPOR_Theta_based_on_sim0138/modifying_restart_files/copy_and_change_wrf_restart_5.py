# This script is to average the values HORIZONTALLY (on x and y) of one of the variable in a WRF restart file.
# It also outputs some plots to check the results of the process. 
# You can also check with ncdump of course...

#TARGET = '/srv/ccrc/data37/z3339052/Raijin_seabreeze2d/test5_Dudhia_advice/32_Same_as_Sim31_Dudhia_advice_Nudging_on_U_6hours_Resolution_1000m_dt=6s/wrfrst_d01_2007-07-24_05:00:00'

TARGET = 'wrfrst_d01_2007-08-*_05:00:00'

import pdb
import shutil
import numpy as np
import netCDF4 as nc4
from matplotlib import *
from pylab import *
import matplotlib.pyplot as plt
import glob


# Variables to average and other parameters
#var_to_average_array = np.array(['U_2','V_2','W_2','QVAPOR','T_2','QCLOUD','QRAIN','QICE','QSNOW','QGRAUP','PH_2','MU_2','TKE_2'])
#var_to_average_array = np.array(['U_2','V_2','W_2','QVAPOR','T_2','QCLOUD','QRAIN','PH_2','MU_2','TKE_2'])
var_to_average_array = np.array(['QVAPOR','T_2'])
plot_axis = 3



list_4D_variables = ['U_2','V_2','W_2','QVAPOR','T_2','QCLOUD','QRAIN','QICE','QSNOW','QGRAUP','PH_2','TKE_2','U_1', 'V_1','W_1','T_1','PH_1','TKE_1']
list_3D_variables = ['MU_2', 'MU_1']

def do_the_job(source_name, target_name):
    shutil.copyfile(source_name, target_name)
    
    ifile = nc4.Dataset(target_name, 'a') 

    var = ifile.variables[var_to_average]

    data = var[:]
    print(data.shape)

    y = data.mean(axis=3,dtype=np.float64)
    y2 = y.mean(axis=2,dtype=np.float64)[0]
    y2.squeeze()
    #print('y is ', y.shape)
    #print('y2 is', y2.shape)
    #print('This is y2', y2)


    # David's method
    for i in xrange(len(y2)):
        var[0, i] = y2[i]

    # Nidhi's method
    #print(data.shape[0])
    #print(data.shape[1])
    #for t in xrange(data.shape[0]):
    #    for k in xrange(data.shape[1]):
    #        var[t,k,:,:] = y2[k]

    print('var[:] is', var[:].shape)

    ifile.sync()
    ifile.close()

#pdb.set_trace()




def do_the_job_2d_variable(source_name, target_name):
    shutil.copyfile(source_name, target_name)

    ifile = nc4.Dataset(target_name, 'a')

    var = ifile.variables[var_to_average]

    data = var[:]
    print(data.shape)

    y = data.mean(axis=2,dtype=np.float64)
    y2 = y.mean(axis=1,dtype=np.float64)[0]
    y2.squeeze()
    #print('y is ', y.shape)
    #print('y2 is', y2.shape)
    #print('This is y2', y2)


    # David's method
    var[0,:] = y2

    # Nidhi's method
    #print(data.shape[0])
    #print(data.shape[1])
    #print(data.shape[2])
    #for t in xrange(data.shape[0]):
    #    for j in xrange(data.shape[1]):
    #        for i in xrange(data.shape[2]):
    #            var[t,j,i] = y2

    print('var[:] is', var[:].shape)

    ifile.sync()
    ifile.close()




def plot_function(source_name):
    
    ifile = nc4.Dataset(source_name, 'a')

    var = ifile.variables[var_to_average]

    data = var[:]
    print(data.shape)

    if plot_axis == 0:
        plot_array = var[:,0,0,0]
        along_axis = '_along_t'
    elif plot_axis == 1:
        plot_array = var[0,:,0,0]
        along_axis = '_along_z'
    elif plot_axis == 2:
        plot_array = var[0,0,:,0]
        along_axis = '_along_y'
    elif plot_axis == 3:
        plot_array = var[0,10,0,:]
        along_axis = '_along_x'


    # Actually Plot the data
    plt.plot(plot_array[:], 'b-')
    plt.plot([0,len(plot_array)], [0,0],'k-') 

    plt.ylabel(var_to_average  + ' after averaging (in ' + var.units + ')' , fontsize= 12, fontweight="bold")
    plt.xlabel('index' + along_axis, fontsize= 12, fontweight="bold")
    plt.title(var_to_average + ' (after HORIZONTAL averaging)' + ' vs the index' + along_axis, fontsize= 12, fontweight="bold")

    plt.savefig(var_to_average + '_after_averaging' + along_axis + '_z=10_David_method_auto.eps')
    plt.show()
    pass




def plot_function_2d_variable(source_name):

    ifile = nc4.Dataset(source_name, 'a')

    var = ifile.variables[var_to_average]

    data = var[:]
    print(data.shape)

    if plot_axis == 0:
        plot_array = var[:,0,0]
        along_axis = '_along_t'
    elif plot_axis == 2:
        plot_array = var[0,:,0]
        along_axis = '_along_y'
    elif plot_axis == 3:
        plot_array = var[0,0,:]
        along_axis = '_along_x'


    # Actually Plot the data
    plt.plot(plot_array[:], 'b-')
    plt.plot([0,len(plot_array)], [0,0],'k-')

    plt.ylabel(var_to_average  + ' after averaging (in ' + var.units + ')' , fontsize= 12, fontweight="bold")
    plt.xlabel('index' + along_axis, fontsize= 12, fontweight="bold")
    plt.title(var_to_average + ' (after HORIZONTAL averaging)' + ' vs the index' + along_axis, fontsize= 12, fontweight="bold")

    plt.savefig(var_to_average + '_after_averaging' + along_axis + '_z=10_David_method_auto.eps')
    plt.show()
    pass




def find_the_cloud_base(source_file):
    """ This function allows us to find the lowest z-index for which we have cloudy conditions.
        To do this, we look for the indices where we have cloudy conditions, then we extract the minimum value along z out of it.
        Hopefully this gives us the lowest cloud level, which can be a good estimate of the Boundary Layer height """

    ifile = nc4.Dataset(source_file, 'a')
    qcloud_data = ifile.variables['QCLOUD']
    ph_2_data = ifile.variables['PH_2']
    phb_data = ifile.variables['PHB']

    qcloud = qcloud_data[:]
    ph_2 = ph_2_data[:]
    phb = phb_data[:]

    print('qcloud.shape: ',qcloud.shape)
    height = (ph_2 + phb)*1./9.81
    print('height.shape: ', height.shape)

    cloudy_indices = np.array(np.where(qcloud > 0))
    print 'Shape of cloudy_indices: ', np.array(cloudy_indices).shape
    print 'cloudy_indices', cloudy_indices
    minimum_cloudy_indices = np.amin(cloudy_indices, axis=1)
    print 'minimum_cloudy_indices: ',minimum_cloudy_indices
    lowest_cloudy_index = minimum_cloudy_indices[1]
    print 'lowest_cloudy_index: ',lowest_cloudy_index

    minimum_cloudy_heights = height[:,int(lowest_cloudy_index),:,:]
    print 'minimum_cloudy_heights', minimum_cloudy_heights
    minimum_cloudy_heights_average = np.mean(minimum_cloudy_heights)
    print 'minimum_cloudy_heights_average: ', minimum_cloudy_heights_average

    return lowest_cloudy_index






if __name__ == '__main__':

    targets = glob.glob(TARGET)

    if not os.path.exists('./new'):
        os.makedirs('new')
    for tar in targets:
        print "We are dealing with ", tar
        #!cp ./'TARGET' ./'TARGET'+'-work'
        workname = tar + '-work.nc' 
        newname  = './new/' + tar 
        #newname  = tar + '-new.nc' 
        shutil.copyfile(tar, workname)

        for var_to_average in var_to_average_array:
            print 'var_to_average.shape is ', var_to_average.shape
            #print 'type(var_to_average) is ', type(var_to_average)
            print "var_to_average is ", var_to_average
            if var_to_average in list_4D_variables:
                do_the_job(source_name = workname, target_name = newname)
                #plot_function(source_name = newname)
                shutil.copyfile(newname, workname)
            elif var_to_average in list_3D_variables:
                do_the_job_2d_variable(source_name = workname, target_name = newname)
                #plot_function_2d_variable(source_name = newname)
                shutil.copyfile(newname, workname)
            else:
                print """WE DON'T KNOW HOW TO DEAL WITH VARIABLES THAT ARE NOT IN THE LIST OF 3D or 4D VARIABLES AT THE BEGINNING OF THE SCRIPT"""



