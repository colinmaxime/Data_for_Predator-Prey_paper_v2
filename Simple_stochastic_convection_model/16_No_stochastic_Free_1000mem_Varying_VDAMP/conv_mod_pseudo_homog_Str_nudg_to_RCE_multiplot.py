### ---------------------------
### Stochastic convection model
### ---------------------------

import numpy as np
import os
import netCDF4 as nc4
import matplotlib
import matplotlib.pyplot as plt
import sys



def plot_time_series_simple_model(R,P,V,time_min,time_max,ylim_min,ylim_max, VDAMP, Str_nudg, V_stochastic, P_stochastic, Ctrl_run, Exp_ave, Final_plot, first_restart, nb_mem, finish_time, realisation):
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
    realisation_str = '%.1i'%realisation

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
        plt.savefig('./time_series_homog_Ctrl_' + title_part1 + '_VDAMP_' + VDAMP_str + '_realis_' + realisation_str + '_v4.eps') #bbox_inches='tight'
        plt.savefig('./time_series_homog_Ctrl_' + title_part1 + '_VDAMP_' + VDAMP_str + '_realis_' + realisation_str + '_v4.png') #bbox_inches='tight'
    if Exp_ave:
        plt.savefig('./time_series_homog_Exp_ave_' + title_part1 + '_VDAMP_' + VDAMP_str + '_first_restart_' + first_restart_str + '_nb_mem_' + nb_mem_str + '_finish_time_' + finish_time_str + '_realis_' + realisation_str + '_v4.eps') #bbox_inches='tight'
        plt.savefig('./time_series_homog_Exp_ave_' + title_part1 + '_VDAMP_' + VDAMP_str + '_first_restart_' + first_restart_str + '_nb_mem_' + nb_mem_str + '_finish_time_' + finish_time_str + '_realis_' + realisation_str + '_v4.png') #bbox_inches='tight'
    if Final_plot:
        plt.savefig('./time_series_homog_All_' + title_part1 + '_VDAMP_' + VDAMP_str + '_first_restart_' + first_restart_str + '_nb_mem_' + nb_mem_str + '_finish_time_' + finish_time_str + '_realis_' + realisation_str + '_v4.eps') #bbox_inches='tight'
        plt.savefig('./time_series_homog_All_' + title_part1 + '_VDAMP_' + VDAMP_str + '_first_restart_' + first_restart_str + '_nb_mem_' + nb_mem_str + '_finish_time_' + finish_time_str + '_realis_' + realisation_str + '_v4.png') #bbox_inches='tight'
    #plt.show()
    plt.close()




def plot_time_series_simple_model_Ctrl_and_Exp(var_now,var_now_ctrl,time_min,time_max,ylim_min,ylim_max, VDAMP, Str_nudg, V_stochastic, P_stochastic, first_restart, nb_mem, finish_time, var_now_str, Method, realisation):
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
    realisation_str = '%.1i'%realisation

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
    plt.savefig('./time_series_homog_All_' + var_now_str + '_' + title_part1 + '_VDAMP_' + VDAMP_str + '_first_restart_' + first_restart_str + '_nb_mem_' + nb_mem_str + '_finish_time_' + finish_time_str + '_time_max_' + time_max_str + '_realis_' + realisation_str + '_v4.eps') #bbox_inches='tight'
    plt.savefig('./time_series_homog_All_' + var_now_str + '_' + title_part1 + '_VDAMP_' + VDAMP_str + '_first_restart_' + first_restart_str + '_nb_mem_' + nb_mem_str + '_finish_time_' + finish_time_str + '_time_max_' + time_max_str + '_realis_' + realisation_str + '_v4.png') #bbox_inches='tight'
    #plt.show()
    plt.close()




def plot_time_series_simple_model_Ctrl_and_Exp_with_members(var_now,var_now_ctrl,time_min,time_max,ylim_min,ylim_max, VDAMP, Str_nudg, V_stochastic, P_stochastic, first_restart, nb_mem, finish_time, var_now_str, Method, var_all_resp, realisation):
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
    realisation_str = '%.1i'%realisation

    #plt.plot(time, var_to_plot_array[plot_number], color=colors[plot_number] , linewidth=2.)
    for var_indiv_resp in var_all_resp:
        plt.plot(var_indiv_resp, color='0.5' , linewidth=1.)
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
    plt.savefig('./time_series_homog_All_with_mem_' + var_now_str + '_' + title_part1 + '_VDAMP_' + VDAMP_str + '_first_restart_' + first_restart_str + '_nb_mem_' + nb_mem_str + '_finish_time_' + finish_time_str + '_time_max_' + time_max_str + '_realis_' + realisation_str + '_v4.eps') #bbox_inches='tight'
    plt.savefig('./time_series_homog_All_with_mem_' + var_now_str + '_' + title_part1 + '_VDAMP_' + VDAMP_str + '_first_restart_' + first_restart_str + '_nb_mem_' + nb_mem_str + '_finish_time_' + finish_time_str + '_time_max_' + time_max_str + '_realis_' + realisation_str + '_v4.png') #bbox_inches='tight'
    #plt.show()
    plt.close()





def make_multi_plot(array_of_var_to_plot_ens_ave,array_of_var_to_plot_ctrl_ens_ave,array_of_VDAMP,array_of_realisation,time_min,time_max, VDAMP_list, Str_nudg_f, nb_mem_f, finish_time, ii, var_now_str, nb_realisation, first_restart, Method):
    matplotlib.rc('xtick', labelsize=16)
    matplotlib.rc('ytick', labelsize=16)
    fig = plt.figure(figsize=(32,24))
    #fig = plt.figure()
    ax = plt.gca()

    Str_nudg = Str_nudg_f
    nb_mem = nb_mem_f
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

    #for VDAMP_f in VDAMP_list:
    #    for realisation in xrange(nb_realisation):

    for var_ii, var_to_plot_ens_ave in enumerate(array_of_var_to_plot_ens_ave):

        var_to_plot_ctrl_ens_ave = array_of_var_to_plot_ctrl_ens_ave[var_ii]
        var_now_ctrl = var_to_plot_ctrl_ens_ave[ii]
        var_now_ens  = var_to_plot_ens_ave[ii]        
        VDAMP        = array_of_VDAMP[var_ii]
        realisation  = array_of_realisation[var_ii]

        VDAMP_str = '%2.1f'%VDAMP

        num_plots_tot = len(array_of_var_to_plot_ens_ave)
        num_plots_vert = len(VDAMP_list)
        num_plots_hor  = nb_realisation   #1+np.amax(np.array(array_of_realisation))
        num_plot_lr = var_ii+1
        num_plot_ud = 1
        while ( num_plot_lr >  nb_realisation):
            num_plot_lr = num_plot_lr - nb_realisation
            num_plot_ud = num_plot_ud + 1
        print ""
        print "var_ii ", var_ii

        #plt.subplot(num_plot_ud, num_plot_lr, var_ii+1)
        print "subplot: num_plots_vert ", num_plots_vert
        print "subplot: num_plots_hor ", num_plots_hor
        print "subplot: var_ii+1 ", var_ii+1
        print "subplot: num_plot_ud ", num_plot_ud
        print "subplot: num_plot_lr ", num_plot_lr
        plt.subplot(num_plots_vert, num_plots_hor, var_ii+1)
        make_subplot_time_series(var_now_ens, var_now_ctrl, VDAMP, realisation, time_min, time_max, VDAMP_str, title_part1, first_restart_str, nb_mem_str, nb_mem_str_short, finish_time_str, Method_str, time_max_str, var_now_str)        

    plt.suptitle('Several realisations, several ' + r'$\alpha_{damp}$', fontsize= 16, fontweight="bold")
    fig.tight_layout()
    plt.savefig('./multiplot_All_' + var_now_str + '_' + title_part1 + '_VDAMP_' + VDAMP_str + '_first_restart_' + first_restart_str + '_nb_mem_' + nb_mem_str + '_finish_time_' + finish_time_str + '_time_max_' + time_max_str + '_v4.eps') #bbox_inches='tight'
    plt.savefig('./multiplot_All_' + var_now_str + '_' + title_part1 + '_VDAMP_' + VDAMP_str + '_first_restart_' + first_restart_str + '_nb_mem_' + nb_mem_str + '_finish_time_' + finish_time_str + '_time_max_' + time_max_str + '_v4.png') #bbox_inches='tight'
    plt.close()





def make_subplot_time_series(var_now_ens, var_now_ctrl, VDAMP, realisation, time_min, time_max, VDAMP_str, title_part1, first_restart_str, nb_mem_str, nb_mem_str_short, finish_time_str, Method_str, time_max_str, var_now_str):
    ax = plt.gca()
    plt.plot(var_now_ctrl, color='k' , linewidth=4.)
    plt.plot(var_now_ens, color='c' , linewidth=2.)
    y_formatter = matplotlib.ticker.ScalarFormatter(useOffset=False)
    ax.yaxis.set_major_formatter(y_formatter)

    plt.grid()
    plt.gcf().subplots_adjust() #bottom=0.12
    #plt.gcf().subplots_adjust(bottom=0.12)
    plt.xlim(time_min, time_max)
    ylim_min = np.minimum( 0, np.amin(np.array([var_now_ens[0:time_max], var_now_ctrl[0:time_max]])) )  #0
    ylim_max = np.amax(np.array([var_now_ens[0:time_max], var_now_ctrl[0:time_max]]))
    plt.ylim(ylim_min,1.1*ylim_max)
    plt.legend(['CTRL','V=0,Mtd=' + Method_str], fontsize=16, loc='best')

    plt.xlabel('time (no unit)', fontsize= 16, fontweight="bold")
    plt.ylabel(var_now_str + ' (no unit)' , fontsize= 16, fontweight="bold")
    plt.title(var_now_str + ', ' + title_part1 + ', '+ r'$\alpha_{damp}$' +'=' + VDAMP_str + ', ' + nb_mem_str_short + 'mem', fontsize= 16, fontweight="bold")
    ttl = ax.title
    ttl.set_position([.5,1.05])








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
    plt.savefig('./hist_' + var_to_plot + '_after_clip_CTRL_v0.png')
    plt.close()



def time_integration(R,V,P,N,Ve,Pe2,Str_nudg_h,Rforce_h,VDAMP):

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
#------------------------- MAIN FUNCTION TO DO THE JOB ---------------------------------------
#---------------------------------------------------------------------------------------------




def do_the_job(VDAMP_f, nb_mem_f, Str_nudg_f, fixed_random_seed, Stochastic_number_method_1, Stochastic_number_method_2, realisation):

    # ----------------------------------------------
    # 0. Initialising the arrays, constants and options
    # ----------------------------------------------


    qq = 500.  # dummy
    N = 2500

    #Rforce = mean(R)


    # Defining the arrays

    R = np.ones(N)   # Grid-scale tropospheric RH / CAPE, function of time i.
    P = np.ones(N)   # Grid-scale Precipitation.  P[i] falls between i and i+1.
    V = np.ones(N)   # Subgrid activity / variance, function of time i.

    if fixed_random_seed:
        np.random.seed(1)
    Pe = (1 + np.random.normal(0.0, 1.0, N))*0.5  # Multiplicative random process affecting P
    if fixed_random_seed:
        np.random.seed(1)
    Ve = (1 + np.random.normal(0.0, 1.0, N))*0.1  # Additive random process affecting V

    print 'Before clip, np.mean(Ve), np.amin(Ve) ', np.mean(Ve), np.amin(Ve)
    print 'Before clip, np.mean(Pe), np.amin(Pe) ', np.mean(Pe), np.amin(Pe)

    Ve = Ve.clip(min=0)
    Pe2 = 1+Pe
    Pe2 = Pe2.clip(min=0)

    print 'After clip, np.mean(Ve), np.amin(Ve) ', np.mean(Ve), np.amin(Ve)
    print 'After clip, np.mean(Pe2), np.amin(Pe2) ', np.mean(Pe2), np.amin(Pe2)
    print ''

    count_Ve, bins_Ve, ignored = plt.hist(Ve, 100, normed=True)
    mean_bins_Ve = 0.5* ( bins_Ve[:-1] + bins_Ve[1:] )
    plot_hist_stochastic_variables(count_Ve,mean_bins_Ve,'Ve',r'$\epsilon_{V}$')

    count_Pe2, bins_Pe2, ignored = plt.hist(Pe2, 100, normed=True)
    mean_bins_Pe2 = 0.5* ( bins_Pe2[:-1] + bins_Pe2[1:] )
    plot_hist_stochastic_variables(count_Pe2,mean_bins_Pe2,'Pe2',r'$\epsilon_{P}$')




    # Defining the constants

    #EVAP = 1.    # constant evaporation / radiative cooling rate.  
    #         # R in water units # P, EVAP in water units per time step.
    #
    ##PVSENS = 0.5
    #PSENS = 0.1
    #VPSENS = 0.5
    VDAMP = VDAMP_f   #0.3    #  0 = no damping (maximum memory), 1 = no persistence (no memory) / fully damped


    # Strong nudging: Activating or not?

    #Rforce = 3.0    # Default value. To be overwritten to the RCE value
    Str_nudg = Str_nudg_f


    # Stochastic: Activating or not?

    #V_stochastic = True
    #P_stochastic = True

    if not V_stochastic:
        Ve.fill(0.)   #Ve = 0.
    if not P_stochastic:
        Pe2.fill(1.)  #Pe2 = 1.



    # ----------------------------------------------
    # 1. Loop to iterate in time the control run
    # ----------------------------------------------

    Nudg_in_ctrl = False
    Rforce = -100        # dummy
    [R,V,P] = time_integration(R,V,P,N,Ve,Pe2,Nudg_in_ctrl,Rforce,VDAMP)

    # ---------------------------------------------
    # NOW MOVED AS A FUNCTION: def time_integration
    # ---------------------------------------------
    #for i in xrange(1,N):
    #
    #    # RH / CAPE is consumed by rain but gained by evap/radiation.
    #    R[i] = R[i-1] - P[i-1] + EVAP
    #    if Str_nudg:
    #        R[i] = Rforce*1.0
    #
    #    # Subgrid variance is enhanced by rain and has inertia and damping
    #    V[i] = V[i-1]*(1-VDAMP) + VPSENS*P[i-1] + Ve[i]
    #    #V[i] = 3.0
    #
    #
    #    # Precipitation is promoted by RH/CAPE and by subgrid, here linearised.
    #    # Also has random element.
    #    P[i] = PSENS*R[i]*V[i] * (Pe2[i])
    #    #P[i] = EVAP
    # ---------------------------------------------

    R_ctrl = R
    V_ctrl = V
    P_ctrl = P


    # Create a plot for the control run

    time_min = 0
    time_max = N

    ylim_min = np.minimum( 0, np.amin(np.array([R,P,V])) )  #0
    ylim_max = np.amax(np.array([R,P,V]))

    #output_DIR = '/home/nfs/z3339052/Documents/Raijin_seabreeze2d/Simple_stochastic_convection_model'

    Ctrl_run = True
    Exp_ave = False
    Final_plot = False

    plot_time_series_simple_model(R,P,V,time_min,time_max,ylim_min,ylim_max, VDAMP, Str_nudg, V_stochastic, P_stochastic, Ctrl_run, Exp_ave, Final_plot, 0, 0, 0, realisation)




    # -------------------------------------------------
    # 1.2 Computing the RCE state for nudging
    # -------------------------------------------------

    Rforce = compute_RCE_value_of_r(R_ctrl,time_RCE_start,time_RCE_end)


    # -------------------------------------------------
    # 2. Starting the pseudo-homogenisation experiments
    # -------------------------------------------------

    nb_mem = nb_mem_f

    V_all = []
    R_all = []
    P_all = []



    # Loop over the members (for different restarts)
    for mem in xrange(0, nb_mem):
        restart_time = first_restart + mem

        V2 = np.ones(finish_time)
        R2 = np.ones(finish_time)
        P2 = np.ones(finish_time)

        # Pseudo-Homogenisation is done here:
        V2[0] = 0.                            # Method 1 and 2
        R2[0] = R_ctrl[restart_time-1]
        if (Method == 1):
            P2[0] = 0.                        # Method 1
        elif (Method == 2):
            P2[0] = P_ctrl[restart_time-1]    # Method 2

        # Preparing the stochastic time series so that there are non-correlated for different members

        # Stochastic nb Method 1
        if Stochastic_number_method_1:
            Ve_mem = Ve[restart_time:restart_time+finish_time]
            Pe2_mem = Pe2[restart_time:restart_time+finish_time]

        # Stochastic nb Method 2
        elif Stochastic_number_method_2:
            if fixed_random_seed:
                np.random.seed(1)
            Pe_mem = (1 + np.random.normal(0.0, 1.0, finish_time))*0.5
            if fixed_random_seed:
                np.random.seed(1)
            Ve_mem = (1 + np.random.normal(0.0, 1.0, finish_time))*0.1
            Ve_mem = Ve_mem.clip(min=0)
            Pe2_mem = 1+Pe_mem
            Pe2_mem = Pe2_mem.clip(min=0)

        # Time integration of the members
        [R2,V2,P2] = time_integration(R2,V2,P2,finish_time,Ve_mem,Pe2_mem,Str_nudg,Rforce,VDAMP)

        # Build the arrays with members
        V_all.append(V2)
        R_all.append(R2)
        P_all.append(P2)
    print "V2.shape ", V2.shape
    print "np.array(V_all).shape ", np.array(V_all).shape
 
    # Compute the ensemble average
    V_ens_ave = compute_ensemble_average(V_all)
    R_ens_ave = compute_ensemble_average(R_all)
    P_ens_ave = compute_ensemble_average(P_all)
    print "V_ens_ave.shape ", V_ens_ave.shape

    # Create a plot for the pseudo-homogenisation exp 

    Ctrl_run = False
    Exp_ave = True
    Final_plot = False

    time_min = 0
    time_max = finish_time

    ylim_min = np.minimum( 0, np.amin(np.array([R_ens_ave,P_ens_ave,V_ens_ave])) )  #0
    ylim_max = np.amax(np.array([R_ens_ave,P_ens_ave,V_ens_ave]))

    plot_time_series_simple_model(R_ens_ave,P_ens_ave,V_ens_ave,time_min,time_max,ylim_min,ylim_max, VDAMP, Str_nudg, V_stochastic, P_stochastic, Ctrl_run, Exp_ave, Final_plot, first_restart, nb_mem, finish_time, realisation)




    # -------------------------------------------------
    # 3. Creating a member average for the control run
    # -------------------------------------------------

    V_ctrl_all = []
    R_ctrl_all = []
    P_ctrl_all = []

    for mem in xrange(0, nb_mem):
        member_start_time = first_restart + mem
        member_end_time = member_start_time + finish_time

        V_ctrl_all.append(V_ctrl[member_start_time:member_end_time])
        R_ctrl_all.append(R_ctrl[member_start_time:member_end_time])
        P_ctrl_all.append(P_ctrl[member_start_time:member_end_time])

    V_ctrl_ens_ave = compute_ensemble_average(V_ctrl_all)
    R_ctrl_ens_ave = compute_ensemble_average(R_ctrl_all)
    P_ctrl_ens_ave = compute_ensemble_average(P_ctrl_all)



    # -------------------------------------------------
    # 4. Creating the plot combining control and exp
    # -------------------------------------------------

    Ctrl_run = False
    Exp_ave = False
    Final_plot = True

    var_to_plot_ens_ave      = [V_ens_ave, R_ens_ave, P_ens_ave]
    var_to_plot_ctrl_ens_ave = [V_ctrl_ens_ave, R_ctrl_ens_ave, P_ctrl_ens_ave]
    #var_to_plot_str          = ["V","r","P"]
    var_to_plot_all_resp     = [V_all, R_all, P_all]

    for time_max in time_max_array:

        for ii, var_now in enumerate(var_to_plot_ens_ave):

            var_now_ctrl = var_to_plot_ctrl_ens_ave[ii]
            var_now_str = var_to_plot_str[ii]

            ylim_min = np.minimum( 0, np.amin(np.array([var_now[0:time_max], var_now_ctrl[0:time_max]])) )  #0
            ylim_max = np.amax(np.array([var_now[0:time_max], var_now_ctrl[0:time_max]]))

            plot_time_series_simple_model_Ctrl_and_Exp(var_now,var_now_ctrl,time_min,time_max,ylim_min,ylim_max, VDAMP, Str_nudg, V_stochastic, P_stochastic, first_restart, nb_mem, finish_time, var_now_str, Method, realisation)


            # Create a plot with individual members / spread of ensemble
            var_all_resp = var_to_plot_all_resp[ii]

            ylim_min = np.minimum( 0, np.amin(np.array(var_all_resp[:][0:time_max])) )  #0
            ylim_max = np.amax(np.array(var_all_resp[:][0:time_max]))

            plot_time_series_simple_model_Ctrl_and_Exp_with_members(var_now,var_now_ctrl,time_min,time_max,ylim_min,ylim_max, VDAMP, Str_nudg, V_stochastic, P_stochastic, first_restart, nb_mem, finish_time, var_now_str, Method, var_all_resp, realisation)

    # Saving the data for multiplot
    array_of_var_to_plot_ens_ave.append(var_to_plot_ens_ave)
    array_of_var_to_plot_ctrl_ens_ave.append(var_to_plot_ctrl_ens_ave)
    array_of_VDAMP.append(VDAMP_f)
    array_of_realisation.append(realisation)






#---------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------



if __name__ == '__main__':

    #do_the_job()

    VDAMP_list = [0.1, 0.3, 0.6, 0.9]
    nb_realisation = 3
    nb_mem_f = 1000
    finish_time = 800
    time_RCE_start = 300
    time_RCE_end   = 500
    first_restart = time_RCE_end  # 500

    EVAP = 1. 
    PSENS = 0.1
    VPSENS = 0.5

    time_min = 0
    time_max_array = [finish_time, 25, 400]
    var_to_plot_str = ["V","r","P"]
    Str_nudg_f = False
    fixed_random_seed =  False
    Stochastic_number_method_1 = True
    Stochastic_number_method_2 = not(Stochastic_number_method_1)
    V_stochastic = False
    P_stochastic = False
    # Method for pseudo-homogenisation
    Method = 2


    array_of_var_to_plot_ens_ave = []
    array_of_var_to_plot_ctrl_ens_ave = []
    array_of_VDAMP = []
    array_of_realisation = []

    for VDAMP_f in VDAMP_list:
        for realisation in xrange(nb_realisation):
            do_the_job(VDAMP_f, nb_mem_f, Str_nudg_f, fixed_random_seed, Stochastic_number_method_1, Stochastic_number_method_2, realisation)


    for time_max in time_max_array:

        for ii, var_now_str in enumerate(var_to_plot_str):

            make_multi_plot(array_of_var_to_plot_ens_ave,array_of_var_to_plot_ctrl_ens_ave,array_of_VDAMP,array_of_realisation,time_min,time_max, VDAMP_list, Str_nudg_f, nb_mem_f, finish_time, ii, var_now_str, nb_realisation, first_restart, Method)













