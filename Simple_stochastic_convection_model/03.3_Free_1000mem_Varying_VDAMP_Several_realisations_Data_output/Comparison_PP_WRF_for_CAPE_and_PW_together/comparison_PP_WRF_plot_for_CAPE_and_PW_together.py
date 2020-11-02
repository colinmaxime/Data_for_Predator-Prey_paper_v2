### ---------------------------
### Plot the comparison PP-WRF
### ---------------------------
### Stochastic convection model
### ---------------------------

import numpy as np
import os
import netCDF4 as nc4
import matplotlib
import matplotlib.pyplot as plt
import sys
import netCDF4 as nc4






def dual_plot_comparison_PP_WRF_Ctrl_and_Exp_2_variables(time_WRF_ctrl_list, time_WRF_exp_list, time_PP_list, var_now_WRF_ctrl_list, var_now_WRF_exp_list, var_now_WRF_str_list, var_now_PP_ctrl_list, var_now_PP_exp_list, var_now_PP_str_list, var_now_str_for_title_list, time_min,time_max,ylim_min="None",ylim_max="None"):

    matplotlib.rc('xtick', labelsize=16)
    matplotlib.rc('ytick', labelsize=16)
    #matplotlib.rc('text', usetex=True)
    #matplotlib.rcParams['text.latex.preamble']=[r"\usepackage{bm}"] # In order to write + r'$\bm{\alpha_{damp}}$' +
    #fig, ax1 = plt.subplots()
    plt.figure(figsize=(12,6)) #figsize=(6,15) #figsize=(6,15)  #figsize=(6,13)
    #plt.figure()

    plt.subplot(1, 2, 1)
    #fig, (ax1,ax2) = plt.subplot(3, 1, 1)

    ax1 = plt.gca()
    color = 'r'
    ax1.set_xlabel('Hours', fontsize= 16, fontweight="bold") #'time (hours since homogenization)'
    ax1.set_ylabel('WRF ' + var_now_WRF_str_list[0] , fontsize= 16, fontweight="bold", color=color)
    lns1 = ax1.plot(time_WRF_ctrl_list[0], var_now_WRF_ctrl_list[0], color=color , linewidth=5., linestyle='dashed') #label='WRF Ctrl'
    lns2 = ax1.plot(time_WRF_exp_list[0],var_now_WRF_exp_list[0], color=color , linewidth=5., linestyle='solid', label='WRF') #label='WRF Exp'
    ax1.tick_params(axis='y', labelcolor=color)
    #ax1.set_yticks([17.92,17.94,17.96,17.98,18,18.02,18.04,18.06,18.08])

    ax2 = ax1.twinx()
    color = 'b'
    ax2.set_ylabel('PP ' + var_now_PP_str_list[0], fontsize= 16, fontweight="bold", color=color)
    lns3 = ax2.plot(time_PP_list[0],var_now_PP_ctrl_list[0], color=color , linewidth=4., linestyle='dashed') #label='PP Ctrl'
    lns4 = ax2.plot(time_PP_list[0],var_now_PP_exp_list[0], color=color , linewidth=4., linestyle='solid', label='PP') #label='PP Exp'
    ax2.tick_params(axis='y', labelcolor=color)

    custom_lines = [matplotlib.lines.Line2D([0], [0], color='r', lw=4), matplotlib.lines.Line2D([0], [0], color='b', lw=4)]

    plt.grid()
    plt.gcf().subplots_adjust(bottom=0.12)
    #plt.legend(['PP Ctrl','PP Exp'], fontsize=16, loc='best')
    lns = lns1+lns2+lns3+lns4
    lns_for_legend = lns2+lns4
    labs = [l.get_label() for l in lns]
    #ax1.legend(lns, labs, fontsize=16, loc=0)
    ax1.legend(custom_lines, ['WRF', 'PP'], fontsize= 16)

    plt.xlim(time_min,time_max)
    if ((ylim_min == "None") or (ylim_max == "None")):
        WRF_ctrl_y_mean = np.average(var_now_WRF_ctrl_list[0][0:23])
        WRF_axes_y_max = ax1.get_ylim()[1] #ax1.ylim()[1]
        WRF_axes_y_min = ax1.get_ylim()[0]
        PP_ctrl_y_mean = np.average(var_now_PP_ctrl_list[0][0:20])
        PP_axes_y_max = ax2.get_ylim()[1]
        PP_axes_y_min = ax2.get_ylim()[0]
        Dmin_over_Dmax_PP = float(PP_ctrl_y_mean - PP_axes_y_min)/float(PP_axes_y_max - PP_ctrl_y_mean)
        new_WRF_axes_y_min = WRF_ctrl_y_mean - (WRF_axes_y_max - WRF_ctrl_y_mean)*Dmin_over_Dmax_PP
        ax1.set_ylim(new_WRF_axes_y_min, WRF_axes_y_max)
    else:
        plt.ylim(ylim_min,1.1*ylim_max)

    #plt.xlabel('time (no unit)', fontsize= 16, fontweight="bold")
    #plt.ylabel(var_now_str + ' (no unit)' , fontsize= 16, fontweight="bold")
    #plt.title(var_now_str + ', ' + title_part1 + ', '+ r'$\alpha_{damp}$' +'=' + VDAMP_str + ', ' + nb_mem_str_short + 'mem', fontsize= 16, fontweight="bold")
    #ttl = ax.title
    #ttl.set_position([.5,1.05])

    plt.subplot(1, 2, 2)

    ax1 = plt.gca()
    color = 'r'
    ax1.set_xlabel('Hours', fontsize= 16, fontweight="bold") #'time (hours since homogenization)'
    ax1.set_ylabel('WRF ' + var_now_WRF_str_list[1] , fontsize= 16, fontweight="bold", color=color)
    lns1 = ax1.plot(time_WRF_ctrl_list[1], var_now_WRF_ctrl_list[1], color=color , linewidth=5., linestyle='dashed') #label='WRF Ctrl'
    lns2 = ax1.plot(time_WRF_exp_list[1],var_now_WRF_exp_list[1], color=color , linewidth=5., linestyle='solid', label='WRF') #label='WRF Exp'
    ax1.tick_params(axis='y', labelcolor=color)

    ax2 = ax1.twinx()
    color = 'b'
    ax2.set_ylabel('PP ' + var_now_PP_str_list[1], fontsize= 16, fontweight="bold", color=color)
    lns3 = ax2.plot(time_PP_list[1],var_now_PP_ctrl_list[1], color=color , linewidth=4., linestyle='dashed') #label='PP Ctrl'
    lns4 = ax2.plot(time_PP_list[1],var_now_PP_exp_list[1], color=color , linewidth=4., linestyle='solid', label='PP') #label='PP Exp'
    ax2.tick_params(axis='y', labelcolor=color)

    plt.grid()
    plt.gcf().subplots_adjust(bottom=0.12)
    #plt.legend(['PP Ctrl','PP Exp'], fontsize=16, loc='best')
    lns = lns1+lns2+lns3+lns4
    #labs = [l.get_label() for l in lns]
    #ax1.legend(lns, labs, fontsize=16, loc=0)

    plt.xlim(time_min,time_max)
    if ((ylim_min == "None") or (ylim_max == "None")):
        WRF_ctrl_y_mean = np.average(var_now_WRF_ctrl_list[1][0:23])
        WRF_axes_y_max = ax1.get_ylim()[1] #ax1.ylim()[1]
        WRF_axes_y_min = ax1.get_ylim()[0]
        PP_ctrl_y_mean = np.average(var_now_PP_ctrl_list[1][0:20])
        PP_axes_y_max = ax2.get_ylim()[1]
        PP_axes_y_min = ax2.get_ylim()[0]
        Dmin_over_Dmax_PP = float(PP_ctrl_y_mean - PP_axes_y_min)/float(PP_axes_y_max - PP_ctrl_y_mean)
        new_WRF_axes_y_min = WRF_ctrl_y_mean - (WRF_axes_y_max - WRF_ctrl_y_mean)*Dmin_over_Dmax_PP
        ax1.set_ylim(new_WRF_axes_y_min, WRF_axes_y_max)
    else:
        plt.ylim(ylim_min,1.1*ylim_max)

    plt.tight_layout()
    plt.savefig('./Comparison_PP_WRF_for_CAPE_and_PW_together_macrostate' + '_v11.eps') #bbox_inches='tight'
    plt.savefig('./Comparison_PP_WRF_for_CAPE_and_PW_together_macrostate' + '_v11.png') #bbox_inches='tight'







def multi_plot_comparison_PP_WRF_Ctrl_and_Exp(time_WRF_ctrl_list, time_WRF_exp_list, time_PP_list, var_now_WRF_ctrl_list, var_now_WRF_exp_list, var_now_WRF_str_list, var_now_PP_ctrl_list, var_now_PP_exp_list, var_now_PP_str_list, var_now_str_for_title_list, time_min,time_max,ylim_min="None",ylim_max="None"):

    matplotlib.rc('xtick', labelsize=16)
    matplotlib.rc('ytick', labelsize=16)
    #matplotlib.rc('text', usetex=True)
    #matplotlib.rcParams['text.latex.preamble']=[r"\usepackage{bm}"] # In order to write + r'$\bm{\alpha_{damp}}$' +
    #fig, ax1 = plt.subplots()
    plt.figure(figsize=(6,15)) #figsize=(6,15)  #figsize=(6,13)
    #plt.figure()

    plt.subplot(3, 1, 1)
    #fig, (ax1,ax2) = plt.subplot(3, 1, 1)

    ax1 = plt.gca()
    color = 'r'
    ax1.set_xlabel('Hours', fontsize= 16, fontweight="bold") #'time (hours since homogenization)'
    ax1.set_ylabel('WRF ' + var_now_WRF_str_list[0] , fontsize= 16, fontweight="bold", color=color)
    lns1 = ax1.plot(time_WRF_ctrl_list[0], var_now_WRF_ctrl_list[0], color=color , linewidth=5., linestyle='dashed') #label='WRF Ctrl'
    lns2 = ax1.plot(time_WRF_exp_list[0],var_now_WRF_exp_list[0], color=color , linewidth=5., linestyle='solid', label='WRF') #label='WRF Exp'
    ax1.tick_params(axis='y', labelcolor=color)
    #ax1.set_yticks([17.92,17.94,17.96,17.98,18,18.02,18.04,18.06,18.08])

    ax2 = ax1.twinx()
    color = 'b'
    ax2.set_ylabel('PP ' + var_now_PP_str_list[0], fontsize= 16, fontweight="bold", color=color)
    lns3 = ax2.plot(time_PP_list[0],var_now_PP_ctrl_list[0], color=color , linewidth=4., linestyle='dashed') #label='PP Ctrl'
    lns4 = ax2.plot(time_PP_list[0],var_now_PP_exp_list[0], color=color , linewidth=4., linestyle='solid', label='PP') #label='PP Exp'
    ax2.tick_params(axis='y', labelcolor=color)

    custom_lines = [matplotlib.lines.Line2D([0], [0], color='r', lw=4), matplotlib.lines.Line2D([0], [0], color='b', lw=4)]

    plt.grid()
    plt.gcf().subplots_adjust(bottom=0.12)
    #plt.legend(['PP Ctrl','PP Exp'], fontsize=16, loc='best')
    lns = lns1+lns2+lns3+lns4
    lns_for_legend = lns2+lns4
    labs = [l.get_label() for l in lns]
    #ax1.legend(lns, labs, fontsize=16, loc=0)
    ax1.legend(custom_lines, ['WRF', 'PP'], fontsize= 16)

    plt.xlim(time_min,time_max)
    if ((ylim_min == "None") or (ylim_max == "None")):
        WRF_ctrl_y_mean = np.average(var_now_WRF_ctrl_list[0][0:23])
        WRF_axes_y_max = ax1.get_ylim()[1] #ax1.ylim()[1]
        WRF_axes_y_min = ax1.get_ylim()[0]
        PP_ctrl_y_mean = np.average(var_now_PP_ctrl_list[0][0:20])
        PP_axes_y_max = ax2.get_ylim()[1]
        PP_axes_y_min = ax2.get_ylim()[0]
        Dmin_over_Dmax_PP = float(PP_ctrl_y_mean - PP_axes_y_min)/float(PP_axes_y_max - PP_ctrl_y_mean)
        new_WRF_axes_y_min = WRF_ctrl_y_mean - (WRF_axes_y_max - WRF_ctrl_y_mean)*Dmin_over_Dmax_PP
        ax1.set_ylim(new_WRF_axes_y_min, WRF_axes_y_max)
    else:
        plt.ylim(ylim_min,1.1*ylim_max)

    #plt.xlabel('time (no unit)', fontsize= 16, fontweight="bold")
    #plt.ylabel(var_now_str + ' (no unit)' , fontsize= 16, fontweight="bold")
    #plt.title(var_now_str + ', ' + title_part1 + ', '+ r'$\alpha_{damp}$' +'=' + VDAMP_str + ', ' + nb_mem_str_short + 'mem', fontsize= 16, fontweight="bold")
    #ttl = ax.title
    #ttl.set_position([.5,1.05])

    plt.subplot(3, 1, 2)

    ax1 = plt.gca()
    color = 'r'
    ax1.set_xlabel('Hours', fontsize= 16, fontweight="bold") #'time (hours since homogenization)'
    ax1.set_ylabel('WRF ' + var_now_WRF_str_list[1] , fontsize= 16, fontweight="bold", color=color)
    lns1 = ax1.plot(time_WRF_ctrl_list[1], var_now_WRF_ctrl_list[1], color=color , linewidth=5., linestyle='dashed') #label='WRF Ctrl'
    lns2 = ax1.plot(time_WRF_exp_list[1],var_now_WRF_exp_list[1], color=color , linewidth=5., linestyle='solid', label='WRF') #label='WRF Exp'
    ax1.tick_params(axis='y', labelcolor=color)

    ax2 = ax1.twinx()
    color = 'b'
    ax2.set_ylabel('PP ' + var_now_PP_str_list[1], fontsize= 16, fontweight="bold", color=color)
    lns3 = ax2.plot(time_PP_list[1],var_now_PP_ctrl_list[1], color=color , linewidth=4., linestyle='dashed') #label='PP Ctrl'
    lns4 = ax2.plot(time_PP_list[1],var_now_PP_exp_list[1], color=color , linewidth=4., linestyle='solid', label='PP') #label='PP Exp'
    ax2.tick_params(axis='y', labelcolor=color)

    plt.grid()
    plt.gcf().subplots_adjust(bottom=0.12)
    #plt.legend(['PP Ctrl','PP Exp'], fontsize=16, loc='best')
    lns = lns1+lns2+lns3+lns4
    #labs = [l.get_label() for l in lns]
    #ax1.legend(lns, labs, fontsize=16, loc=0)

    plt.xlim(time_min,time_max)
    if ((ylim_min == "None") or (ylim_max == "None")):
        WRF_ctrl_y_mean = np.average(var_now_WRF_ctrl_list[1][0:23])
        WRF_axes_y_max = ax1.get_ylim()[1] #ax1.ylim()[1]
        WRF_axes_y_min = ax1.get_ylim()[0]
        PP_ctrl_y_mean = np.average(var_now_PP_ctrl_list[1][0:20])
        PP_axes_y_max = ax2.get_ylim()[1]
        PP_axes_y_min = ax2.get_ylim()[0]
        Dall_over_Dmin_PP = float(PP_axes_y_max - 0)/float(PP_ctrl_y_mean - 0)
        new_WRF_axes_y_max = 0 + (WRF_ctrl_y_mean - 0)*Dall_over_Dmin_PP
        ax1.set_ylim(0, new_WRF_axes_y_max)
        ax2.set_ylim(0, PP_axes_y_max)
    else:
        plt.ylim(ylim_min,1.1*ylim_max)


    plt.subplot(3, 1, 3)

    ax1 = plt.gca()
    color = 'r'
    ax1.set_xlabel('Hours', fontsize= 16, fontweight="bold")  #'time (hours since homogenization)'
    ax1.set_ylabel('WRF ' + var_now_WRF_str_list[2] , fontsize= 16, fontweight="bold", color=color)
    lns1 = ax1.plot(time_WRF_ctrl_list[2], var_now_WRF_ctrl_list[2], color=color , linewidth=5., linestyle='dashed') #label='WRF Ctrl'
    lns2 = ax1.plot(time_WRF_exp_list[2],var_now_WRF_exp_list[2], color=color , linewidth=5., linestyle='solid', label='WRF') #label='WRF Exp'
    ax1.tick_params(axis='y', labelcolor=color)

    ax2 = ax1.twinx()
    color = 'b'
    ax2.set_ylabel('PP ' + var_now_PP_str_list[2], fontsize= 16, fontweight="bold", color=color)
    lns3 = ax2.plot(time_PP_list[2],var_now_PP_ctrl_list[2], color=color , linewidth=4., linestyle='dashed') #label='PP Ctrl'
    lns4 = ax2.plot(time_PP_list[2],var_now_PP_exp_list[2], color=color , linewidth=4., linestyle='solid', label='PP') #label='PP Exp'
    ax2.tick_params(axis='y', labelcolor=color)

    plt.grid()
    plt.gcf().subplots_adjust(bottom=0.12)
    #plt.legend(['PP Ctrl','PP Exp'], fontsize=16, loc='best')
    lns = lns1+lns2+lns3+lns4
    #labs = [l.get_label() for l in lns]
    #ax1.legend(lns, labs, fontsize=16, loc=0)

    plt.xlim(time_min,time_max)
    if ((ylim_min == "None") or (ylim_max == "None")):
        WRF_ctrl_y_mean = np.average(var_now_WRF_ctrl_list[2][0:23])
        WRF_axes_y_max = ax1.get_ylim()[1] #ax1.ylim()[1]
        WRF_axes_y_min = ax1.get_ylim()[0]
        PP_ctrl_y_mean = np.average(var_now_PP_ctrl_list[2][0:20])
        PP_axes_y_max = ax2.get_ylim()[1]
        PP_axes_y_min = ax2.get_ylim()[0]
        Dall_over_Dmin_PP = float(PP_axes_y_max - PP_axes_y_min)/float(PP_ctrl_y_mean - PP_axes_y_min)
        new_WRF_axes_y_max = 0 + (WRF_ctrl_y_mean - 0)*Dall_over_Dmin_PP
        ax1.set_ylim(0, new_WRF_axes_y_max)
    else:
        plt.ylim(ylim_min,1.1*ylim_max)



    plt.tight_layout()
    plt.savefig('./Comparison_PP_WRF_for_PW_ALL' + '_v11.eps') #bbox_inches='tight'
    plt.savefig('./Comparison_PP_WRF_for_PW_ALL' + '_v11.png') #bbox_inches='tight'
    #plt.savefig('./time_series_homog_All_' + var_now_str + '_' + title_part1 + '_VDAMP_' + VDAMP_str + '_first_restart_' + first_restart_str + '_nb_mem_' + nb_mem_str + '_finish_time_' + finish_time_str + '_time_max_' + time_max_str + '_v2.png') #bbox_inches='tight'
    #plt.show()




def plot_comparison_PP_WRF_Ctrl_and_Exp(time_WRF_ctrl,time_WRF_exp,time_PP,var_now_WRF_ctrl,var_now_WRF_exp,var_now_WRF_str,var_now_PP_ctrl,var_now_PP_exp,var_now_PP_str,var_now_str_for_title,time_min,time_max,ylim_min,ylim_max):
    matplotlib.rc('xtick', labelsize=16)
    matplotlib.rc('ytick', labelsize=16)
    #matplotlib.rc('text', usetex=True)
    #matplotlib.rcParams['text.latex.preamble']=[r"\usepackage{bm}"] # In order to write + r'$\bm{\alpha_{damp}}$' +
    #fig, ax1 = plt.subplots()
    fig = plt.figure()
    ax1 = plt.gca()

    color = 'r'
    ax1.set_xlabel('time (hours since homogenization)', fontsize= 16, fontweight="bold")
    ax1.set_ylabel('WRF ' + var_now_WRF_str , fontsize= 16, fontweight="bold", color=color)
    lns1 = ax1.plot(time_WRF_ctrl,var_now_WRF_ctrl, color=color , linewidth=5., linestyle='dashed', label='WRF Ctrl')
    lns2 = ax1.plot(time_WRF_exp,var_now_WRF_exp, color=color , linewidth=5., linestyle='solid', label='WRF Exp')
    ax1.tick_params(axis='y', labelcolor=color)
    if (var_now_str_for_title == 'Humidity_macrostate'):
        ax1.set_yticks([17.92,17.94,17.96,17.98,18,18.02,18.04,18.06,18.08])
    #ax1.legend(['WRF Ctrl','WRF Exp'], fontsize=16, loc='best')
    #plt.plot(var_now_ctrl, color='k' , linewidth=4.)
    #plt.plot(var_now, color='c' , linewidth=2.)

    ax2 = ax1.twinx()
    color = 'b'
    ax2.set_ylabel('PP ' + var_now_PP_str , fontsize= 16, fontweight="bold", color=color)
    lns3 = ax2.plot(time_PP,var_now_PP_ctrl, color=color , linewidth=4., linestyle='dashed', label='PP Ctrl')
    lns4 = ax2.plot(time_PP,var_now_PP_exp, color=color , linewidth=4., linestyle='solid', label='PP Exp')
    ax2.tick_params(axis='y', labelcolor=color)

    plt.grid()
    plt.gcf().subplots_adjust(bottom=0.12)
    #plt.legend(['PP Ctrl','PP Exp'], fontsize=16, loc='best')
    lns = lns1+lns2+lns3+lns4
    labs = [l.get_label() for l in lns]
    ax1.legend(lns, labs, fontsize=16, loc=0)

    plt.xlim(time_min,time_max)
    if ((ylim_min == "None") or (ylim_max == "None")):
        WRF_ctrl_y_mean = np.average(var_now_WRF_ctrl[0:23])
        WRF_axes_y_max = ax1.get_ylim()[1] #ax1.ylim()[1]
        WRF_axes_y_min = ax1.get_ylim()[0]
        PP_ctrl_y_mean = np.average(var_now_PP_ctrl[0:20])
        PP_axes_y_max = ax2.get_ylim()[1]
        PP_axes_y_min = ax2.get_ylim()[0]
        if (var_now_str_for_title == 'PW_macrostate'):
            Dmin_over_Dmax_PP = float(PP_ctrl_y_mean - PP_axes_y_min)/float(PP_axes_y_max - PP_ctrl_y_mean)
            new_WRF_axes_y_min = WRF_ctrl_y_mean - (WRF_axes_y_max - WRF_ctrl_y_mean)*Dmin_over_Dmax_PP
            print "WRF_ctrl_y_mean ", WRF_ctrl_y_mean
            print "WRF_axes_y_max ", WRF_axes_y_max
            print "WRF_axes_y_min ", WRF_axes_y_min
            print "PP_ctrl_y_mean ", PP_ctrl_y_mean
            print "PP_axes_y_max ", PP_axes_y_max
            print "PP_axes_y_min ", PP_axes_y_min
            print "Dmin_over_Dmax_PP ", Dmin_over_Dmax_PP
            print "new_WRF_axes_y_min ", new_WRF_axes_y_min
            ax1.set_ylim(new_WRF_axes_y_min, WRF_axes_y_max)
        elif (var_now_str_for_title == 'PW_microstate'):
            Dall_over_Dmin_PP = float(PP_axes_y_max - 0)/float(PP_ctrl_y_mean - 0)
            new_WRF_axes_y_max = 0 + (WRF_ctrl_y_mean - 0)*Dall_over_Dmin_PP
            ax1.set_ylim(0, new_WRF_axes_y_max)
            ax2.set_ylim(0, PP_axes_y_max)
        elif (var_now_str_for_title == 'Precipitation'):
            Dall_over_Dmin_PP = float(PP_axes_y_max - PP_axes_y_min)/float(PP_ctrl_y_mean - PP_axes_y_min)
            new_WRF_axes_y_max = 0 + (WRF_ctrl_y_mean - 0)*Dall_over_Dmin_PP
            ax1.set_ylim(0, new_WRF_axes_y_max)
    else:
        plt.ylim(ylim_min,1.1*ylim_max)

    #plt.xlabel('time (no unit)', fontsize= 16, fontweight="bold")
    #plt.ylabel(var_now_str + ' (no unit)' , fontsize= 16, fontweight="bold")
    #plt.title(var_now_str + ', ' + title_part1 + ', '+ r'$\alpha_{damp}$' +'=' + VDAMP_str + ', ' + nb_mem_str_short + 'mem', fontsize= 16, fontweight="bold")
    #ttl = ax.title
    #ttl.set_position([.5,1.05])
    fig.tight_layout()
    plt.savefig('./Comparison_PP_WRF_for_PW_' + var_now_str_for_title + '_v8.eps') #bbox_inches='tight'
    plt.savefig('./Comparison_PP_WRF_for_PW_' + var_now_str_for_title + '_v8.png') #bbox_inches='tight'
    #plt.savefig('./time_series_homog_All_' + var_now_str + '_' + title_part1 + '_VDAMP_' + VDAMP_str + '_first_restart_' + first_restart_str + '_nb_mem_' + nb_mem_str + '_finish_time_' + finish_time_str + '_time_max_' + time_max_str + '_v2.png') #bbox_inches='tight'
    #plt.show()




def plot_time_series_simple_model(R,P,V,time_min,time_max,ylim_min,ylim_max, VDAMP, Str_nudg, V_stochastic, P_stochastic, Ctrl_run, Exp_ave, Final_plot, first_restart, nb_mem, finish_time):
    matplotlib.rc('xtick', labelsize=16)
    matplotlib.rc('ytick', labelsize=16)
    fig = plt.figure()
    ax = plt.gca()

    VDAMP_str = '%2.1f'%VDAMP
    if Str_nudg:
        title_part1 = 'Nudged'
    else:
        title_part1 = 'Free'
    if not V_stochastic:
        title_part1 = title_part1 + '_no_V_stoc'
    if not P_stochastic:
        title_part1 = title_part1 + '_no_P_stoc'
    first_restart_str = '%.3i'%first_restart
    nb_mem_str = '%.3i'%nb_mem
    finish_time_str = '%.3i'%finish_time

    #plt.plot(time, var_to_plot_array[plot_number], color=colors[plot_number] , linewidth=2.)
    plt.plot(R, color='k' , linewidth=2.)
    plt.plot(P, color='r' , linewidth=2.)
    plt.plot(V, color='g' , linewidth=2.)

    plt.grid()
    plt.gcf().subplots_adjust(bottom=0.12)
    plt.legend(['r','P','V'], fontsize=16, loc='best')
    plt.xlim(time_min,time_max)
    if ((ylim_min == "None") or (ylim_max == "None")):
        plt.ylim(plt.ylim()[0], plt.ylim()[1])
    else:
        plt.ylim(ylim_min,1.1*ylim_max)

    plt.xlabel('time (no unit)', fontsize= 16, fontweight="bold")
    plt.ylabel('r, P, V (no unit)' , fontsize= 16, fontweight="bold")
    if Ctrl_run:
        plt.title(title_part1 + ', ' + r'$\alpha_{damp}$' + '=' + VDAMP_str + ', Ctrl', fontsize= 16, fontweight="bold")
    if Exp_ave:
        plt.title(title_part1 + ', ' + r'$\alpha_{damp}$' + '=' + VDAMP_str + ', Exp_ave', fontsize= 16, fontweight="bold")
    if Final_plot:
        plt.title(title_part1 + ', ' + r'$\alpha_{damp}$' + '=' + VDAMP_str + ', All', fontsize= 16, fontweight="bold")
    ttl = ax.title
    ttl.set_position([.5,1.05])
    fig.tight_layout()
    if Ctrl_run:
        plt.savefig('./time_series_homog_Ctrl_' + title_part1 + '_VDAMP_' + VDAMP_str + '_v2.eps') #bbox_inches='tight'
        plt.savefig('./time_series_homog_Ctrl_' + title_part1 + '_VDAMP_' + VDAMP_str + '_v2.png') #bbox_inches='tight'
    if Exp_ave:
        plt.savefig('./time_series_homog_Exp_ave_' + title_part1 + '_VDAMP_' + VDAMP_str + '_first_restart_' + first_restart_str + '_nb_mem_' + nb_mem_str + '_finish_time_' + finish_time_str + '_v2.eps') #bbox_inches='tight'
        plt.savefig('./time_series_homog_Exp_ave_' + title_part1 + '_VDAMP_' + VDAMP_str + '_first_restart_' + first_restart_str + '_nb_mem_' + nb_mem_str + '_finish_time_' + finish_time_str + '_v2.png') #bbox_inches='tight'
    if Final_plot:
        plt.savefig('./time_series_homog_All_' + title_part1 + '_VDAMP_' + VDAMP_str + '_first_restart_' + first_restart_str + '_nb_mem_' + nb_mem_str + '_finish_time_' + finish_time_str + '_v2.eps') #bbox_inches='tight'
        plt.savefig('./time_series_homog_All_' + title_part1 + '_VDAMP_' + VDAMP_str + '_first_restart_' + first_restart_str + '_nb_mem_' + nb_mem_str + '_finish_time_' + finish_time_str + '_v2.png') #bbox_inches='tight'
    #plt.show()




def plot_time_series_simple_model_Ctrl_and_Exp(var_now,var_now_ctrl,time_min,time_max,ylim_min,ylim_max, VDAMP, Str_nudg, V_stochastic, P_stochastic, first_restart, nb_mem, finish_time, var_now_str, Method):
    matplotlib.rc('xtick', labelsize=16)
    matplotlib.rc('ytick', labelsize=16)
    #matplotlib.rc('text', usetex=True)
    #matplotlib.rcParams['text.latex.preamble']=[r"\usepackage{bm}"] # In order to write + r'$\bm{\alpha_{damp}}$' +
    fig = plt.figure()
    ax = plt.gca()

    VDAMP_str = '%2.1f'%VDAMP
    if Str_nudg:
        title_part1 = 'Nudged'
    else:
        title_part1 = 'Free'
    if not V_stochastic:
        title_part1 = title_part1 + '_no_V_stoc'
    if not P_stochastic:
        title_part1 = title_part1 + '_no_P_stoc'
    first_restart_str = '%.3i'%first_restart
    nb_mem_str = '%.3i'%nb_mem
    nb_mem_str_short = '%.1i'%nb_mem
    finish_time_str = '%.3i'%finish_time
    Method_str = '%.1i'%Method
    time_max_str = '%.3i'%time_max

    #plt.plot(time, var_to_plot_array[plot_number], color=colors[plot_number] , linewidth=2.)
    plt.plot(var_now_ctrl, color='k' , linewidth=4.)
    plt.plot(var_now, color='c' , linewidth=2.)

    plt.grid()
    plt.gcf().subplots_adjust(bottom=0.12)
    plt.legend(['CTRL','V=0,Mtd=' + Method_str], fontsize=16, loc='best')
    plt.xlim(time_min,time_max)
    if ((ylim_min == "None") or (ylim_max == "None")):
        plt.ylim(plt.ylim()[0], plt.ylim()[1])
    else:
        plt.ylim(ylim_min,1.1*ylim_max)

    plt.xlabel('time (no unit)', fontsize= 16, fontweight="bold")
    plt.ylabel(var_now_str + ' (no unit)' , fontsize= 16, fontweight="bold")
    plt.title(var_now_str + ', ' + title_part1 + ', '+ r'$\alpha_{damp}$' +'=' + VDAMP_str + ', ' + nb_mem_str_short + 'mem', fontsize= 16, fontweight="bold")
    ttl = ax.title
    ttl.set_position([.5,1.05])
    fig.tight_layout()
    plt.savefig('./time_series_homog_All_' + var_now_str + '_' + title_part1 + '_VDAMP_' + VDAMP_str + '_first_restart_' + first_restart_str + '_nb_mem_' + nb_mem_str + '_finish_time_' + finish_time_str + '_time_max_' + time_max_str + '_v2.eps') #bbox_inches='tight'
    plt.savefig('./time_series_homog_All_' + var_now_str + '_' + title_part1 + '_VDAMP_' + VDAMP_str + '_first_restart_' + first_restart_str + '_nb_mem_' + nb_mem_str + '_finish_time_' + finish_time_str + '_time_max_' + time_max_str + '_v2.png') #bbox_inches='tight'
    #plt.show()






def plot_hist_stochastic_variables(count,bins,var_to_plot,var_for_title):
    matplotlib.rc('xtick', labelsize=16)
    matplotlib.rc('ytick', labelsize=16)
    fig = plt.figure()
    ax = plt.gca()

    plt.plot(bins,count, color='k' , linewidth=2.)

    plt.grid()
    plt.gcf().subplots_adjust(bottom=0.12)
    #plt.xlim(time_min,time_max)
    #if ((ylim_min == "None") or (ylim_max == "None")):
    #    plt.ylim(plt.ylim()[0], plt.ylim()[1])
    #else:
    #    plt.ylim(ylim_min,1.1*ylim_max)

    plt.xlabel('Stochastic number ' + var_for_title + ' (no unit)', fontsize= 16, fontweight="bold")
    plt.ylabel('PDF (normalised)' , fontsize= 16, fontweight="bold")
    plt.title('PDF of ' + var_for_title, fontsize= 16, fontweight="bold")
    ttl = ax.title
    ttl.set_position([.5,1.05])
    plt.savefig('./hist_' + var_to_plot + '_after_clip_v1.png')

    plt.xlabel('Stochastic number ' + var_to_plot + ' (no unit)', fontsize= 16, fontweight="bold")
    plt.ylabel('PDF (normalised)' , fontsize= 16, fontweight="bold")
    plt.title('PDF of ' + var_to_plot, fontsize= 16, fontweight="bold")
    plt.savefig('./hist_' + var_to_plot + '_after_clip_v0.png')



def time_integration(R,V,P,N,Ve,Pe2,Str_nudg_h,Rforce_h):

    for i in xrange(1,N):

        # RH / CAPE is consumed by rain but gained by evap/radiation.
        R[i] = R[i-1] - P[i-1] + EVAP
        if Str_nudg_h:
            R[i] = Rforce_h*1.0

        # Subgrid variance is enhanced by rain and has inertia and damping
        V[i] = V[i-1]*(1-VDAMP) + VPSENS*P[i-1] + Ve[i]
        #V[i] = 3.0


        # Precipitation is promoted by RH/CAPE and by subgrid, here linearised.
        # Also has random element.
        P[i] = PSENS*R[i]*V[i] * (Pe2[i])
        #P[i] = EVAP

    return [R,V,P]




def compute_ensemble_average(member_array):

    member_array = np.array(member_array)
    member_array_ave = np.average(member_array, axis=0)
    return member_array_ave



def compute_RCE_value_of_r(R_ctrl,time_RCE_start,time_RCE_end):
    R_ctrl_extract = R_ctrl[time_RCE_start:time_RCE_end]
    print "R_ctrl_extract.shape ", R_ctrl_extract.shape
    return np.average(R_ctrl_extract)



#---------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------



PP_model_data_file = "/home/z3339052/Raijin_seabreeze2d/Simple_stochastic_convection_model/03.3_Free_1000mem_Varying_VDAMP_Several_realisations_Data_output/PP_model_output_ensemble_averages_v1.txt"

#WRF_ctrl_data_file = "/home/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging/Ensemble_averages/B_The_single_variable_impact/Analysis/more_variables/19members/compute_Ens_average_One_exp_Improved/Ens_member_ave_More_variables_test9_0138_Corrected_SW_solvar_faster_19mem_v1.nc"
#WRF_exp_data_file = "/home/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging/Ensemble_averages/D_The_double_variable_impact/Analysis/more_variables/19members/compute_Ens_average_One_exp_Improved/Ens_member_ave_More_variables_test9_0144_Restart_QVAPOR_Theta_based_on_sim0138_19mem_v1.nc"
WRF_ctrl_data_file = "/home/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging/Ensemble_averages/B_The_single_variable_impact/Analysis/more_variables/19members/compute_Ens_average_One_exp_Improved_More_var/Ens_member_ave_More_variables_test9_0138_Corrected_SW_solvar_faster_19mem_v1.nc"
WRF_exp_data_file = "/home/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging/Ensemble_averages/D_The_double_variable_impact/Analysis/more_variables/19members/compute_Ens_average_One_exp_Improved_More_var/Ens_member_ave_More_variables_test9_0144_Restart_QVAPOR_Theta_based_on_sim0138_19mem_v1.nc"

restart_count_days = 18.
output_dt = 15. 

PP_time_scaling_factor = 6./20.   #6./19.   #6./20.
#PP_rain_rate_scaling_factor = 3.5/0.3
#PP_qvapor_macrostate_scaling_factor = 0.13/2.0
#PP_qvapor_microstate_scaling_factor = 0.5/2.0


# Prepare the variables from WRF control ensemble average

ifile_WRF_ctrl = nc4.Dataset(WRF_ctrl_data_file, 'a')
time_hour_from_zero_WRF_ctrl        = ifile_WRF_ctrl.variables['TIME_HOUR_FROM_ZERO'][:] - 24*restart_count_days
cape_2D_macrostate_WRF_ctrl         = ifile_WRF_ctrl.variables['CAPE_2D_HOR_AVE_MEMBERS_AVE'][:]
cape_2D_microstate_WRF_ctrl         = ifile_WRF_ctrl.variables['CAPE_2D_HOR_STD_MEMBERS_AVE'][:]
pw_get_macrostate_WRF_ctrl          = ifile_WRF_ctrl.variables['PW_GET_HOR_AVE_MEMBERS_AVE'][:]
pw_get_microstate_WRF_ctrl          = ifile_WRF_ctrl.variables['PW_GET_HOR_STD_MEMBERS_AVE'][:]
rain_rate_WRF_ctrl                  = ifile_WRF_ctrl.variables['RAIN_RATE_HOR_AVE_MEMBERS_AVE'][:]

time_hour_from_zero_WRF_ctrl_adapted_for_integrated = time_hour_from_zero_WRF_ctrl + (output_dt/2.)/60.
time_hour_from_zero_WRF_ctrl_adapted_for_integrated_shorter = time_hour_from_zero_WRF_ctrl_adapted_for_integrated[0:-1] 


# Prepare the variables from WRF experiment (Qvap and Theta homogenisation) ensemble average

ifile_WRF_exp = nc4.Dataset(WRF_exp_data_file, 'a')
time_hour_from_zero_WRF_exp        = ifile_WRF_exp.variables['TIME_HOUR_FROM_ZERO'][:] - 24*restart_count_days
cape_2D_macrostate_WRF_exp         = ifile_WRF_exp.variables['CAPE_2D_HOR_AVE_MEMBERS_AVE'][:]
cape_2D_microstate_WRF_exp         = ifile_WRF_exp.variables['CAPE_2D_HOR_STD_MEMBERS_AVE'][:]
pw_get_macrostate_WRF_exp          = ifile_WRF_exp.variables['PW_GET_HOR_AVE_MEMBERS_AVE'][:]
pw_get_microstate_WRF_exp          = ifile_WRF_exp.variables['PW_GET_HOR_STD_MEMBERS_AVE'][:]
rain_rate_WRF_exp                  = ifile_WRF_exp.variables['RAIN_RATE_HOR_AVE_MEMBERS_AVE'][:]

time_hour_from_zero_WRF_exp_adapted_for_integrated = time_hour_from_zero_WRF_exp + (output_dt/2.)/60.
time_hour_from_zero_WRF_exp_adapted_for_integrated_shorter = time_hour_from_zero_WRF_exp_adapted_for_integrated[0:-1]



# Prepare the variables from Predator-Prey (PP) model

time_index = []
V_ctrl_ens_ave = []
R_ctrl_ens_ave = []
P_ctrl_ens_ave = []
V_ens_ave = []
R_ens_ave = []
P_ens_ave = []

with open(PP_model_data_file, 'r') as f:
    header1 = f.readline()
    for line in f:
        line = line.strip()
        columns = line.split()
        time_index.append(float(columns[0]))
        V_ctrl_ens_ave.append(float(columns[1]))
        R_ctrl_ens_ave.append(float(columns[2]))
        P_ctrl_ens_ave.append(float(columns[3]))
        V_ens_ave.append(float(columns[4]))
        R_ens_ave.append(float(columns[5]))
        P_ens_ave.append(float(columns[6]))

time_index = np.array(time_index)
V_ctrl_ens_ave = np.array(V_ctrl_ens_ave)
R_ctrl_ens_ave = np.array(R_ctrl_ens_ave)
P_ctrl_ens_ave = np.array(P_ctrl_ens_ave)
V_ens_ave = np.array(V_ens_ave)
R_ens_ave = np.array(R_ens_ave)
P_ens_ave = np.array(P_ens_ave)

print "time_index ", time_index
print "time_hour_from_zero_WRF_ctrl ", time_hour_from_zero_WRF_ctrl


# Plot CAPE and PW variables on the same Dual-Plot
time_min = 0.
time_max = 6.

time_WRF_ctrl_list = [time_hour_from_zero_WRF_ctrl, time_hour_from_zero_WRF_ctrl]
time_WRF_exp_list = [time_hour_from_zero_WRF_exp, time_hour_from_zero_WRF_exp]
time_PP_list = [time_index*PP_time_scaling_factor, time_index*PP_time_scaling_factor]
var_now_WRF_ctrl_list = [cape_2D_macrostate_WRF_ctrl, pw_get_macrostate_WRF_ctrl]
var_now_WRF_exp_list = [cape_2D_macrostate_WRF_exp, pw_get_macrostate_WRF_exp]
var_now_WRF_str_list = ['CAPE macrostate (J/kg)', 'PW macrostate (mm)']
var_now_PP_ctrl_list = [R_ctrl_ens_ave, R_ctrl_ens_ave]
var_now_PP_exp_list = [R_ens_ave, R_ens_ave]
var_now_PP_str_list = ['R (unitless)', 'R (unitless)']
var_now_str_for_title_list = ['CAPE_macrostate', 'PW_macrostate']

dual_plot_comparison_PP_WRF_Ctrl_and_Exp_2_variables(time_WRF_ctrl_list, time_WRF_exp_list, time_PP_list, var_now_WRF_ctrl_list, var_now_WRF_exp_list, var_now_WRF_str_list, var_now_PP_ctrl_list, var_now_PP_exp_list, var_now_PP_str_list, var_now_str_for_title_list, time_min,time_max,ylim_min="None",ylim_max="None")



## Plot the 3 variables
#time_min = 0.
#time_max = 6.
#
#plot_comparison_PP_WRF_Ctrl_and_Exp(time_hour_from_zero_WRF_ctrl, time_hour_from_zero_WRF_exp, time_index*PP_time_scaling_factor, pw_get_macrostate_WRF_ctrl, pw_get_macrostate_WRF_exp, 'PW macrostate (mm)', R_ctrl_ens_ave, R_ens_ave, 'R (unitless)', 'PW_macrostate', time_min,time_max,ylim_min="None",ylim_max="None")
#
#print 'plot 2: microstate'
#print "time_hour_from_zero_WRF_ctrl.shape ", time_hour_from_zero_WRF_ctrl.shape
#print "pw_get_microstate_WRF_ctrl.shape ", pw_get_microstate_WRF_ctrl.shape 
#plot_comparison_PP_WRF_Ctrl_and_Exp(time_hour_from_zero_WRF_ctrl, time_hour_from_zero_WRF_exp, time_index*PP_time_scaling_factor, pw_get_microstate_WRF_ctrl, pw_get_microstate_WRF_exp, 'PW microstate (mm)', V_ctrl_ens_ave, V_ens_ave, 'V (unitless)', 'PW_microstate', time_min,time_max,ylim_min="None",ylim_max="None")

#print 'plot 3: precipitation'
#print "time_hour_from_zero_WRF_ctrl_adapted_for_integrated.shape ",time_hour_from_zero_WRF_ctrl_adapted_for_integrated.shape
#print "rain_rate_WRF_ctrl.shape ", rain_rate_WRF_ctrl.shape
#plot_comparison_PP_WRF_Ctrl_and_Exp(time_hour_from_zero_WRF_ctrl_adapted_for_integrated_shorter, time_hour_from_zero_WRF_exp_adapted_for_integrated_shorter, time_index*PP_time_scaling_factor, 24*rain_rate_WRF_ctrl, 24*rain_rate_WRF_exp, 'Precipitation (mm/day)', P_ctrl_ens_ave, P_ens_ave, 'P (unitless)', 'Precipitation', time_min,time_max,ylim_min="None",ylim_max="None")



## Plot the 3 variables on the same MULTI-PLOT
#time_WRF_ctrl_list = [time_hour_from_zero_WRF_ctrl, time_hour_from_zero_WRF_ctrl, time_hour_from_zero_WRF_ctrl_adapted_for_integrated_shorter]
#time_WRF_exp_list = [time_hour_from_zero_WRF_exp, time_hour_from_zero_WRF_exp, time_hour_from_zero_WRF_exp_adapted_for_integrated_shorter]
#time_PP_list = [time_index*PP_time_scaling_factor, time_index*PP_time_scaling_factor, time_index*PP_time_scaling_factor]
#var_now_WRF_ctrl_list = [pw_get_macrostate_WRF_ctrl, pw_get_microstate_WRF_ctrl, 24*rain_rate_WRF_ctrl]
#var_now_WRF_exp_list = [pw_get_macrostate_WRF_exp, pw_get_microstate_WRF_exp, 24*rain_rate_WRF_exp]
#var_now_WRF_str_list = ['PW macrostate (mm)', 'PW microstate (mm)', 'Precipitation (mm/day)']
#var_now_PP_ctrl_list = [R_ctrl_ens_ave, V_ctrl_ens_ave, P_ctrl_ens_ave]
#var_now_PP_exp_list = [R_ens_ave, V_ens_ave, P_ens_ave]
#var_now_PP_str_list = ['R (unitless)', 'V (unitless)', 'P (unitless)']
#var_now_str_for_title_list = ['PW_macrostate', 'PW_microstate', 'Precipitation']
#
#multi_plot_comparison_PP_WRF_Ctrl_and_Exp(time_WRF_ctrl_list, time_WRF_exp_list, time_PP_list, var_now_WRF_ctrl_list, var_now_WRF_exp_list, var_now_WRF_str_list, var_now_PP_ctrl_list, var_now_PP_exp_list, var_now_PP_str_list, var_now_str_for_title_list, time_min,time_max,ylim_min="None",ylim_max="None")



