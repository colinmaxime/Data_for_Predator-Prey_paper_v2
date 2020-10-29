
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl" 
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
;load "./NCL_colormap/NCV_blu_red.rgb"

begin

  num_day_max = 1    ;100, 90
  NUMBER_PROF = 3
  output_dt = 15.
  restart_count_days = 61
  level_top_for_pbl = 9
  level_top_for_mid_tropo = 26
  month=8   ;9   ;6
  day=0

  ;/srv/ccrc/data40/z3339052/Raijin_seabreeze2d/test10_3D_With_strong_nudging/0158.6.6.8_Strong_nudging_first_tests/part1_init_v46_On_tendencies_DJK_Up_to_lev54_All_4_var_40s_From_restart_Old_modules/Analysis/organisation_cold_pool_diagnostics
  ;data_dir_for_plots = "0187_Imposed_surf_fluxes_CTRL"
  data_dir_for_plots = "part1_init_v46_On_tendencies_DJK_Up_to_lev54_All_4_var_40s_From_restart_Old_modules"
  data_dir = "/srv/ccrc/data40/z3339052/Raijin_seabreeze2d/test10_3D_With_strong_nudging/0158.6.6.8_Strong_nudging_first_tests/" + data_dir_for_plots

  output_path = data_dir + "/Analysis/Time_series_together"

  data_settings_filename = "wrfout_d01_2007-08-01_05:00:00_part1_init_v46_On_tendencies_DJK_Up_to_lev54_All_4_var_40s_From_restart_Old_modules.nc"
  ;data_settings = addfile(data_dir + "/" + data_settings_filename,"r")
  ;;data_settings = addfile(data_dir + "/wrfout_d01_2007-09-01_05:00:00.nc","r")
  data_settings_suffix = "part1_init_v46_On_tendencies_DJK_Up_to_lev54_All_4_var_40s_From_restart_Old_modules"

  processed_data = data_dir + "/Analysis/Various_movies/ncl_computed_daily/ncl_computed_output_" + data_settings_filename
  ncdf_daily = addfile(processed_data,"r")



  do num_day = 1,num_day_max

    day = day+1
    mmonth = tostring_with_format(month, "%0.2d")
    dday = tostring_with_format(day, "%0.2d")
    file_name = "wrfout_d01_2007-" + mmonth + "-" + dday + "_05:00:00_" + data_settings_suffix

    ;filename_daily = output_path + "/ncl_computed_daily" + "/ncl_computed_output_" + file_name + ".nc"
    ;ncdf_daily = addfile(filename_daily,"r")





    ;;qvapor_rough_pbl_ave       = ncdf_daily->QVAPOR_ROUGH_PBL_AVE
    ;;theta_get_rough_pbl_ave    = ncdf_daily->THETA_GET_ROUGH_PBL_AVE
    ;;qvapor_mid_tropo_vert_ave  = ncdf_daily->QVAPOR_MID_TROPO_VERT_AVE
    ;;theta_mid_tropo_vert_ave   = ncdf_daily->THETA_MID_TROPO_VERT_AVE
    ;z_get                      = ncdf_daily->Z_GET
    ;theta_get                  = ncdf_daily->THETA_GET
    ;temp                       = ncdf_daily->TEMP
    pw_get                     = ncdf_daily->PW_GET
    ;rh                         = ncdf_daily->RH
    ;;cape_2D_all                = ncdf_daily->CAPE_2D_ALL
    xtime                      = ncdf_daily->XTIME
    ;p                          = ncdf_daily->P
    ;pb                         = ncdf_daily->PB
    olr                        = ncdf_daily->OLR
    ;;delta_theta                = ncdf_daily->DELTA_THETA
    ;qvapor                     = ncdf_daily->QVAPOR
    ua                         = ncdf_daily->UA
    va                         = ncdf_daily->VA
    ;wa                         = ncdf_daily->WA
    T2                         = ncdf_daily->T2
    Q2                         = ncdf_daily->Q2
    LH                         = ncdf_daily->LH
    HFX                        = ncdf_daily->HFX
    ;rainnc                     = ncdf_daily->RAINNC
    cape_2D                    = ncdf_daily->CAPE2D
    cin_2D                     = ncdf_daily->CIN2D
    LCL                        = ncdf_daily->LCL
    LFC                        = ncdf_daily->LFC
    ;mse                        = ncdf_daily->MSE
    THF                        = ncdf_daily->THF
    ;total_p                    = ncdf_daily->TOTAL_P
    rain_rate                  = ncdf_daily->RAIN_RATE
    temp_500hPa                = ncdf_daily->TEMP_500hPa
    rh_500hPa                  = ncdf_daily->RH_500hPa
    mse_500hPa                 = ncdf_daily->MSE_500hPa
    eth_500hPa                 = ncdf_daily->ETH_500hPa
    wa_500hPa                  = ncdf_daily->W_500hPa
    qvapor_500hPa              = ncdf_daily->QVAPOR_500hPa
    temp_700hPa                = ncdf_daily->TEMP_700hPa
    rh_700hPa                  = ncdf_daily->RH_700hPa
    mse_700hPa                 = ncdf_daily->MSE_700hPa
    eth_700hPa                 = ncdf_daily->ETH_700hPa
    wa_700hPa                  = ncdf_daily->W_700hPa
    qvapor_700hPa              = ncdf_daily->QVAPOR_700hPa
    temp_subcloud_layer_ave    = ncdf_daily->TEMP_SCL_AVE
    rh_subcloud_layer_ave      = ncdf_daily->RH_SCL_AVE
    mse_subcloud_layer_ave     = ncdf_daily->MSE_SCL_AVE
    eth_subcloud_layer_ave     = ncdf_daily->ETH_SCL_AVE
    wa_subcloud_layer_ave      = ncdf_daily->WA_SCL_AVE
    qvapor_subcloud_layer_ave  = ncdf_daily->QVAPOR_SCL_AVE
    qcloud                     = ncdf_daily->QCLOUD
    qrain                      = ncdf_daily->QRAIN
    qice                       = ncdf_daily->QICE
    qsnow                      = ncdf_daily->QSNOW
    qgraup                     = ncdf_daily->QGRAUP
    qcloud_500hPa              = ncdf_daily->QCLOUD_500hPa
    qcloud_500hPa_hor_ave      = ncdf_daily->QCLOUD_500hPa_HOR_AVE
    qrain_500hPa               = ncdf_daily->QRAIN_500hPa
    qrain_500hPa_hor_ave       = ncdf_daily->QRAIN_500hPa_HOR_AVE
    qice_500hPa                = ncdf_daily->QICE_500hPa
    qice_500hPa_hor_ave        = ncdf_daily->QICE_500hPa_HOR_AVE
    qsnow_500hPa               = ncdf_daily->QSNOW_500hPa
    qsnow_500hPa_hor_ave       = ncdf_daily->QSNOW_500hPa_HOR_AVE
    qgraup_500hPa              = ncdf_daily->QGRAUP_500hPa
    qgraup_500hPa_hor_ave      = ncdf_daily->QGRAUP_500hPa_HOR_AVE
    qcond_500hPa               = ncdf_daily->QCOND_500hPa
    qcond_500hPa_hor_ave       = ncdf_daily->QCOND_500hPa_HOR_AVE
    qcond_500hPa_hor_std       = ncdf_daily->QCOND_500hPa_HOR_STD




    ; A FEW CALCULATIONS

    ua_1st_lay = ua(:,0,:,:)
    va_1st_lay = va(:,0,:,:)
    vel_1st_lay = sqrt(ua_1st_lay^2 + va_1st_lay^2)



    ; STANDARD DEVIATIONS

    pw_get_hor_std = dim_stddev_n( pw_get, (/1,2/) )
    olr_hor_std    = dim_stddev_n( olr, (/1,2/) )
    T2_hor_std     = dim_stddev_n( T2, (/1,2/) )
    Q2_hor_std     = dim_stddev_n( Q2, (/1,2/) )
    LH_hor_std     = dim_stddev_n( LH, (/1,2/) )
    HFX_hor_std    = dim_stddev_n( HFX, (/1,2/) )
    cape_2D_hor_std = dim_stddev_n( cape_2D, (/1,2/) )
    cin_2D_hor_std  = dim_stddev_n( cin_2D, (/1,2/) )
    LCL_hor_std     = dim_stddev_n( LCL, (/1,2/) )
    LFC_hor_std     = dim_stddev_n( LFC, (/1,2/) )
    THF_hor_std     = dim_stddev_n( THF, (/1,2/) )
    rain_rate_hor_std    = dim_stddev_n( rain_rate, (/1,2/) )
    temp_500hPa_hor_std  = dim_stddev_n( temp_500hPa, (/1,2/) )
    rh_500hPa_hor_std    = dim_stddev_n( rh_500hPa, (/1,2/) )
    mse_500hPa_hor_std   = dim_stddev_n( mse_500hPa, (/1,2/) )
    eth_500hPa_hor_std   = dim_stddev_n( eth_500hPa, (/1,2/) )
    wa_500hPa_hor_std    = dim_stddev_n( wa_500hPa, (/1,2/) )
    qvapor_500hPa_hor_std = dim_stddev_n( qvapor_500hPa, (/1,2/) )
    temp_700hPa_hor_std   = dim_stddev_n( temp_700hPa, (/1,2/) )
    rh_700hPa_hor_std     = dim_stddev_n( rh_700hPa, (/1,2/) )
    mse_700hPa_hor_std    = dim_stddev_n( mse_700hPa, (/1,2/) )
    eth_700hPa_hor_std    = dim_stddev_n( eth_700hPa, (/1,2/) )
    wa_700hPa_hor_std     = dim_stddev_n( wa_700hPa, (/1,2/) )
    qvapor_700hPa_hor_std = dim_stddev_n( qvapor_700hPa, (/1,2/) )
    temp_subcloud_layer_ave_hor_std   = dim_stddev_n( temp_subcloud_layer_ave, (/1,2/) )
    rh_subcloud_layer_ave_hor_std     = dim_stddev_n( rh_subcloud_layer_ave, (/1,2/) )
    mse_subcloud_layer_ave_hor_std    = dim_stddev_n( mse_subcloud_layer_ave, (/1,2/) )
    eth_subcloud_layer_ave_hor_std    = dim_stddev_n( eth_subcloud_layer_ave, (/1,2/) )
    wa_subcloud_layer_ave_hor_std     = dim_stddev_n( wa_subcloud_layer_ave, (/1,2/) )
    qvapor_subcloud_layer_ave_hor_std = dim_stddev_n( qvapor_subcloud_layer_ave, (/1,2/) )
    vel_1st_lay_hor_std               = dim_stddev_n( vel_1st_lay, (/1,2/) )



    ; AVERAGE COMPUTATIONS

    pw_get_hor_ave = dim_avg(dim_avg(pw_get))
    olr_hor_ave    = dim_avg(dim_avg(olr))
    T2_hor_ave     = dim_avg(dim_avg(T2))
    Q2_hor_ave     = dim_avg(dim_avg(Q2))
    LH_hor_ave     = dim_avg(dim_avg(LH))
    HFX_hor_ave    = dim_avg(dim_avg(HFX))
    cape_2D_hor_ave = dim_avg(dim_avg(cape_2D))
    cin_2D_hor_ave  = dim_avg(dim_avg(cin_2D))
    LCL_hor_ave     = dim_avg(dim_avg(LCL))
    LFC_hor_ave     = dim_avg(dim_avg(LFC))
    THF_hor_ave     = dim_avg(dim_avg(THF))
    rain_rate_hor_ave    = dim_avg(dim_avg(rain_rate))
    temp_500hPa_hor_ave  = dim_avg(dim_avg(temp_500hPa))
    rh_500hPa_hor_ave    = dim_avg(dim_avg(rh_500hPa))
    mse_500hPa_hor_ave   = dim_avg(dim_avg(mse_500hPa))
    eth_500hPa_hor_ave   = dim_avg(dim_avg(eth_500hPa))
    wa_500hPa_hor_ave    = dim_avg(dim_avg(wa_500hPa))
    qvapor_500hPa_hor_ave = dim_avg(dim_avg(qvapor_500hPa))
    temp_700hPa_hor_ave   = dim_avg(dim_avg(temp_700hPa))
    rh_700hPa_hor_ave     = dim_avg(dim_avg(rh_700hPa))
    mse_700hPa_hor_ave    = dim_avg(dim_avg(mse_700hPa))
    eth_700hPa_hor_ave    = dim_avg(dim_avg(eth_700hPa))
    wa_700hPa_hor_ave     = dim_avg(dim_avg(wa_700hPa))
    qvapor_700hPa_hor_ave = dim_avg(dim_avg(qvapor_700hPa))
    temp_subcloud_layer_ave_hor_ave   = dim_avg(dim_avg(temp_subcloud_layer_ave))
    rh_subcloud_layer_ave_hor_ave     = dim_avg(dim_avg(rh_subcloud_layer_ave))
    mse_subcloud_layer_ave_hor_ave    = dim_avg(dim_avg(mse_subcloud_layer_ave))
    eth_subcloud_layer_ave_hor_ave    = dim_avg(dim_avg(eth_subcloud_layer_ave))
    wa_subcloud_layer_ave_hor_ave     = dim_avg(dim_avg(wa_subcloud_layer_ave))
    qvapor_subcloud_layer_ave_hor_ave = dim_avg(dim_avg(qvapor_subcloud_layer_ave))
    vel_1st_lay_hor_ave               = dim_avg(dim_avg(vel_1st_lay))




    ; RESCALING ALL PLOTS IN ORDER TO PLOT ALL TIME SERIES TOGETHER

    ;printVarSummary(mse_subcloud_layer_ave_hor_std)
    ;mse_subcloud_layer_ave_hor_std!0 = "time"
    ;copy_VarCoords_n(xtime,mse_subcloud_layer_ave_hor_std,(/0/))
    ;printVarSummary(mse_subcloud_layer_ave_hor_std)
    mean_b = dim_avg(mse_subcloud_layer_ave_hor_std(2:24))
    mean_e = dim_avg(mse_subcloud_layer_ave_hor_std(73:95))
    ;if (mean_e .gt. mean_b) then
        mse_subcloud_layer_ave_hor_std_rescaled = (mse_subcloud_layer_ave_hor_std - min((/mean_b,mean_e/))) / (abs(mean_e-mean_b))
    ;end if

    temp_500hPa_hor_std!0 = "time"
    mean_b = dim_avg(temp_500hPa_hor_std(2:24))
    mean_e = dim_avg(temp_500hPa_hor_std(73:95))
    temp_500hPa_hor_std_rescaled = (temp_500hPa_hor_std - min((/mean_b,mean_e/))) / (abs(mean_e-mean_b))

    qvapor_500hPa_hor_std!0 = "time"
    mean_b = dim_avg(qvapor_500hPa_hor_std(2:24))
    mean_e = dim_avg(qvapor_500hPa_hor_std(73:95))
    qvapor_500hPa_hor_std_rescaled = (qvapor_500hPa_hor_std - min((/mean_b,mean_e/))) / (abs(mean_e-mean_b))

    wa_700hPa_hor_std!0 = "time"
    mean_b = dim_avg(wa_700hPa_hor_std(2:24))
    mean_e = dim_avg(wa_700hPa_hor_std(73:95))
    wa_700hPa_hor_std_rescaled = (wa_700hPa_hor_std - min((/mean_b,mean_e/))) / (abs(mean_e-mean_b))

    T2_hor_std!0 = "time"
    mean_b = dim_avg(T2_hor_std(2:24))
    mean_e = dim_avg(T2_hor_std(73:95))
    T2_hor_std_rescaled = (T2_hor_std - min((/mean_b,mean_e/))) / (abs(mean_e-mean_b))

    cape_2D_hor_std!0 = "time"
    mean_b = dim_avg(cape_2D_hor_std(2:24))
    mean_e = dim_avg(cape_2D_hor_std(73:95))
    cape_2D_hor_std_rescaled = (cape_2D_hor_std - min((/mean_b,mean_e/))) / (abs(mean_e-mean_b))

    rain_rate_hor_ave!0 = "time"
    mean_b = dim_avg(rain_rate_hor_ave(2:24))
    mean_e = dim_avg(rain_rate_hor_ave(73:94))
    rain_rate_hor_ave_rescaled = (rain_rate_hor_ave - min((/mean_b,mean_e/))) / (abs(mean_e-mean_b))

    pw_get_hor_ave!0 = "time"
    mean_b = dim_avg(pw_get_hor_ave(2:24))
    mean_e = dim_avg(pw_get_hor_ave(73:95))
    if (mean_e .gt. mean_b) then
        pw_get_hor_ave_rescaled = (pw_get_hor_ave - min((/mean_b,mean_e/))) / (abs(mean_e-mean_b))
        string_pw_get_hor_ave = " ave(PW)"
    else
        pw_get_hor_ave_rescaled = 1 - (pw_get_hor_ave - min((/mean_b,mean_e/))) / (abs(mean_e-mean_b))
        string_pw_get_hor_ave = " 1-ave(PW)"
    end if

    mse_subcloud_layer_ave_hor_ave!0 = "time"
    mean_b = dim_avg(mse_subcloud_layer_ave_hor_ave(2:24))
    mean_e = dim_avg(mse_subcloud_layer_ave_hor_ave(73:95))
    if (mean_e .gt. mean_b) then
        mse_subcloud_layer_ave_hor_ave_rescaled = (mse_subcloud_layer_ave_hor_ave - min((/mean_b,mean_e/))) / (abs(mean_e-mean_b))
        string_mse_subcloud_layer_ave_hor_ave = " ave(MSE_sub)" ;" ave(MSE_subcloud)"
    else
        mse_subcloud_layer_ave_hor_ave_rescaled = 1 - (mse_subcloud_layer_ave_hor_ave - min((/mean_b,mean_e/))) / (abs(mean_e-mean_b))
        string_mse_subcloud_layer_ave_hor_ave = " 1-ave(MSE_sub)"   ;" 1-ave(MSE_subcloud)"
    end if

    temp_500hPa_hor_ave!0 = "time"
    mean_b = dim_avg(temp_500hPa_hor_ave(2:24))
    mean_e = dim_avg(temp_500hPa_hor_ave(73:95))
    temp_500hPa_hor_ave_rescaled = (temp_500hPa_hor_ave - min((/mean_b,mean_e/))) / (abs(mean_e-mean_b))

    cape_2D_hor_ave!0 = "time"
    mean_b = dim_avg(cape_2D_hor_ave(2:24))
    mean_e = dim_avg(cape_2D_hor_ave(73:95))
    cape_2D_hor_ave_rescaled = (cape_2D_hor_ave - min((/mean_b,mean_e/))) / (abs(mean_e-mean_b))


    ; RESCALING ALL PLOTS, PART 2

    mean_b = dim_avg(THF_hor_std(2:24))
    mean_e = dim_avg(THF_hor_std(73:95))
    THF_hor_std_rescaled = (THF_hor_std - min((/mean_b,mean_e/))) / (abs(mean_e-mean_b))

    mean_b = dim_avg(THF_hor_ave(2:24))
    mean_e = dim_avg(THF_hor_ave(73:95))
    THF_hor_ave_rescaled = (THF_hor_ave - min((/mean_b,mean_e/))) / (abs(mean_e-mean_b))

    mean_b = dim_avg(Q2_hor_std(2:24))
    mean_e = dim_avg(Q2_hor_std(73:95))
    Q2_hor_std_rescaled = (Q2_hor_std - min((/mean_b,mean_e/))) / (abs(mean_e-mean_b))

    mean_b = dim_avg(Q2_hor_ave(2:24))
    mean_e = dim_avg(Q2_hor_ave(73:95))
    Q2_hor_ave_rescaled = (Q2_hor_ave - min((/mean_b,mean_e/))) / (abs(mean_e-mean_b))

    mean_b = dim_avg(vel_1st_lay_hor_std(2:24))
    mean_e = dim_avg(vel_1st_lay_hor_std(73:95))
    vel_1st_lay_hor_std_rescaled = (vel_1st_lay_hor_std - min((/mean_b,mean_e/))) / (abs(mean_e-mean_b))

    mean_b = dim_avg(vel_1st_lay_hor_ave(2:24))
    mean_e = dim_avg(vel_1st_lay_hor_ave(73:95))
    vel_1st_lay_hor_ave_rescaled = (vel_1st_lay_hor_ave - min((/mean_b,mean_e/))) / (abs(mean_e-mean_b))

    mean_b = dim_avg(olr_hor_std(2:24))
    mean_e = dim_avg(olr_hor_std(73:95))
    olr_hor_std_rescaled = (olr_hor_std - min((/mean_b,mean_e/))) / (abs(mean_e-mean_b))

    mean_b = dim_avg(olr_hor_ave(2:24))
    mean_e = dim_avg(olr_hor_ave(73:95))
    if (mean_e .gt. mean_b) then
        olr_hor_ave_rescaled = (olr_hor_ave - min((/mean_b,mean_e/))) / (abs(mean_e-mean_b))
        string_olr_hor_ave = " ave(OLR)"
    else
        olr_hor_ave_rescaled = 1 - (olr_hor_ave - min((/mean_b,mean_e/))) / (abs(mean_e-mean_b))
        string_olr_hor_ave = " 1-ave(OLR)"
    end if

    mean_b = dim_avg(cin_2D_hor_std(2:24))
    mean_e = dim_avg(cin_2D_hor_std(73:95))
    cin_2D_hor_std_rescaled = (cin_2D_hor_std - min((/mean_b,mean_e/))) / (abs(mean_e-mean_b))

    mean_b = dim_avg(cin_2D_hor_ave(2:24))
    mean_e = dim_avg(cin_2D_hor_ave(73:95))
    cin_2D_hor_ave_rescaled = (cin_2D_hor_ave - min((/mean_b,mean_e/))) / (abs(mean_e-mean_b))

    mean_b = dim_avg(T2_hor_ave(2:24))
    mean_e = dim_avg(T2_hor_ave(73:95))
    T2_hor_ave_rescaled = (T2_hor_ave - min((/mean_b,mean_e/))) / (abs(mean_e-mean_b))













  end do






  ; OTHER VARIABLES

  length_single_file = dimsizes(xtime)
  time_size = length_single_file

  ; TIME VARIABLES
  time_hour = xtime/60.
  time_day = time_hour/24.
  time_hour_from_zero = time_hour - 24*restart_count_days

  time_hour_from_zero_adapted_for_integrated_variables = time_hour_from_zero + (output_dt/2.)/60.
  time_hour_from_zero_adapted_for_integrated_variables_shorter = new((/time_size - 1/),float)
  do n=0, time_size - 2
    time_hour_from_zero_adapted_for_integrated_variables_shorter(n) = time_hour_from_zero_adapted_for_integrated_variables(n)
  end do


  ; PLOT SOME FIGURES
  num_day_s = tostring_with_format(num_day, "%0.2d")
  type = "pdf"   ;"eps"   ;"png"




/;

  ; PLOT NUMBER 1
  wks = gsn_open_wks(type,"plot_time_series_together_" + data_dir_for_plots + "_v7.4")

  res1             = True
  res2             = True
  res3             = True
  res4             = True
  res5             = True
  res6             = True
  res7             = True
  res8             = True
  res9             = True
  res10            = True
  res11            = True
  res12            = True
  res1@gsnMaximize = True

  res1@trXMinF        =  0    ;60.
  res1@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res1@trYMinF        =  -0.2    ;52.5
  res1@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res2@trXMinF        =  0    ;60.
  res2@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res2@trYMinF        =  -0.2    ;52.5
  res2@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res3@trXMinF        =  0    ;60.
  res3@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res3@trYMinF        =  -0.2    ;52.5
  res3@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res4@trXMinF        =  0    ;60.
  res4@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res4@trYMinF        =  -0.2    ;52.5
  res4@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res5@trXMinF        =  0    ;60.
  res5@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res5@trYMinF        =  -0.2    ;52.5
  res5@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res6@trXMinF        =  0    ;60.
  res6@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res6@trYMinF        =  -0.2    ;52.5
  res6@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res7@trXMinF        =  0    ;60.
  res7@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res7@trYMinF        =  -0.2    ;52.5
  res7@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res8@trXMinF        =  0    ;60.
  res8@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res8@trYMinF        =  -0.2    ;52.5
  res8@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res9@trXMinF        =  0    ;60.
  res9@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res9@trYMinF        =  -0.2    ;52.5
  res9@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000

  ;res1@lbOrientation   = "Vertical"
  ;res1@gsnMaximize = True
  ;res1@tmXTOn         = False

  colours = (/"deeppink","red","blue","darkorchid2","orange","cyan","green","deeppink","red"/)
  thicknesses = (/8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0/)
  patterns = (/0,0,0,0,0,2,2,2,2/)
  ;labels = (/" std(MSE_subcloud)"," std(T_500hPa)"," std(W_700hPa)"," std(T2)"," std(CAPE)"," ave(rain rate)"," ave(PW)"," ave(MSE_subcloud)"," ave(T_500hPa)"/)
  labels = (/" std(MSE_subcloud)"," std(T_500hPa)"," std(W_700hPa)"," std(T2)"," std(CAPE)"," ave(rain rate)",string_pw_get_hor_ave,string_mse_subcloud_layer_ave_hor_ave," ave(T_500hPa)"/)

  res1@xyLineColor = colours(0)      
  res2@xyLineColor = colours(1)      
  res3@xyLineColor = colours(2)      
  res4@xyLineColor = colours(3)      
  res5@xyLineColor = colours(4)      
  res6@xyLineColor = colours(5)      
  res7@xyLineColor = colours(6)      
  res8@xyLineColor = colours(7)      
  res9@xyLineColor = colours(8)      

  res1@xyLineThicknesses = thicknesses(0)
  res1@xyDashPattern     = patterns(0)
  res2@xyLineThicknesses = thicknesses(1)
  res2@xyDashPattern     = patterns(1)
  res3@xyLineThicknesses = thicknesses(2)
  res3@xyDashPattern     = patterns(2)
  res4@xyLineThicknesses = thicknesses(3)
  res4@xyDashPattern     = patterns(3)
  res5@xyLineThicknesses = thicknesses(4)
  res5@xyDashPattern     = patterns(4)
  res6@xyLineThicknesses = thicknesses(5)
  res6@xyDashPattern     = patterns(5)
  res7@xyLineThicknesses = thicknesses(6)
  res7@xyDashPattern     = patterns(6)
  res8@xyLineThicknesses = thicknesses(7)
  res8@xyDashPattern     = patterns(7)
  res9@xyLineThicknesses = thicknesses(8)
  res9@xyDashPattern     = patterns(8)
  res1@tiXAxisString = "Time (hours since strong nudging started)"   ;"Time (hour)"

  res1@tiYAxisString    = "Normalised quantities";labels(0)
  res2@tiYAxisString    = labels(1)
  res3@tiYAxisString    = labels(2)
  res4@tiYAxisString    = labels(3)
  res5@tiYAxisString    = labels(4)
  res6@tiYAxisString    = labels(5)
  res7@tiYAxisString    = labels(6)
  res8@tiYAxisString    = labels(7)
  res9@tiYAxisString    = labels(8)
  ;res3@amOrthogonalPosF = 0.72   ; Move "v" axis line to right a little.
  res1@tiMainString = "" ;"Time series since strong nudging start"

  ;plot = gsn_csm_xy9(wks, time_hour_from_zero, mse_subcloud_layer_ave_hor_std, temp_500hPa_hor_std, wa_700hPa_hor_std, T2_hor_std, cape_2D_hor_std, rain_rate_hor_ave, pw_get_hor_ave, mse_subcloud_layer_ave_hor_ave, temp_500hPa_hor_ave, res1,res2,res3,res4,res5,res6,res7,res8,res9)

  ;plot123 = gsn_csm_xy3(wks,time_hour_from_zero,mse_subcloud_layer_ave_hor_std,temp_500hPa_hor_std,wa_700hPa_hor_std, res1,res2,res3)
  ;plot45  = gsn_csm_xy2(wks, time_hour_from_zero, T2_hor_std, cape_2D_hor_std, res4,res5)
  ;plot6   = gsn_csm_xy( wks, time_hour_from_zero_adapted_for_integrated_variables_shorter, rain_rate_hor_ave, res6)
  ;plot789 = gsn_csm_xy3(wks, time_hour_from_zero, pw_get_hor_ave, mse_subcloud_layer_ave_hor_ave, temp_500hPa_hor_ave, res7,res8,res9)
  ;overlay(plot123, plot45)
  ;overlay(plot123, plot6)
  ;overlay(plot123, plot789)
  
  ;printVarSummary(time_hour_from_zero)
  ;printVarSummary(mse_subcloud_layer_ave_hor_std)
  plot1 = gsn_csm_xy(wks, time_hour_from_zero, mse_subcloud_layer_ave_hor_std_rescaled, res1)
  plot2 = gsn_csm_xy(wks, time_hour_from_zero, temp_500hPa_hor_std_rescaled, res2)
  plot3 = gsn_csm_xy(wks, time_hour_from_zero, wa_700hPa_hor_std_rescaled, res3)
  plot4 = gsn_csm_xy(wks, time_hour_from_zero, T2_hor_std_rescaled, res4)
  plot5 = gsn_csm_xy(wks, time_hour_from_zero, cape_2D_hor_std_rescaled, res5)
  plot6 = gsn_csm_xy(wks, time_hour_from_zero_adapted_for_integrated_variables_shorter, rain_rate_hor_ave_rescaled, res6)
  plot7 = gsn_csm_xy(wks, time_hour_from_zero, pw_get_hor_ave_rescaled, res7)
  plot8 = gsn_csm_xy(wks, time_hour_from_zero, mse_subcloud_layer_ave_hor_ave_rescaled, res8)
  plot9 = gsn_csm_xy(wks, time_hour_from_zero, temp_500hPa_hor_ave_rescaled, res9)
  overlay(plot1,plot2)
  overlay(plot1,plot3)
  overlay(plot1,plot4)
  overlay(plot1,plot5)
  overlay(plot1,plot6)
  overlay(plot1,plot7)
  overlay(plot1,plot8)
  overlay(plot1,plot9)

  lgres                     = True
  ;lgres@pmLegendDisplayMode = "Always"
  ;lgres@pmLegendSide = "Top"
  ;lgres@pmLegendOrthogonalPosF = -1.  ;-0.58  ;-0.02 (too high), 0.15 the same, -0.15 half box is too high
  ;lgres@pmLegendParallelPosF = 0.4 ;.67     ; 0.2 is very good
  ;lgres@pmLegendWidthF = 0.0425  ;0.0375
  ;lgres@pmLegendHeightF = 0.15   ;0.28
  ;lgres@lgLabelFontHeightF = 0.02
  ;lgres@xyExplicitLegendLabels = (/" Before strong nudging", " During strong nudging"/)

  lgres@lgLineColors       = colours
  lgres@lgItemType         = "Lines"        ; show lines only (default)
  lgres@lgLabelFontHeightF = 0.3  ;0.2   ;0.12           ; legend label font thickness
  lgres@vpWidthF           = 0.3  ;0.2   ;0.13           ; width of legend (NDC)
  lgres@vpHeightF          = 0.4   ;0.3   ;0.20           ; height of legend (NDC)
  lgres@lgPerimThicknessF  = 2.0            ; thicken the box perimeter
  lgres@lgLineThicknessF   = 8.0
  lgres@lgMonoDashIndex    = False   ;True
  lgres@lgDashIndexes      = patterns

  nitems = dimsizes(labels)                 ; number of legend items
  lbid = gsn_create_legend(wks,nitems,labels,lgres)

  amres                  = True
  amres@amJust           = "BottomRight"    ; Use bottom right corner of box for determining its location.
  amres@amParallelPosF   = 0.5              ; Move legend to right
  amres@amOrthogonalPosF = 0.5   ;0.3              ; Move legend down.
  ;annoid = gsn_add_annotation(plot123,lbid,amres)  ; add legend to plot
  annoid = gsn_add_annotation(plot1,lbid,amres)  ; add legend to plot

  psres = True                                                               
  maximize_output(wks,psres)  ; calls draw and frame for you 




  ; PLOT NUMBER 2
  wks = gsn_open_wks(type,"plot_time_series_together_" + data_dir_for_plots + "_x_zoom_v7.4")

  res1             = True
  res2             = True
  res3             = True
  res4             = True
  res5             = True
  res6             = True
  res7             = True
  res8             = True
  res9             = True
  res1@gsnMaximize = True

  res1@trXMinF        =  4     ;0    ;60.
  res1@trXMaxF        =  10    ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res1@trYMinF        =  -0.1  ;-0.2    ;52.5
  res1@trYMaxF        =  0.3   ;1.5  ;54.5  ; 30.   ;30000
  res2@trXMinF        =  res1@trXMinF     ;0    ;60.
  res2@trXMaxF        =  res1@trXMaxF     ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res2@trYMinF        =  res1@trYMinF     ;-0.2    ;52.5
  res2@trYMaxF        =  res1@trYMaxF     ;1.5  ;54.5  ; 30.   ;30000
  res3@trXMinF        =  res1@trXMinF     ;0    ;60.
  res3@trXMaxF        =  res1@trXMaxF     ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res3@trYMinF        =  res1@trYMinF     ;-0.2    ;52.5
  res3@trYMaxF        =  res1@trYMaxF     ;1.5  ;54.5  ; 30.   ;30000
  res4@trXMinF        =  res1@trXMinF     ;0    ;60.
  res4@trXMaxF        =  res1@trXMaxF     ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res4@trYMinF        =  res1@trYMinF     ;-0.2    ;52.5
  res4@trYMaxF        =  res1@trYMaxF     ;1.5  ;54.5  ; 30.   ;30000
  res5@trXMinF        =  res1@trXMinF     ;0    ;60.
  res5@trXMaxF        =  res1@trXMaxF     ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res5@trYMinF        =  res1@trYMinF     ;-0.2    ;52.5
  res5@trYMaxF        =  res1@trYMaxF     ;1.5  ;54.5  ; 30.   ;30000
  res6@trXMinF        =  res1@trXMinF     ;0    ;60.
  res6@trXMaxF        =  res1@trXMaxF     ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res6@trYMinF        =  res1@trYMinF     ;-0.2    ;52.5
  res6@trYMaxF        =  res1@trYMaxF     ;1.5  ;54.5  ; 30.   ;30000
  res7@trXMinF        =  res1@trXMinF     ;0    ;60.
  res7@trXMaxF        =  res1@trXMaxF     ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res7@trYMinF        =  res1@trYMinF     ;-0.2    ;52.5
  res7@trYMaxF        =  res1@trYMaxF     ;1.5  ;54.5  ; 30.   ;30000
  res8@trXMinF        =  res1@trXMinF     ;0    ;60.
  res8@trXMaxF        =  res1@trXMaxF     ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res8@trYMinF        =  res1@trYMinF     ;-0.2    ;52.5
  res8@trYMaxF        =  res1@trYMaxF     ;1.5  ;54.5  ; 30.   ;30000
  res9@trXMinF        =  res1@trXMinF     ;0    ;60.
  res9@trXMaxF        =  res1@trXMaxF     ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res9@trYMinF        =  res1@trYMinF     ;-0.2    ;52.5
  res9@trYMaxF        =  res1@trYMaxF     ;1.5  ;54.5  ; 30.   ;30000

  ;res1@lbOrientation   = "Vertical"
  ;res1@gsnMaximize = True
  ;res1@tmXTOn         = False

  colours = (/"deeppink","red","blue","darkorchid2","orange","cyan","green","deeppink","red"/)
  thicknesses = (/8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0/)
  patterns = (/0,0,0,0,0,2,2,2,2/)
  ;labels = (/" std(MSE_subcloud)"," std(T_500hPa)"," std(W_700hPa)"," std(T2)"," std(CAPE)"," ave(rain rate)"," ave(PW)"," ave(MSE_subcloud)"," ave(T_500hPa)"/)
  labels = (/" std(MSE_subcloud)"," std(T_500hPa)"," std(W_700hPa)"," std(T2)"," std(CAPE)"," ave(rain rate)",string_pw_get_hor_ave,string_mse_subcloud_layer_ave_hor_ave," ave(T_500hPa)"/)

  res1@xyLineColor = colours(0)      
  res2@xyLineColor = colours(1)      
  res3@xyLineColor = colours(2)      
  res4@xyLineColor = colours(3)      
  res5@xyLineColor = colours(4)      
  res6@xyLineColor = colours(5)      
  res7@xyLineColor = colours(6)      
  res8@xyLineColor = colours(7)      
  res9@xyLineColor = colours(8)      

  res1@xyLineThicknesses = thicknesses(0)
  res1@xyDashPattern     = patterns(0)
  res2@xyLineThicknesses = thicknesses(1)
  res2@xyDashPattern     = patterns(1)
  res3@xyLineThicknesses = thicknesses(2)
  res3@xyDashPattern     = patterns(2)
  res4@xyLineThicknesses = thicknesses(3)
  res4@xyDashPattern     = patterns(3)
  res5@xyLineThicknesses = thicknesses(4)
  res5@xyDashPattern     = patterns(4)
  res6@xyLineThicknesses = thicknesses(5)
  res6@xyDashPattern     = patterns(5)
  res7@xyLineThicknesses = thicknesses(6)
  res7@xyDashPattern     = patterns(6)
  res8@xyLineThicknesses = thicknesses(7)
  res8@xyDashPattern     = patterns(7)
  res9@xyLineThicknesses = thicknesses(8)
  res9@xyDashPattern     = patterns(8)
  res1@tiXAxisString = "Time (hours since strong nudging started)"   ;"Time (hour)"

  res1@tiYAxisString    = "Normalised quantities";labels(0)
  res2@tiYAxisString    = labels(1)
  res3@tiYAxisString    = labels(2)
  res4@tiYAxisString    = labels(3)
  res5@tiYAxisString    = labels(4)
  res6@tiYAxisString    = labels(5)
  res7@tiYAxisString    = labels(6)
  res8@tiYAxisString    = labels(7)
  res9@tiYAxisString    = labels(8)
  ;res3@amOrthogonalPosF = 0.72   ; Move "v" axis line to right a little.
  res1@tiMainString = "" ;"Time series since strong nudging start"

  ;plot = gsn_csm_xy9(wks, time_hour_from_zero, mse_subcloud_layer_ave_hor_std, temp_500hPa_hor_std, wa_700hPa_hor_std, T2_hor_std, cape_2D_hor_std, rain_rate_hor_ave, pw_get_hor_ave, mse_subcloud_layer_ave_hor_ave, temp_500hPa_hor_ave, res1,res2,res3,res4,res5,res6,res7,res8,res9)

  ;plot123 = gsn_csm_xy3(wks,time_hour_from_zero,mse_subcloud_layer_ave_hor_std,temp_500hPa_hor_std,wa_700hPa_hor_std, res1,res2,res3)
  ;plot45  = gsn_csm_xy2(wks, time_hour_from_zero, T2_hor_std, cape_2D_hor_std, res4,res5)
  ;plot6   = gsn_csm_xy( wks, time_hour_from_zero_adapted_for_integrated_variables_shorter, rain_rate_hor_ave, res6)
  ;plot789 = gsn_csm_xy3(wks, time_hour_from_zero, pw_get_hor_ave, mse_subcloud_layer_ave_hor_ave, temp_500hPa_hor_ave, res7,res8,res9)
  ;overlay(plot123, plot45)
  ;overlay(plot123, plot6)
  ;overlay(plot123, plot789)
  
  ;printVarSummary(time_hour_from_zero)
  ;printVarSummary(mse_subcloud_layer_ave_hor_std)
  plot1 = gsn_csm_xy(wks, time_hour_from_zero, mse_subcloud_layer_ave_hor_std_rescaled, res1)
  plot2 = gsn_csm_xy(wks, time_hour_from_zero, temp_500hPa_hor_std_rescaled, res2)
  plot3 = gsn_csm_xy(wks, time_hour_from_zero, wa_700hPa_hor_std_rescaled, res3)
  plot4 = gsn_csm_xy(wks, time_hour_from_zero, T2_hor_std_rescaled, res4)
  plot5 = gsn_csm_xy(wks, time_hour_from_zero, cape_2D_hor_std_rescaled, res5)
  plot6 = gsn_csm_xy(wks, time_hour_from_zero_adapted_for_integrated_variables_shorter, rain_rate_hor_ave_rescaled, res6)
  plot7 = gsn_csm_xy(wks, time_hour_from_zero, pw_get_hor_ave_rescaled, res7)
  plot8 = gsn_csm_xy(wks, time_hour_from_zero, mse_subcloud_layer_ave_hor_ave_rescaled, res8)
  plot9 = gsn_csm_xy(wks, time_hour_from_zero, temp_500hPa_hor_ave_rescaled, res9)
  overlay(plot1,plot2)
  overlay(plot1,plot3)
  overlay(plot1,plot4)
  overlay(plot1,plot5)
  overlay(plot1,plot6)
  overlay(plot1,plot7)
  overlay(plot1,plot8)
  overlay(plot1,plot9)

  lgres                     = True
  ;lgres@pmLegendDisplayMode = "Always"
  ;lgres@pmLegendSide = "Top"
  ;lgres@pmLegendOrthogonalPosF = -1.  ;-0.58  ;-0.02 (too high), 0.15 the same, -0.15 half box is too high
  ;lgres@pmLegendParallelPosF = 0.4 ;.67     ; 0.2 is very good
  ;lgres@pmLegendWidthF = 0.0425  ;0.0375
  ;lgres@pmLegendHeightF = 0.15   ;0.28
  ;lgres@lgLabelFontHeightF = 0.02
  ;lgres@xyExplicitLegendLabels = (/" Before strong nudging", " During strong nudging"/)

  lgres@lgLineColors       = colours
  lgres@lgItemType         = "Lines"        ; show lines only (default)
  lgres@lgLabelFontHeightF = 0.3  ;0.2   ;0.12           ; legend label font thickness
  lgres@vpWidthF           = 0.3  ;0.2   ;0.13           ; width of legend (NDC)
  lgres@vpHeightF          = 0.4  ;0.3   ;0.20           ; height of legend (NDC)
  lgres@lgPerimThicknessF  = 2.0            ; thicken the box perimeter
  lgres@lgLineThicknessF   = 8.0
  lgres@lgMonoDashIndex    = False   ;True
  lgres@lgDashIndexes      = patterns

  nitems = dimsizes(labels)                 ; number of legend items
  lbid = gsn_create_legend(wks,nitems,labels,lgres)

  amres                  = True
  amres@amJust           = "TopLeft"   ;"BottomRight"    ; Use bottom right corner of box for determining its location.
  amres@amParallelPosF   = -0.5    ;0.5              ; Move legend to right
  amres@amOrthogonalPosF = -0.5    ;0.3              ; Move legend down.
  ;annoid = gsn_add_annotation(plot123,lbid,amres)  ; add legend to plot
  annoid = gsn_add_annotation(plot1,lbid,amres)  ; add legend to plot

  psres = True                                                               
  maximize_output(wks,psres)  ; calls draw and frame for you 




  ; PLOT NUMBER 2.2
  wks = gsn_open_wks(type,"plot_time_series_together_" + data_dir_for_plots + "_x_more_zoom_v7.4")

  res1             = True
  res2             = True
  res3             = True
  res4             = True
  res5             = True
  res6             = True
  res7             = True
  res8             = True
  res9             = True
  res1@gsnMaximize = True

  res1@trXMinF        =  4    ;3     ;0    ;60.
  res1@trXMaxF        =  8    ;7    ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res1@trYMinF        =  -0.01  ;-0.1  ;-0.2    ;52.5
  res1@trYMaxF        =  0.12   ;0.08   ;1.5  ;54.5  ; 30.   ;30000
  res2@trXMinF        =  res1@trXMinF     ;0    ;60.
  res2@trXMaxF        =  res1@trXMaxF     ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res2@trYMinF        =  res1@trYMinF     ;-0.2    ;52.5
  res2@trYMaxF        =  res1@trYMaxF     ;1.5  ;54.5  ; 30.   ;30000
  res3@trXMinF        =  res1@trXMinF     ;0    ;60.
  res3@trXMaxF        =  res1@trXMaxF     ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res3@trYMinF        =  res1@trYMinF     ;-0.2    ;52.5
  res3@trYMaxF        =  res1@trYMaxF     ;1.5  ;54.5  ; 30.   ;30000
  res4@trXMinF        =  res1@trXMinF     ;0    ;60.
  res4@trXMaxF        =  res1@trXMaxF     ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res4@trYMinF        =  res1@trYMinF     ;-0.2    ;52.5
  res4@trYMaxF        =  res1@trYMaxF     ;1.5  ;54.5  ; 30.   ;30000
  res5@trXMinF        =  res1@trXMinF     ;0    ;60.
  res5@trXMaxF        =  res1@trXMaxF     ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res5@trYMinF        =  res1@trYMinF     ;-0.2    ;52.5
  res5@trYMaxF        =  res1@trYMaxF     ;1.5  ;54.5  ; 30.   ;30000
  res6@trXMinF        =  res1@trXMinF     ;0    ;60.
  res6@trXMaxF        =  res1@trXMaxF     ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res6@trYMinF        =  res1@trYMinF     ;-0.2    ;52.5
  res6@trYMaxF        =  res1@trYMaxF     ;1.5  ;54.5  ; 30.   ;30000
  res7@trXMinF        =  res1@trXMinF     ;0    ;60.
  res7@trXMaxF        =  res1@trXMaxF     ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res7@trYMinF        =  res1@trYMinF     ;-0.2    ;52.5
  res7@trYMaxF        =  res1@trYMaxF     ;1.5  ;54.5  ; 30.   ;30000
  res8@trXMinF        =  res1@trXMinF     ;0    ;60.
  res8@trXMaxF        =  res1@trXMaxF     ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res8@trYMinF        =  res1@trYMinF     ;-0.2    ;52.5
  res8@trYMaxF        =  res1@trYMaxF     ;1.5  ;54.5  ; 30.   ;30000
  res9@trXMinF        =  res1@trXMinF     ;0    ;60.
  res9@trXMaxF        =  res1@trXMaxF     ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res9@trYMinF        =  res1@trYMinF     ;-0.2    ;52.5
  res9@trYMaxF        =  res1@trYMaxF     ;1.5  ;54.5  ; 30.   ;30000

  ;res1@lbOrientation   = "Vertical"
  ;res1@gsnMaximize = True
  ;res1@tmXTOn         = False

  colours = (/"deeppink","red","blue","darkorchid2","orange","cyan","green","deeppink","red"/)
  thicknesses = (/8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0/)
  patterns = (/0,0,0,0,0,2,2,2,2/)
  ;labels = (/" std(MSE_subcloud)"," std(T_500hPa)"," std(W_700hPa)"," std(T2)"," std(CAPE)"," ave(rain rate)"," ave(PW)"," ave(MSE_subcloud)"," ave(T_500hPa)"/)
  labels = (/" std(MSE_subcloud)"," std(T_500hPa)"," std(W_700hPa)"," std(T2)"," std(CAPE)"," ave(rain rate)",string_pw_get_hor_ave,string_mse_subcloud_layer_ave_hor_ave," ave(T_500hPa)"/)

  res1@xyLineColor = colours(0)      
  res2@xyLineColor = colours(1)      
  res3@xyLineColor = colours(2)      
  res4@xyLineColor = colours(3)      
  res5@xyLineColor = colours(4)      
  res6@xyLineColor = colours(5)      
  res7@xyLineColor = colours(6)      
  res8@xyLineColor = colours(7)      
  res9@xyLineColor = colours(8)      

  res1@xyLineThicknesses = thicknesses(0)
  res1@xyDashPattern     = patterns(0)
  res2@xyLineThicknesses = thicknesses(1)
  res2@xyDashPattern     = patterns(1)
  res3@xyLineThicknesses = thicknesses(2)
  res3@xyDashPattern     = patterns(2)
  res4@xyLineThicknesses = thicknesses(3)
  res4@xyDashPattern     = patterns(3)
  res5@xyLineThicknesses = thicknesses(4)
  res5@xyDashPattern     = patterns(4)
  res6@xyLineThicknesses = thicknesses(5)
  res6@xyDashPattern     = patterns(5)
  res7@xyLineThicknesses = thicknesses(6)
  res7@xyDashPattern     = patterns(6)
  res8@xyLineThicknesses = thicknesses(7)
  res8@xyDashPattern     = patterns(7)
  res9@xyLineThicknesses = thicknesses(8)
  res9@xyDashPattern     = patterns(8)
  res1@tiXAxisString = "Time (hours since strong nudging started)"   ;"Time (hour)"

  res1@tiYAxisString    = "Normalised quantities";labels(0)
  res2@tiYAxisString    = labels(1)
  res3@tiYAxisString    = labels(2)
  res4@tiYAxisString    = labels(3)
  res5@tiYAxisString    = labels(4)
  res6@tiYAxisString    = labels(5)
  res7@tiYAxisString    = labels(6)
  res8@tiYAxisString    = labels(7)
  res9@tiYAxisString    = labels(8)
  ;res3@amOrthogonalPosF = 0.72   ; Move "v" axis line to right a little.
  res1@tiMainString = "" ;"Time series since strong nudging start"

  ;plot = gsn_csm_xy9(wks, time_hour_from_zero, mse_subcloud_layer_ave_hor_std, temp_500hPa_hor_std, wa_700hPa_hor_std, T2_hor_std, cape_2D_hor_std, rain_rate_hor_ave, pw_get_hor_ave, mse_subcloud_layer_ave_hor_ave, temp_500hPa_hor_ave, res1,res2,res3,res4,res5,res6,res7,res8,res9)

  ;plot123 = gsn_csm_xy3(wks,time_hour_from_zero,mse_subcloud_layer_ave_hor_std,temp_500hPa_hor_std,wa_700hPa_hor_std, res1,res2,res3)
  ;plot45  = gsn_csm_xy2(wks, time_hour_from_zero, T2_hor_std, cape_2D_hor_std, res4,res5)
  ;plot6   = gsn_csm_xy( wks, time_hour_from_zero_adapted_for_integrated_variables_shorter, rain_rate_hor_ave, res6)
  ;plot789 = gsn_csm_xy3(wks, time_hour_from_zero, pw_get_hor_ave, mse_subcloud_layer_ave_hor_ave, temp_500hPa_hor_ave, res7,res8,res9)
  ;overlay(plot123, plot45)
  ;overlay(plot123, plot6)
  ;overlay(plot123, plot789)
  
  ;printVarSummary(time_hour_from_zero)
  ;printVarSummary(mse_subcloud_layer_ave_hor_std)
  plot1 = gsn_csm_xy(wks, time_hour_from_zero, mse_subcloud_layer_ave_hor_std_rescaled, res1)
  plot2 = gsn_csm_xy(wks, time_hour_from_zero, temp_500hPa_hor_std_rescaled, res2)
  plot3 = gsn_csm_xy(wks, time_hour_from_zero, wa_700hPa_hor_std_rescaled, res3)
  plot4 = gsn_csm_xy(wks, time_hour_from_zero, T2_hor_std_rescaled, res4)
  plot5 = gsn_csm_xy(wks, time_hour_from_zero, cape_2D_hor_std_rescaled, res5)
  plot6 = gsn_csm_xy(wks, time_hour_from_zero_adapted_for_integrated_variables_shorter, rain_rate_hor_ave_rescaled, res6)
  plot7 = gsn_csm_xy(wks, time_hour_from_zero, pw_get_hor_ave_rescaled, res7)
  plot8 = gsn_csm_xy(wks, time_hour_from_zero, mse_subcloud_layer_ave_hor_ave_rescaled, res8)
  plot9 = gsn_csm_xy(wks, time_hour_from_zero, temp_500hPa_hor_ave_rescaled, res9)
  overlay(plot1,plot2)
  overlay(plot1,plot3)
  overlay(plot1,plot4)
  overlay(plot1,plot5)
  overlay(plot1,plot6)
  overlay(plot1,plot7)
  overlay(plot1,plot8)
  overlay(plot1,plot9)

  lgres                     = True
  ;lgres@pmLegendDisplayMode = "Always"
  ;lgres@pmLegendSide = "Top"
  ;lgres@pmLegendOrthogonalPosF = -1.  ;-0.58  ;-0.02 (too high), 0.15 the same, -0.15 half box is too high
  ;lgres@pmLegendParallelPosF = 0.4 ;.67     ; 0.2 is very good
  ;lgres@pmLegendWidthF = 0.0425  ;0.0375
  ;lgres@pmLegendHeightF = 0.15   ;0.28
  ;lgres@lgLabelFontHeightF = 0.02
  ;lgres@xyExplicitLegendLabels = (/" Before strong nudging", " During strong nudging"/)

  lgres@lgLineColors       = colours
  lgres@lgItemType         = "Lines"        ; show lines only (default)
  lgres@lgLabelFontHeightF = 0.3  ;0.2   ;0.12           ; legend label font thickness
  lgres@vpWidthF           = 0.3  ;0.2   ;0.13           ; width of legend (NDC)
  lgres@vpHeightF          = 0.4  ;0.3   ;0.20           ; height of legend (NDC)
  lgres@lgPerimThicknessF  = 2.0            ; thicken the box perimeter
  lgres@lgLineThicknessF   = 8.0
  lgres@lgMonoDashIndex    = False   ;True
  lgres@lgDashIndexes      = patterns

  nitems = dimsizes(labels)                 ; number of legend items
  lbid = gsn_create_legend(wks,nitems,labels,lgres)

  amres                  = True
  amres@amJust           = "TopLeft"   ;"BottomRight"    ; Use bottom right corner of box for determining its location.
  amres@amParallelPosF   = -0.5    ;0.5              ; Move legend to right
  amres@amOrthogonalPosF = -0.5    ;0.3              ; Move legend down.
  ;annoid = gsn_add_annotation(plot123,lbid,amres)  ; add legend to plot
  annoid = gsn_add_annotation(plot1,lbid,amres)  ; add legend to plot

  psres = True                                                               
  maximize_output(wks,psres)  ; calls draw and frame for you 






  delete(colours)
  delete(thicknesses)
  delete(patterns)
  delete(labels)
  delete(wks)
  delete(lgres)
  delete(amres)
  delete(res1)





  ; PLOT NUMBER 3
  wks = gsn_open_wks(type,"plot_time_series_together_2nd_variable_set_" + data_dir_for_plots + "_v7.2")

  res1             = True
  res2             = True
  res3             = True
  res4             = True
  res5             = True
  res6             = True
  res7             = True
  res8             = True
  res9             = True
  res10            = True
  res1@gsnMaximize = True

  res1@trXMinF        =  0    ;60.
  res1@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res1@trYMinF        =  -0.2    ;52.5
  res1@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res2@trXMinF        =  0    ;60.
  res2@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res2@trYMinF        =  -0.2    ;52.5
  res2@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res3@trXMinF        =  0    ;60.
  res3@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res3@trYMinF        =  -0.2    ;52.5
  res3@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res4@trXMinF        =  0    ;60.
  res4@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res4@trYMinF        =  -0.2    ;52.5
  res4@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res5@trXMinF        =  0    ;60.
  res5@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res5@trYMinF        =  -0.2    ;52.5
  res5@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res6@trXMinF        =  0    ;60.
  res6@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res6@trYMinF        =  -0.2    ;52.5
  res6@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res7@trXMinF        =  0    ;60.
  res7@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res7@trYMinF        =  -0.2    ;52.5
  res7@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res8@trXMinF        =  0    ;60.
  res8@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res8@trYMinF        =  -0.2    ;52.5
  res8@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res9@trXMinF        =  0    ;60.
  res9@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res9@trYMinF        =  -0.2    ;52.5
  res9@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res10@trXMinF       =  res1@trXMinF   ;0    ;60.
  res10@trXMaxF       =  res1@trXMaxF   ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res10@trYMinF       =  res1@trYMinF   ;-0.2    ;52.5
  res10@trYMaxF       =  res1@trYMaxF   ;1.5  ;54.5  ; 30.   ;30000
  res11@trXMinF       =  res1@trXMinF   ;0    ;60.
  res11@trXMaxF       =  res1@trXMaxF   ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res11@trYMinF       =  res1@trYMinF   ;-0.2    ;52.5
  res11@trYMaxF       =  res1@trYMaxF   ;1.5  ;54.5  ; 30.   ;30000
  res12@trXMinF       =  res1@trXMinF   ;0    ;60.
  res12@trXMaxF       =  res1@trXMaxF   ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res12@trYMinF       =  res1@trYMinF   ;-0.2    ;52.5
  res12@trYMaxF       =  res1@trYMaxF   ;1.5  ;54.5  ; 30.   ;30000

  ;res1@lbOrientation   = "Vertical"
  ;res1@gsnMaximize = True
  ;res1@tmXTOn         = False

  colours = (/"darkorchid2","darkorchid2","springgreen4","springgreen4","peachpuff","peachpuff","deepskyblue","deepskyblue","magenta","magenta","gray40","gray40"/)   ;"deeppink","red","blue","darkorchid2","orange","cyan","green","deeppink","red"/)
  thicknesses = (/8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0/)
  patterns = (/2,0,2,0,2,0,2,0,2,0,2,0/)
  ;labels = (/" std(MSE_subcloud)"," std(T_500hPa)"," std(W_700hPa)"," std(T2)"," std(CAPE)"," ave(rain rate)"," ave(PW)"," ave(MSE_subcloud)"," ave(T_500hPa)"/)
  labels = (/" ave(T2)", " std(T2)", " ave(Q2)", " std(Q2)", " ave(THF)", " std(THF)", " ave(vel_1st_lay)", " std(vel_1st_lay)", string_olr_hor_ave, " std(OLR)", " ave(CIN)", " std(CIN)"/)    ;" std(MSE_subcloud)"," std(T_500hPa)"," std(W_700hPa)"," std(T2)"," std(CAPE)"," ave(rain rate)",string_pw_get_hor_ave,string_mse_subcloud_layer_ave_hor_ave," ave(T_500hPa)"/)

  res1@xyLineColor = colours(0)      
  res2@xyLineColor = colours(1)      
  res3@xyLineColor = colours(2)      
  res4@xyLineColor = colours(3)      
  res5@xyLineColor = colours(4)      
  res6@xyLineColor = colours(5)      
  res7@xyLineColor = colours(6)      
  res8@xyLineColor = colours(7)      
  res9@xyLineColor = colours(8)      
  res10@xyLineColor = colours(9)      
  res11@xyLineColor = colours(10)      
  res12@xyLineColor = colours(11)      

  res1@xyLineThicknesses = thicknesses(0)
  res1@xyDashPattern     = patterns(0)
  res2@xyLineThicknesses = thicknesses(1)
  res2@xyDashPattern     = patterns(1)
  res3@xyLineThicknesses = thicknesses(2)
  res3@xyDashPattern     = patterns(2)
  res4@xyLineThicknesses = thicknesses(3)
  res4@xyDashPattern     = patterns(3)
  res5@xyLineThicknesses = thicknesses(4)
  res5@xyDashPattern     = patterns(4)
  res6@xyLineThicknesses = thicknesses(5)
  res6@xyDashPattern     = patterns(5)
  res7@xyLineThicknesses = thicknesses(6)
  res7@xyDashPattern     = patterns(6)
  res8@xyLineThicknesses = thicknesses(7)
  res8@xyDashPattern     = patterns(7)
  res9@xyLineThicknesses = thicknesses(8)
  res9@xyDashPattern     = patterns(8)
  res10@xyLineThicknesses = thicknesses(9)
  res10@xyDashPattern     = patterns(9)
  res11@xyLineThicknesses = thicknesses(10)
  res11@xyDashPattern     = patterns(10)
  res12@xyLineThicknesses = thicknesses(11)
  res12@xyDashPattern     = patterns(11)
  res1@tiXAxisString = "Time (hour)"

  res1@tiYAxisString    = labels(0)
  res2@tiYAxisString    = labels(1)
  res3@tiYAxisString    = labels(2)
  res4@tiYAxisString    = labels(3)
  res5@tiYAxisString    = labels(4)
  res6@tiYAxisString    = labels(5)
  res7@tiYAxisString    = labels(6)
  res8@tiYAxisString    = labels(7)
  res9@tiYAxisString    = labels(8)
  res10@tiYAxisString   = labels(9)
  res11@tiYAxisString   = labels(10)
  res12@tiYAxisString   = labels(11)
  ;res3@amOrthogonalPosF = 0.72   ; Move "v" axis line to right a little.
  res1@tiMainString = "Time series since strong nudging start, p2"

  ;plot = gsn_csm_xy9(wks, time_hour_from_zero, mse_subcloud_layer_ave_hor_std, temp_500hPa_hor_std, wa_700hPa_hor_std, T2_hor_std, cape_2D_hor_std, rain_rate_hor_ave, pw_get_hor_ave, mse_subcloud_layer_ave_hor_ave, temp_500hPa_hor_ave, res1,res2,res3,res4,res5,res6,res7,res8,res9)

  ;plot123 = gsn_csm_xy3(wks,time_hour_from_zero,mse_subcloud_layer_ave_hor_std,temp_500hPa_hor_std,wa_700hPa_hor_std, res1,res2,res3)
  ;plot45  = gsn_csm_xy2(wks, time_hour_from_zero, T2_hor_std, cape_2D_hor_std, res4,res5)
  ;plot6   = gsn_csm_xy( wks, time_hour_from_zero_adapted_for_integrated_variables_shorter, rain_rate_hor_ave, res6)
  ;plot789 = gsn_csm_xy3(wks, time_hour_from_zero, pw_get_hor_ave, mse_subcloud_layer_ave_hor_ave, temp_500hPa_hor_ave, res7,res8,res9)
  ;overlay(plot123, plot45)
  ;overlay(plot123, plot6)
  ;overlay(plot123, plot789)
  
  ;printVarSummary(time_hour_from_zero)
  ;printVarSummary(mse_subcloud_layer_ave_hor_std)
  plot1 = gsn_csm_xy(wks, time_hour_from_zero, T2_hor_ave_rescaled, res1)
  plot2 = gsn_csm_xy(wks, time_hour_from_zero, T2_hor_std_rescaled, res2)
  plot3 = gsn_csm_xy(wks, time_hour_from_zero, Q2_hor_ave_rescaled, res3)
  plot4 = gsn_csm_xy(wks, time_hour_from_zero, Q2_hor_std_rescaled, res4)
  plot5 = gsn_csm_xy(wks, time_hour_from_zero, THF_hor_ave_rescaled, res5)
  plot6 = gsn_csm_xy(wks, time_hour_from_zero, THF_hor_std_rescaled, res6)
  plot7 = gsn_csm_xy(wks, time_hour_from_zero, vel_1st_lay_hor_ave_rescaled, res7)
  plot8 = gsn_csm_xy(wks, time_hour_from_zero, vel_1st_lay_hor_std_rescaled, res8)
  plot9  = gsn_csm_xy(wks, time_hour_from_zero, olr_hor_ave_rescaled, res9)
  plot10 = gsn_csm_xy(wks, time_hour_from_zero, olr_hor_std_rescaled, res10)
  plot11 = gsn_csm_xy(wks, time_hour_from_zero, cin_2D_hor_ave_rescaled, res11)
  plot12 = gsn_csm_xy(wks, time_hour_from_zero, cin_2D_hor_std_rescaled, res12)

  overlay(plot1,plot2)
  overlay(plot1,plot3)
  overlay(plot1,plot4)
  overlay(plot1,plot5)
  overlay(plot1,plot6)
  overlay(plot1,plot7)
  overlay(plot1,plot8)
  overlay(plot1,plot9)
  overlay(plot1,plot10)
  overlay(plot1,plot11)
  overlay(plot1,plot12)

  lgres                     = True
  ;lgres@pmLegendDisplayMode = "Always"
  ;lgres@pmLegendSide = "Top"
  ;lgres@pmLegendOrthogonalPosF = -1.  ;-0.58  ;-0.02 (too high), 0.15 the same, -0.15 half box is too high
  ;lgres@pmLegendParallelPosF = 0.4 ;.67     ; 0.2 is very good
  ;lgres@pmLegendWidthF = 0.0425  ;0.0375
  ;lgres@pmLegendHeightF = 0.15   ;0.28
  ;lgres@lgLabelFontHeightF = 0.02
  ;lgres@xyExplicitLegendLabels = (/" Before strong nudging", " During strong nudging"/)

  lgres@lgLineColors       = colours
  lgres@lgItemType         = "Lines"        ; show lines only (default)
  lgres@lgLabelFontHeightF = 0.2   ;0.12           ; legend label font thickness
  lgres@vpWidthF           = 0.2   ;0.13           ; width of legend (NDC)
  lgres@vpHeightF          = 0.3   ;0.20           ; height of legend (NDC)
  lgres@lgPerimThicknessF  = 2.0            ; thicken the box perimeter
  lgres@lgLineThicknessF   = 8.0
  lgres@lgMonoDashIndex    = False   ;True
  lgres@lgDashIndexes      = patterns

  nitems = dimsizes(labels)                 ; number of legend items
  lbid = gsn_create_legend(wks,nitems,labels,lgres)

  amres                  = True
  amres@amJust           = "BottomRight"    ; Use bottom right corner of box for determining its location.
  amres@amParallelPosF   = 0.5              ; Move legend to right
  amres@amOrthogonalPosF = 0.5              ; Move legend down.
  ;annoid = gsn_add_annotation(plot123,lbid,amres)  ; add legend to plot
  annoid = gsn_add_annotation(plot1,lbid,amres)  ; add legend to plot

  psres = True                                                               
  maximize_output(wks,psres)  ; calls draw and frame for you 





  delete(colours)
  delete(thicknesses)
  delete(patterns)
  delete(labels)
  delete(wks)
  delete(lgres)
  delete(amres)
  delete(res1)


 







  ; PLOT NUMBER 4 (FOR STEVE'S PAPER ON PREDATOR-PREY MODEL)
  wks = gsn_open_wks(type,"plot_time_series_together_3rd_variable_set_" + data_dir_for_plots + "_v8.3")

  res1             = True
  res2             = True
  res3             = True
  res4             = True
  res5             = True
  res6             = True
  res7             = True
  res8             = True
  res9             = True
  res10            = True
  res11            = True
  res12            = True
  res1@gsnMaximize = True
  ;res1@xyLineThicknessF       = 3.     ; Thicken the lines
  res1@xyMarkLineMode         = "MarkLines"

  res1@trXMinF        =  0    ;60.
  res1@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res1@trYMinF        =  -0.2 ;-1 ;-0.2 ;-0.04    ;52.5
  res1@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res2@trXMinF        =  0    ;60.
  res2@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res2@trYMinF        =  -0.2 ;-1 ;-0.2 ;-0.04    ;52.5
  res2@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res3@trXMinF        =  0    ;60.
  res3@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res3@trYMinF        =  -0.2 ;-1 ;-0.2 ;-0.04    ;52.5
  res3@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res4@trXMinF        =  0    ;60.
  res4@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res4@trYMinF        =  -0.2 ;-1 ;-0.2 ;-0.04    ;52.5
  res4@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res5@trXMinF        =  0    ;60.
  res5@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res5@trYMinF        =  -0.2 ;-1 ;-0.2 ;-0.04    ;52.5
  res5@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res6@trXMinF        =  0    ;60.
  res6@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res6@trYMinF        =  -0.2 ;-1 ;-0.2 ;-0.04    ;52.5
  res6@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res7@trXMinF        =  0    ;60.
  res7@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res7@trYMinF        =  -0.2 ;-1 ;-0.2 ;-0.04    ;52.5
  res7@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res8@trXMinF        =  0    ;60.
  res8@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res8@trYMinF        =  -0.2 ;-1 ;-0.2 ;-0.04    ;52.5
  res8@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res9@trXMinF        =  0    ;60.
  res9@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res9@trYMinF        =  -0.2 ;-1 ;-0.2 ;-0.04    ;52.5
  res9@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000

  ;res1@lbOrientation   = "Vertical"
  ;res1@gsnMaximize = True
  ;res1@tmXTOn         = False

  colours = (/"red","deeppink","green","springgreen4","blue","orange","cyan"/); "red","deeppink","green","springgreen4","blue","darkorchid2","orange","cyan","green","deeppink","red"
  thicknesses = (/8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0/)
  patterns = (/1,2,1,2,0,0,0/)
  ;labels = (/" std(MSE_subcloud)"," std(T_500hPa)"," std(W_700hPa)"," std(T2)"," std(CAPE)"," ave(rain rate)"," ave(PW)"," ave(MSE_subcloud)"," ave(T_500hPa)"/)
  labels = (/" std(T_500hPa)"," std(T2)"," std(Q_500hPa)"," std(Q2)"," ave(rain rate)"," ave(CAPE)",string_pw_get_hor_ave/)
  types   = (/    7   ,   12    ,  9  ,  3   ,  14   ,   15  ,  16 /)

  res1@xyLineColor = colours(0)      
  res2@xyLineColor = colours(1)      
  res3@xyLineColor = colours(2)      
  res4@xyLineColor = colours(3)      
  res5@xyLineColor = colours(4)      
  res6@xyLineColor = colours(5)      
  res7@xyLineColor = colours(6)      

  res1@xyLineThicknesses = thicknesses(0)
  res1@xyDashPattern     = patterns(0)
  res2@xyLineThicknesses = thicknesses(1)
  res2@xyDashPattern     = patterns(1)
  res3@xyLineThicknesses = thicknesses(2)
  res3@xyDashPattern     = patterns(2)
  res4@xyLineThicknesses = thicknesses(3)
  res4@xyDashPattern     = patterns(3)
  res5@xyLineThicknesses = thicknesses(4)
  res5@xyDashPattern     = patterns(4)
  res6@xyLineThicknesses = thicknesses(5)
  res6@xyDashPattern     = patterns(5)
  res7@xyLineThicknesses = thicknesses(6)
  res7@xyDashPattern     = patterns(6)
  ;res1@tiXAxisString = "Time (hours since strong damping started)"

  res1@tiYAxisString    = "Normalised quantities";labels(0)
  res2@tiYAxisString    = labels(1)
  res3@tiYAxisString    = labels(2)
  res4@tiYAxisString    = labels(3)
  res5@tiYAxisString    = labels(4)
  res6@tiYAxisString    = labels(5)
  res7@tiYAxisString    = labels(6)
  ;res3@amOrthogonalPosF = 0.72   ; Move "v" axis line to right a little.
  res1@tiMainString = "" ;"Time series since strong nudging starts"

  res1@xyLineColor            = colours(0)
  res1@xyMarkerColor          = colours(0)
  res1@tiMainString           = ""
  res1@tiXAxisString          = "Time (hours since strong nudging started)"
  res1@tiYAxisString          = "Normalised quantities"   ;labels(0)
  res1@xyMarker               = types(0)
  res1@xyMarkerSizeF          = 10
  res2@xyLineColor            = colours(1)
  res2@xyMarkerColor          = colours(1)
  res2@tiMainString           = res1@tiMainString
  res2@tiXAxisString          = res1@tiXAxisString
  res2@tiYAxisString          = labels(1)
  res2@xyMarker               = types(1)
  res3@xyLineColor            = colours(2)
  res3@xyMarkerColor          = colours(2)
  res3@tiMainString           = res1@tiMainString
  res3@tiXAxisString          = res1@tiXAxisString
  res3@tiYAxisString          = labels(2)
  res3@xyMarker               = types(2)
  res4@xyLineColor            = colours(3)
  res4@xyMarkerColor          = colours(3)
  res4@tiMainString           = res1@tiMainString
  res4@tiXAxisString          = res1@tiXAxisString
  res4@tiYAxisString          = labels(3)
  res4@xyMarker               = types(3)
  res5@xyLineColor            = colours(4)
  res5@xyMarkerColor          = colours(4)
  res5@tiMainString           = res1@tiMainString
  res5@tiXAxisString          = res1@tiXAxisString
  res5@tiYAxisString          = labels(4)
  res5@xyMarker               = types(4)
  res6@xyLineColor            = colours(5)
  res6@xyMarkerColor          = colours(5)
  res6@tiMainString           = res1@tiMainString
  res6@tiXAxisString          = res1@tiXAxisString
  res6@tiYAxisString          = labels(5)
  res6@xyMarker               = types(5)
  res7@xyLineColor            = colours(6)
  res7@xyMarkerColor          = colours(6)
  res7@tiMainString           = res1@tiMainString
  res7@tiXAxisString          = res1@tiXAxisString
  res7@tiYAxisString          = labels(6)
  res7@xyMarker               = types(6)


  ;plot = gsn_csm_xy9(wks, time_hour_from_zero, mse_subcloud_layer_ave_hor_std, temp_500hPa_hor_std, wa_700hPa_hor_std, T2_hor_std, cape_2D_hor_std, rain_rate_hor_ave, pw_get_hor_ave, mse_subcloud_layer_ave_hor_ave, temp_500hPa_hor_ave, res1,res2,res3,res4,res5,res6,res7,res8,res9)

  ;plot123 = gsn_csm_xy3(wks,time_hour_from_zero,mse_subcloud_layer_ave_hor_std,temp_500hPa_hor_std,wa_700hPa_hor_std, res1,res2,res3)
  ;plot45  = gsn_csm_xy2(wks, time_hour_from_zero, T2_hor_std, cape_2D_hor_std, res4,res5)
  ;plot6   = gsn_csm_xy( wks, time_hour_from_zero_adapted_for_integrated_variables_shorter, rain_rate_hor_ave, res6)
  ;plot789 = gsn_csm_xy3(wks, time_hour_from_zero, pw_get_hor_ave, mse_subcloud_layer_ave_hor_ave, temp_500hPa_hor_ave, res7,res8,res9)
  ;overlay(plot123, plot45)
  ;overlay(plot123, plot6)
  ;overlay(plot123, plot789)
  
  ;printVarSummary(time_hour_from_zero)
  ;printVarSummary(mse_subcloud_layer_ave_hor_std)
  ;labels = (/" std(T_500hPa)"," std(T2)"," std(Q_500hPa)"," std(Q2)"," ave(rain rate)"," ave(CAPE)",string_pw_get_hor_ave/)
  ;labels = (/" std(T_500hPa)"," std(T2)"," std(Q_500hPa)"," std(Q2)"," ave(rain rate)"," ave(CAPE)",string_pw_get_hor_ave/)
  plot1 = gsn_csm_xy(wks, time_hour_from_zero, temp_500hPa_hor_std_rescaled, res1)
  plot2 = gsn_csm_xy(wks, time_hour_from_zero, T2_hor_std_rescaled, res2)
  plot3 = gsn_csm_xy(wks, time_hour_from_zero, qvapor_500hPa_hor_std_rescaled, res3)
  plot4 = gsn_csm_xy(wks, time_hour_from_zero, Q2_hor_std_rescaled, res4)
  plot5 = gsn_csm_xy(wks, time_hour_from_zero_adapted_for_integrated_variables_shorter, rain_rate_hor_ave_rescaled, res5)
  plot6 = gsn_csm_xy(wks, time_hour_from_zero, cape_2D_hor_ave_rescaled, res6)
  plot7 = gsn_csm_xy(wks, time_hour_from_zero, pw_get_hor_ave_rescaled, res7)
  overlay(plot1,plot2)
  overlay(plot1,plot3)
  overlay(plot1,plot4)
  overlay(plot1,plot5)
  overlay(plot1,plot6)
  overlay(plot1,plot7)

  ; FIRST ATTEMPT TO ADD MARKERS: DID NOT WORK
  ;ncolors = dimsizes(colours)
  ;nb_points = dimsizes(temp_500hPa_hor_std_rescaled)
  ;dum = new(ncolors,graphic)
  ;pmres = True
  ;
  ;time_hour_from_zero_adapted_for_integrated_variables_shorter_longer = new((/dimsizes(time_hour_from_zero)/),float)
  ;time_hour_from_zero_adapted_for_integrated_variables_shorter_longer(0) = 0
  ;do n=1, nb_points-1
  ;    time_hour_from_zero_adapted_for_integrated_variables_shorter_longer(n) = time_hour_from_zero_adapted_for_integrated_variables_shorter(n-1)
  ;end do
  ;
  ;rain_rate_hor_ave_rescaled_longer = new((/dimsizes(time_hour_from_zero)/),float)
  ;rain_rate_hor_ave_rescaled_longer(0) = 0
  ;do n=1, nb_points-1
  ;    rain_rate_hor_ave_rescaled_longer(n) = rain_rate_hor_ave_rescaled(n-1)
  ;end do
  ;
  ;list_of_xmarkers_data = new((/ncolors,nb_points/),float)
  ;list_of_ymarkers_data = new((/ncolors,nb_points/),float)
  ;list_of_xmarkers_data = (/time_hour_from_zero,time_hour_from_zero,time_hour_from_zero,time_hour_from_zero,time_hour_from_zero_adapted_for_integrated_variables_shorter_longer,time_hour_from_zero,time_hour_from_zero/)
  ;list_of_ymarkers_data = (/temp_500hPa_hor_std_rescaled,T2_hor_std_rescaled,qvapor_500hPa_hor_std_rescaled,Q2_hor_std_rescaled,rain_rate_hor_ave_rescaled_longer,cape_2D_hor_ave_rescaled,pw_get_hor_ave_rescaled/)
  ;
  ;do i=0,ncolors-1
  ;  xmarkers = time_hour_from_zero
  ;  ymarkers = temp_500hPa_hor_std_rescaled
  ;
  ;  pmres@gsMarkerColor = colours(i)
  ;  pmres@gsMarkerIndex = types(i)
  ;  dum(i) = gsn_add_polymarker(wks, plot1, xmarkers, ymarkers, pmres)
  ;end do
  ;
  ;draw(plot1)
  ;frame(wks)
  ; END: FIRST ATTEMPT TO ADD MARKERS: DID NOT WORK

  lgres                     = True
  ;lgres@pmLegendDisplayMode = "Always"
  ;lgres@pmLegendSide = "Top"
  ;lgres@pmLegendOrthogonalPosF = -1.  ;-0.58  ;-0.02 (too high), 0.15 the same, -0.15 half box is too high
  ;lgres@pmLegendParallelPosF = 0.4 ;.67     ; 0.2 is very good
  ;lgres@pmLegendWidthF = 0.0425  ;0.0375
  ;lgres@pmLegendHeightF = 0.15   ;0.28
  ;lgres@lgLabelFontHeightF = 0.02
  ;lgres@xyExplicitLegendLabels = (/" Before strong nudging", " During strong nudging"/)

  lgres@lgLineColors       = colours
  lgres@lgItemType         = "Lines"        ; show lines only (default)
  lgres@lgLabelFontHeightF = 0.3   ;0.12           ; legend label font thickness
  lgres@vpWidthF           = 0.3   ;0.13           ; width of legend (NDC)
  lgres@vpHeightF          = 0.4   ;0.20           ; height of legend (NDC)
  lgres@lgPerimThicknessF  = 2.0            ; thicken the box perimeter
  lgres@lgLineThicknessF   = 8.0
  lgres@lgMonoDashIndex    = False   ;True
  lgres@lgDashIndexes      = patterns

  nitems = dimsizes(labels)                 ; number of legend items
  lbid = gsn_create_legend(wks,nitems,labels,lgres)

  amres                  = True
  amres@amJust           = "BottomRight"    ; Use bottom right corner of box for determining its location.
  amres@amParallelPosF   = -0.08 ;-0.5  ;0.5              ; Move legend to right
  amres@amOrthogonalPosF = 0 ;-0.5  ;0.3              ; Move legend down.
  ;annoid = gsn_add_annotation(plot123,lbid,amres)  ; add legend to plot
  annoid = gsn_add_annotation(plot1,lbid,amres)  ; add legend to plot

  psres = True                                                               
  maximize_output(wks,psres)  ; calls draw and frame for you 


  delete(colours)
  delete(thicknesses)
  delete(patterns)
  delete(labels)
  delete(wks)
  delete(lgres)
  delete(amres)
  delete(res1)




  ; PLOT NUMBER 5
  wks = gsn_open_wks(type,"plot_time_series_together_3rd_variable_set_" + data_dir_for_plots + "_x_zoom_v8.4")

  res1             = True
  res2             = True
  res3             = True
  res4             = True
  res5             = True
  res6             = True
  res7             = True
  res8             = True
  res9             = True
  res1@gsnMaximize = True

  res1@trXMinF        =  4     ;4     ;0    ;60.
  res1@trXMaxF        =  8     ;10    ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res1@trYMinF        =  -0.1  ;-0.1  ;-0.2    ;52.5
  res1@trYMaxF        =  0.15  ;0.3   ;1.5  ;54.5  ; 30.   ;30000
  res2@trXMinF        =  res1@trXMinF     ;0    ;60.
  res2@trXMaxF        =  res1@trXMaxF     ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res2@trYMinF        =  res1@trYMinF     ;-0.2    ;52.5
  res2@trYMaxF        =  res1@trYMaxF     ;1.5  ;54.5  ; 30.   ;30000
  res3@trXMinF        =  res1@trXMinF     ;0    ;60.
  res3@trXMaxF        =  res1@trXMaxF     ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res3@trYMinF        =  res1@trYMinF     ;-0.2    ;52.5
  res3@trYMaxF        =  res1@trYMaxF     ;1.5  ;54.5  ; 30.   ;30000
  res4@trXMinF        =  res1@trXMinF     ;0    ;60.
  res4@trXMaxF        =  res1@trXMaxF     ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res4@trYMinF        =  res1@trYMinF     ;-0.2    ;52.5
  res4@trYMaxF        =  res1@trYMaxF     ;1.5  ;54.5  ; 30.   ;30000
  res5@trXMinF        =  res1@trXMinF     ;0    ;60.
  res5@trXMaxF        =  res1@trXMaxF     ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res5@trYMinF        =  res1@trYMinF     ;-0.2    ;52.5
  res5@trYMaxF        =  res1@trYMaxF     ;1.5  ;54.5  ; 30.   ;30000
  res6@trXMinF        =  res1@trXMinF     ;0    ;60.
  res6@trXMaxF        =  res1@trXMaxF     ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res6@trYMinF        =  res1@trYMinF     ;-0.2    ;52.5
  res6@trYMaxF        =  res1@trYMaxF     ;1.5  ;54.5  ; 30.   ;30000
  res7@trXMinF        =  res1@trXMinF     ;0    ;60.
  res7@trXMaxF        =  res1@trXMaxF     ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res7@trYMinF        =  res1@trYMinF     ;-0.2    ;52.5
  res7@trYMaxF        =  res1@trYMaxF     ;1.5  ;54.5  ; 30.   ;30000
  res8@trXMinF        =  res1@trXMinF     ;0    ;60.
  res8@trXMaxF        =  res1@trXMaxF     ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res8@trYMinF        =  res1@trYMinF     ;-0.2    ;52.5
  res8@trYMaxF        =  res1@trYMaxF     ;1.5  ;54.5  ; 30.   ;30000
  res9@trXMinF        =  res1@trXMinF     ;0    ;60.
  res9@trXMaxF        =  res1@trXMaxF     ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res9@trYMinF        =  res1@trYMinF     ;-0.2    ;52.5
  res9@trYMaxF        =  res1@trYMaxF     ;1.5  ;54.5  ; 30.   ;30000

  ;res1@lbOrientation   = "Vertical"
  ;res1@gsnMaximize = True
  ;res1@tmXTOn         = False

  colours = (/"red","deeppink","green","springgreen4","blue","orange","cyan"/); "red","deeppink","green","springgreen4","blue","darkorchid2","orange","cyan","green","deeppink","red"
  thicknesses = (/8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0/)
  patterns = (/1,2,1,2,0,0,0/)
  ;labels = (/" std(MSE_subcloud)"," std(T_500hPa)"," std(W_700hPa)"," std(T2)"," std(CAPE)"," ave(rain rate)"," ave(PW)"," ave(MSE_subcloud)"," ave(T_500hPa)"/)
  labels = (/" std(T_500hPa)"," std(T2)"," std(Q_500hPa)"," std(Q2)"," ave(rain rate)"," ave(CAPE)",string_pw_get_hor_ave/)

  res1@xyLineColor = colours(0)      
  res2@xyLineColor = colours(1)      
  res3@xyLineColor = colours(2)      
  res4@xyLineColor = colours(3)      
  res5@xyLineColor = colours(4)      
  res6@xyLineColor = colours(5)      
  res7@xyLineColor = colours(6)      

  res1@xyLineThicknesses = thicknesses(0)
  res1@xyDashPattern     = patterns(0)
  res2@xyLineThicknesses = thicknesses(1)
  res2@xyDashPattern     = patterns(1)
  res3@xyLineThicknesses = thicknesses(2)
  res3@xyDashPattern     = patterns(2)
  res4@xyLineThicknesses = thicknesses(3)
  res4@xyDashPattern     = patterns(3)
  res5@xyLineThicknesses = thicknesses(4)
  res5@xyDashPattern     = patterns(4)
  res6@xyLineThicknesses = thicknesses(5)
  res6@xyDashPattern     = patterns(5)
  res7@xyLineThicknesses = thicknesses(6)
  res7@xyDashPattern     = patterns(6)
  res1@tiXAxisString = "Time (hours since strong nudging started)"

  res1@tiYAxisString    = "Normalised quantities";labels(0)
  res2@tiYAxisString    = labels(1)
  res3@tiYAxisString    = labels(2)
  res4@tiYAxisString    = labels(3)
  res5@tiYAxisString    = labels(4)
  res6@tiYAxisString    = labels(5)
  res7@tiYAxisString    = labels(6)
  ;res3@amOrthogonalPosF = 0.72   ; Move "v" axis line to right a little.
  res1@tiMainString = "" ;"Time series since strong nudging starts"

  ;plot = gsn_csm_xy9(wks, time_hour_from_zero, mse_subcloud_layer_ave_hor_std, temp_500hPa_hor_std, wa_700hPa_hor_std, T2_hor_std, cape_2D_hor_std, rain_rate_hor_ave, pw_get_hor_ave, mse_subcloud_layer_ave_hor_ave, temp_500hPa_hor_ave, res1,res2,res3,res4,res5,res6,res7,res8,res9)

  ;plot123 = gsn_csm_xy3(wks,time_hour_from_zero,mse_subcloud_layer_ave_hor_std,temp_500hPa_hor_std,wa_700hPa_hor_std, res1,res2,res3)
  ;plot45  = gsn_csm_xy2(wks, time_hour_from_zero, T2_hor_std, cape_2D_hor_std, res4,res5)
  ;plot6   = gsn_csm_xy( wks, time_hour_from_zero_adapted_for_integrated_variables_shorter, rain_rate_hor_ave, res6)
  ;plot789 = gsn_csm_xy3(wks, time_hour_from_zero, pw_get_hor_ave, mse_subcloud_layer_ave_hor_ave, temp_500hPa_hor_ave, res7,res8,res9)
  ;overlay(plot123, plot45)
  ;overlay(plot123, plot6)
  ;overlay(plot123, plot789)
  
  ;printVarSummary(time_hour_from_zero)
  ;printVarSummary(mse_subcloud_layer_ave_hor_std)
  ;labels = (/" std(T_500hPa)"," std(T2)"," std(Q_500hPa)"," std(Q2)"," ave(rain rate)"," ave(CAPE)",string_pw_get_hor_ave/)
  ;labels = (/" std(T_500hPa)"," std(T2)"," std(Q_500hPa)"," std(Q2)"," ave(rain rate)"," ave(CAPE)",string_pw_get_hor_ave/)
  plot1 = gsn_csm_xy(wks, time_hour_from_zero, temp_500hPa_hor_std_rescaled, res1)
  plot2 = gsn_csm_xy(wks, time_hour_from_zero, T2_hor_std_rescaled, res2)
  plot3 = gsn_csm_xy(wks, time_hour_from_zero, qvapor_500hPa_hor_std_rescaled, res3)
  plot4 = gsn_csm_xy(wks, time_hour_from_zero, Q2_hor_std_rescaled, res4)
  plot5 = gsn_csm_xy(wks, time_hour_from_zero_adapted_for_integrated_variables_shorter, rain_rate_hor_ave_rescaled, res5)
  plot6 = gsn_csm_xy(wks, time_hour_from_zero, cape_2D_hor_ave_rescaled, res6)
  plot7 = gsn_csm_xy(wks, time_hour_from_zero, pw_get_hor_ave_rescaled, res7)
  overlay(plot1,plot2)
  overlay(plot1,plot3)
  overlay(plot1,plot4)
  overlay(plot1,plot5)
  overlay(plot1,plot6)
  overlay(plot1,plot7)


  lgres                     = True
  ;lgres@pmLegendDisplayMode = "Always"
  ;lgres@pmLegendSide = "Top"
  ;lgres@pmLegendOrthogonalPosF = -1.  ;-0.58  ;-0.02 (too high), 0.15 the same, -0.15 half box is too high
  ;lgres@pmLegendParallelPosF = 0.4 ;.67     ; 0.2 is very good
  ;lgres@pmLegendWidthF = 0.0425  ;0.0375
  ;lgres@pmLegendHeightF = 0.15   ;0.28
  ;lgres@lgLabelFontHeightF = 0.02
  ;lgres@xyExplicitLegendLabels = (/" Before strong nudging", " During strong nudging"/)

  lgres@lgLineColors       = colours
  lgres@lgItemType         = "Lines"        ; show lines only (default)
  lgres@lgLabelFontHeightF = 0.3   ;0.12           ; legend label font thickness
  lgres@vpWidthF           = 0.3   ;0.13           ; width of legend (NDC)
  lgres@vpHeightF          = 0.4   ;0.20           ; height of legend (NDC)
  lgres@lgPerimThicknessF  = 2.0            ; thicken the box perimeter
  lgres@lgLineThicknessF   = 8.0
  lgres@lgMonoDashIndex    = False   ;True
  lgres@lgDashIndexes      = patterns

  nitems = dimsizes(labels)                 ; number of legend items
  lbid = gsn_create_legend(wks,nitems,labels,lgres)

  amres                  = True
  amres@amJust           = "TopLeft"   ;"BottomRight"    ; Use bottom right corner of box for determining its location.
  amres@amParallelPosF   = -0.5    ;0.5              ; Move legend to right
  amres@amOrthogonalPosF = -0.5    ;0.3              ; Move legend down.
  ;annoid = gsn_add_annotation(plot123,lbid,amres)  ; add legend to plot
  annoid = gsn_add_annotation(plot1,lbid,amres)  ; add legend to plot

  psres = True                                                               
  maximize_output(wks,psres)  ; calls draw and frame for you 


;/






  ; PLOT NUMBER 6 (FOR STEVE'S PAPER ON PREDATOR-PREY MODEL, 2020-10-07)
  wks = gsn_open_wks(type,"plot_time_series_together_4th_variable_set_for_paper_" + data_dir_for_plots + "_v9.4")

  res1             = True
  res2             = True
  res3             = True
  res4             = True
  res5             = True
  res6             = True
  res7             = True
  res8             = True
  res9             = True
  res10            = True
  res11            = True
  res12            = True
  res1@gsnMaximize = True
  ;res1@xyLineThicknessF       = 3.     ; Thicken the lines
  res1@xyMarkLineMode         = "Lines"
  ;res1@xyMarkLineMode         = "MarkLines"

  res1@trXMinF        =  0    ;60.
  res1@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res1@trYMinF        =  -0.2 ;-1 ;-0.2 ;-0.04    ;52.5
  res1@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res2@trXMinF        =  0    ;60.
  res2@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res2@trYMinF        =  -0.2 ;-1 ;-0.2 ;-0.04    ;52.5
  res2@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res3@trXMinF        =  0    ;60.
  res3@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res3@trYMinF        =  -0.2 ;-1 ;-0.2 ;-0.04    ;52.5
  res3@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res4@trXMinF        =  0    ;60.
  res4@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res4@trYMinF        =  -0.2 ;-1 ;-0.2 ;-0.04    ;52.5
  res4@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res5@trXMinF        =  0    ;60.
  res5@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res5@trYMinF        =  -0.2 ;-1 ;-0.2 ;-0.04    ;52.5
  res5@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res6@trXMinF        =  0    ;60.
  res6@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res6@trYMinF        =  -0.2 ;-1 ;-0.2 ;-0.04    ;52.5
  res6@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res7@trXMinF        =  0    ;60.
  res7@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res7@trYMinF        =  -0.2 ;-1 ;-0.2 ;-0.04    ;52.5
  res7@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res8@trXMinF        =  0    ;60.
  res8@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res8@trYMinF        =  -0.2 ;-1 ;-0.2 ;-0.04    ;52.5
  res8@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res9@trXMinF        =  0    ;60.
  res9@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res9@trYMinF        =  -0.2 ;-1 ;-0.2 ;-0.04    ;52.5
  res9@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res10@trXMinF        =  0    ;60.
  res10@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res10@trYMinF        =  -0.2 ;-1 ;-0.2 ;-0.04    ;52.5
  res10@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res11@trXMinF        =  0    ;60.
  res11@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res11@trYMinF        =  -0.2 ;-1 ;-0.2 ;-0.04    ;52.5
  res11@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000
  res12@trXMinF        =  0    ;60.
  res12@trXMaxF        =  24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res12@trYMinF        =  -0.2 ;-1 ;-0.2 ;-0.04    ;52.5
  res12@trYMaxF        =  1.5  ;54.5  ; 30.   ;30000

  ;res1@lbOrientation   = "Vertical"
  ;res1@gsnMaximize = True
  ;res1@tmXTOn         = False

  colours = (/"darkorchid2","black","orange","red","deeppink","green","springgreen4","orange","blue","cyan","red","darkorchid2"/); "red","deeppink","green","springgreen4","blue","darkorchid2","orange","cyan","green","deeppink","red"
  ;thicknesses = (/8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0/)
  thicknesses = (/6.0,6.0,6.0,6.0,6.0,6.0,6.0,6.0,6.0,6.0,6.0,6.0/)
  patterns = (/16,16,16,14,14,14,14,0,0,0,0,0/)  ;(/1,1,1,2,2,2,2,0,0,0,0,0/)
  ;labels = (/" std(MSE_subcloud)"," std(T_500hPa)"," std(W_700hPa)"," std(T2)"," std(CAPE)"," ave(rain rate)"," ave(PW)"," ave(MSE_subcloud)"," ave(T_500hPa)"/)
  labels = (/" std(MSE_sub)"," std(W_700)"," std(CAPE)"," std(T_500)"," std(T2)"," std(Q_500)"," std(Q2)"," ave(CAPE)"," ave(rain rate)",string_pw_get_hor_ave," ave(T_500)",string_mse_subcloud_layer_ave_hor_ave/)
  types   = (/    7   ,   12    ,  9  ,  3   ,  14   ,   15  ,  16 /)

  res1@xyLineColor = colours(0)      
  res2@xyLineColor = colours(1)      
  res3@xyLineColor = colours(2)      
  res4@xyLineColor = colours(3)      
  res5@xyLineColor = colours(4)      
  res6@xyLineColor = colours(5)      
  res7@xyLineColor = colours(6)      
  res8@xyLineColor = colours(7)      
  res9@xyLineColor = colours(8)      
  res10@xyLineColor = colours(9)      
  res11@xyLineColor = colours(10)      
  res12@xyLineColor = colours(11)      

  res1@xyLineThicknesses = thicknesses(0)
  res1@xyDashPattern     = patterns(0)
  res2@xyLineThicknesses = thicknesses(1)
  res2@xyDashPattern     = patterns(1)
  res3@xyLineThicknesses = thicknesses(2)
  res3@xyDashPattern     = patterns(2)
  res4@xyLineThicknesses = thicknesses(3)
  res4@xyDashPattern     = patterns(3)
  res5@xyLineThicknesses = thicknesses(4)
  res5@xyDashPattern     = patterns(4)
  res6@xyLineThicknesses = thicknesses(5)
  res6@xyDashPattern     = patterns(5)
  res7@xyLineThicknesses = thicknesses(6)
  res7@xyDashPattern     = patterns(6)
  res8@xyLineThicknesses = thicknesses(7)
  res8@xyDashPattern     = patterns(7)
  res9@xyLineThicknesses = thicknesses(8)
  res9@xyDashPattern     = patterns(8)
  res10@xyLineThicknesses = thicknesses(9)
  res10@xyDashPattern     = patterns(9)
  res11@xyLineThicknesses = thicknesses(10)
  res11@xyDashPattern     = patterns(10)
  res12@xyLineThicknesses = thicknesses(11)
  res12@xyDashPattern     = patterns(11)
  ;res1@tiXAxisString = "Time (hours since strong damping started)"

  res1@tiYAxisString    = "Normalised quantities";labels(0)
  res2@tiYAxisString    = labels(1)
  res3@tiYAxisString    = labels(2)
  res4@tiYAxisString    = labels(3)
  res5@tiYAxisString    = labels(4)
  res6@tiYAxisString    = labels(5)
  res7@tiYAxisString    = labels(6)
  res8@tiYAxisString    = labels(7)
  res9@tiYAxisString    = labels(8)
  res10@tiYAxisString    = labels(9)
  res11@tiYAxisString    = labels(10)
  res12@tiYAxisString    = labels(11)
  ;res3@amOrthogonalPosF = 0.72   ; Move "v" axis line to right a little.
  res1@tiMainString = "" ;"Time series since strong nudging starts"

  res1@xyLineColor            = colours(0)
  ;res1@xyMarkerColor          = colours(0)
  res1@tiMainString           = ""
  res1@tiXAxisString          = "Time (hours since strong nudging started)"
  res1@tiYAxisString          = "Normalised quantities"   ;labels(0)
  ;res1@xyMarker               = types(0)
  ;res1@xyMarkerSizeF          = 10
  res2@xyLineColor            = colours(1)
  res2@xyMarkerColor          = colours(1)
  res2@tiMainString           = res1@tiMainString
  res2@tiXAxisString          = res1@tiXAxisString
  res2@tiYAxisString          = labels(1)
  ;res2@xyMarker               = types(1)
  res3@xyLineColor            = colours(2)
  res3@xyMarkerColor          = colours(2)
  res3@tiMainString           = res1@tiMainString
  res3@tiXAxisString          = res1@tiXAxisString
  res3@tiYAxisString          = labels(2)
  ;res3@xyMarker               = types(2)
  res4@xyLineColor            = colours(3)
  res4@xyMarkerColor          = colours(3)
  res4@tiMainString           = res1@tiMainString
  res4@tiXAxisString          = res1@tiXAxisString
  res4@tiYAxisString          = labels(3)
  ;res4@xyMarker               = types(3)
  res5@xyLineColor            = colours(4)
  res5@xyMarkerColor          = colours(4)
  res5@tiMainString           = res1@tiMainString
  res5@tiXAxisString          = res1@tiXAxisString
  res5@tiYAxisString          = labels(4)
  ;res5@xyMarker               = types(4)
  res6@xyLineColor            = colours(5)
  res6@xyMarkerColor          = colours(5)
  res6@tiMainString           = res1@tiMainString
  res6@tiXAxisString          = res1@tiXAxisString
  res6@tiYAxisString          = labels(5)
  ;res6@xyMarker               = types(5)
  res7@xyLineColor            = colours(6)
  res7@xyMarkerColor          = colours(6)
  res7@tiMainString           = res1@tiMainString
  res7@tiXAxisString          = res1@tiXAxisString
  res7@tiYAxisString          = labels(6)
  ;res7@xyMarker               = types(6)
  res8@xyLineColor            = colours(7)
  res8@xyMarkerColor          = colours(7)
  res8@tiMainString           = res1@tiMainString
  res8@tiXAxisString          = res1@tiXAxisString
  res8@tiYAxisString          = labels(7)
  ;res8@xyMarker               = types(7)
  res9@xyLineColor            = colours(8)
  res9@xyMarkerColor          = colours(8)
  res9@tiMainString           = res1@tiMainString
  res9@tiXAxisString          = res1@tiXAxisString
  res9@tiYAxisString          = labels(8)
  ;res9@xyMarker               = types(8)
  res10@xyLineColor            = colours(9)
  res10@xyMarkerColor          = colours(9)
  res10@tiMainString           = res1@tiMainString
  res10@tiXAxisString          = res1@tiXAxisString
  res10@tiYAxisString          = labels(9)
  ;res10@xyMarker               = types(9)
  res11@xyLineColor            = colours(10)
  res11@xyMarkerColor          = colours(10)
  res11@tiMainString           = res1@tiMainString
  res11@tiXAxisString          = res1@tiXAxisString
  res11@tiYAxisString          = labels(10)
  ;res11@xyMarker               = types(10)
  res12@xyLineColor            = colours(11)
  res12@xyMarkerColor          = colours(11)
  res12@tiMainString           = res1@tiMainString
  res12@tiXAxisString          = res1@tiXAxisString
  res12@tiYAxisString          = labels(11)
  ;res12@xyMarker               = types(11)


  ;plot = gsn_csm_xy9(wks, time_hour_from_zero, mse_subcloud_layer_ave_hor_std, temp_500hPa_hor_std, wa_700hPa_hor_std, T2_hor_std, cape_2D_hor_std, rain_rate_hor_ave, pw_get_hor_ave, mse_subcloud_layer_ave_hor_ave, temp_500hPa_hor_ave, res1,res2,res3,res4,res5,res6,res7,res8,res9)

  ;plot123 = gsn_csm_xy3(wks,time_hour_from_zero,mse_subcloud_layer_ave_hor_std,temp_500hPa_hor_std,wa_700hPa_hor_std, res1,res2,res3)
  ;plot45  = gsn_csm_xy2(wks, time_hour_from_zero, T2_hor_std, cape_2D_hor_std, res4,res5)
  ;plot6   = gsn_csm_xy( wks, time_hour_from_zero_adapted_for_integrated_variables_shorter, rain_rate_hor_ave, res6)
  ;plot789 = gsn_csm_xy3(wks, time_hour_from_zero, pw_get_hor_ave, mse_subcloud_layer_ave_hor_ave, temp_500hPa_hor_ave, res7,res8,res9)
  ;overlay(plot123, plot45)
  ;overlay(plot123, plot6)
  ;overlay(plot123, plot789)
  
  ;printVarSummary(time_hour_from_zero)
  ;printVarSummary(mse_subcloud_layer_ave_hor_std)
  ;labels = (/" std(T_500hPa)"," std(T2)"," std(Q_500hPa)"," std(Q2)"," ave(rain rate)"," ave(CAPE)",string_pw_get_hor_ave/)
  ;labels = (/" std(T_500hPa)"," std(T2)"," std(Q_500hPa)"," std(Q2)"," ave(rain rate)"," ave(CAPE)",string_pw_get_hor_ave/)
  plot1 = gsn_csm_xy(wks, time_hour_from_zero, mse_subcloud_layer_ave_hor_std_rescaled, res1)
  plot2 = gsn_csm_xy(wks, time_hour_from_zero, wa_700hPa_hor_std_rescaled, res2)
  plot3 = gsn_csm_xy(wks, time_hour_from_zero, cape_2D_hor_std_rescaled, res3)
  plot4 = gsn_csm_xy(wks, time_hour_from_zero, temp_500hPa_hor_std_rescaled, res4)
  plot5 = gsn_csm_xy(wks, time_hour_from_zero, T2_hor_std_rescaled, res5)
  plot6 = gsn_csm_xy(wks, time_hour_from_zero, qvapor_500hPa_hor_std_rescaled, res6)
  plot7 = gsn_csm_xy(wks, time_hour_from_zero, Q2_hor_std_rescaled, res7)
  plot8 = gsn_csm_xy(wks, time_hour_from_zero, cape_2D_hor_ave_rescaled, res8)
  plot9 = gsn_csm_xy(wks, time_hour_from_zero_adapted_for_integrated_variables_shorter, rain_rate_hor_ave_rescaled, res9)
  plot10 = gsn_csm_xy(wks, time_hour_from_zero, pw_get_hor_ave_rescaled, res10)
  plot11 = gsn_csm_xy(wks, time_hour_from_zero, temp_500hPa_hor_ave_rescaled, res11)
  plot12 = gsn_csm_xy(wks, time_hour_from_zero, mse_subcloud_layer_ave_hor_ave_rescaled, res12)

  overlay(plot1,plot2)
  overlay(plot1,plot3)
  overlay(plot1,plot4)
  overlay(plot1,plot5)
  overlay(plot1,plot6)
  overlay(plot1,plot7)
  overlay(plot1,plot8)
  overlay(plot1,plot9)
  overlay(plot1,plot10)
  overlay(plot1,plot11)
  overlay(plot1,plot12)

  ; FIRST ATTEMPT TO ADD MARKERS: DID NOT WORK
  ;ncolors = dimsizes(colours)
  ;nb_points = dimsizes(temp_500hPa_hor_std_rescaled)
  ;dum = new(ncolors,graphic)
  ;pmres = True
  ;
  ;time_hour_from_zero_adapted_for_integrated_variables_shorter_longer = new((/dimsizes(time_hour_from_zero)/),float)
  ;time_hour_from_zero_adapted_for_integrated_variables_shorter_longer(0) = 0
  ;do n=1, nb_points-1
  ;    time_hour_from_zero_adapted_for_integrated_variables_shorter_longer(n) = time_hour_from_zero_adapted_for_integrated_variables_shorter(n-1)
  ;end do
  ;
  ;rain_rate_hor_ave_rescaled_longer = new((/dimsizes(time_hour_from_zero)/),float)
  ;rain_rate_hor_ave_rescaled_longer(0) = 0
  ;do n=1, nb_points-1
  ;    rain_rate_hor_ave_rescaled_longer(n) = rain_rate_hor_ave_rescaled(n-1)
  ;end do
  ;
  ;list_of_xmarkers_data = new((/ncolors,nb_points/),float)
  ;list_of_ymarkers_data = new((/ncolors,nb_points/),float)
  ;list_of_xmarkers_data = (/time_hour_from_zero,time_hour_from_zero,time_hour_from_zero,time_hour_from_zero,time_hour_from_zero_adapted_for_integrated_variables_shorter_longer,time_hour_from_zero,time_hour_from_zero/)
  ;list_of_ymarkers_data = (/temp_500hPa_hor_std_rescaled,T2_hor_std_rescaled,qvapor_500hPa_hor_std_rescaled,Q2_hor_std_rescaled,rain_rate_hor_ave_rescaled_longer,cape_2D_hor_ave_rescaled,pw_get_hor_ave_rescaled/)
  ;
  ;do i=0,ncolors-1
  ;  xmarkers = time_hour_from_zero
  ;  ymarkers = temp_500hPa_hor_std_rescaled
  ;
  ;  pmres@gsMarkerColor = colours(i)
  ;  pmres@gsMarkerIndex = types(i)
  ;  dum(i) = gsn_add_polymarker(wks, plot1, xmarkers, ymarkers, pmres)
  ;end do
  ;
  ;draw(plot1)
  ;frame(wks)
  ; END: FIRST ATTEMPT TO ADD MARKERS: DID NOT WORK

  lgres                     = True
  ;lgres@pmLegendDisplayMode = "Always"
  ;lgres@pmLegendSide = "Top"
  ;lgres@pmLegendOrthogonalPosF = -1.  ;-0.58  ;-0.02 (too high), 0.15 the same, -0.15 half box is too high
  ;lgres@pmLegendParallelPosF = 0.4 ;.67     ; 0.2 is very good
  ;lgres@pmLegendWidthF = 0.0425  ;0.0375
  ;lgres@pmLegendHeightF = 0.15   ;0.28
  ;lgres@lgLabelFontHeightF = 0.02
  ;lgres@xyExplicitLegendLabels = (/" Before strong nudging", " During strong nudging"/)

  lgres@lgLineColors       = colours
  lgres@lgItemType         = "Lines"        ; show lines only (default)
  lgres@lgLabelFontHeightF = 0.2   ;0.3   ;0.12           ; legend label font thickness
  lgres@vpWidthF           = 0.3   ;0.13           ; width of legend (NDC)
  lgres@vpHeightF          = 0.5   ;0.4   ;0.20           ; height of legend (NDC)
  lgres@lgPerimThicknessF  = 2.0            ; thicken the box perimeter
  lgres@lgLineThicknessF   = 6.0   ;8.0
  lgres@lgMonoDashIndex    = False   ;True
  lgres@lgDashIndexes      = patterns

  nitems = dimsizes(labels)                 ; number of legend items
  lbid = gsn_create_legend(wks,nitems,labels,lgres)

  amres                  = True
  amres@amJust           = "BottomRight"    ; Use bottom right corner of box for determining its location.
  ;amres@amParallelPosF   = 0.5  ;-0.08 ;-0.5  ;0.5              ; Move legend to right
  ;amres@amOrthogonalPosF = 0.5  ;0 ;-0.5  ;0.3              ; Move legend down.
  amres@amParallelPosF   = -0.105  ;-0.08 ;-0.5  ;0.5              ; Move legend to right
  amres@amOrthogonalPosF = 0.125  ;0 ;-0.5  ;0.3              ; Move legend down.
  ;annoid = gsn_add_annotation(plot123,lbid,amres)  ; add legend to plot
  annoid = gsn_add_annotation(plot1,lbid,amres)  ; add legend to plot

  psres = True                                                               
  maximize_output(wks,psres)  ; calls draw and frame for you 


  delete(colours)
  delete(thicknesses)
  delete(patterns)
  delete(labels)
  delete(wks)
  delete(lgres)
  delete(amres)
  delete(res1)








  ; PLOT NUMBER 7
  wks = gsn_open_wks(type,"plot_time_series_together_4th_variable_set_for_paper_" + data_dir_for_plots + "_x_zoom_v9.2")

  res1             = True
  res2             = True
  res3             = True
  res4             = True
  res5             = True
  res6             = True
  res7             = True
  res8             = True
  res9             = True
  res10            = True
  res11            = True
  res12            = True
  res1@gsnMaximize = True
  ;res1@xyLineThicknessF       = 3.     ; Thicken the lines
  res1@xyMarkLineMode         = "Lines"
  ;res1@xyMarkLineMode         = "MarkLines"

  res1@trXMinF        =  4    ;60.
  res1@trXMaxF        =  8    ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res1@trYMinF        =  -0.1  ;-0.1 ;-1 ;-0.2 ;-0.04    ;52.5
  res1@trYMaxF        =  0.12  ;0.15 ;54.5  ; 30.   ;30000
  res2@trXMinF        =  res1@trXMinF     ;0    ;60.
  res2@trXMaxF        =  res1@trXMaxF     ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res2@trYMinF        =  res1@trYMinF     ;-0.2 ;-1 ;-0.2 ;-0.04    ;52.5
  res2@trYMaxF        =  res1@trYMaxF     ;1.5  ;54.5  ; 30.   ;30000
  res3@trXMinF        =  res1@trXMinF     ;0    ;60.
  res3@trXMaxF        =  res1@trXMaxF     ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res3@trYMinF        =  res1@trYMinF     ;-0.2 ;-1 ;-0.2 ;-0.04    ;52.5
  res3@trYMaxF        =  res1@trYMaxF     ;1.5  ;54.5  ; 30.   ;30000
  res4@trXMinF        =  res1@trXMinF     ;0    ;60.
  res4@trXMaxF        =  res1@trXMaxF     ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res4@trYMinF        =  res1@trYMinF     ;-0.2 ;-1 ;-0.2 ;-0.04    ;52.5
  res4@trYMaxF        =  res1@trYMaxF     ;1.5  ;54.5  ; 30.   ;30000
  res5@trXMinF        =  res1@trXMinF     ;0    ;60.
  res5@trXMaxF        =  res1@trXMaxF     ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res5@trYMinF        =  res1@trYMinF     ;-0.2 ;-1 ;-0.2 ;-0.04    ;52.5
  res5@trYMaxF        =  res1@trYMaxF     ;1.5  ;54.5  ; 30.   ;30000
  res6@trXMinF        =  res1@trXMinF     ;0    ;60.
  res6@trXMaxF        =  res1@trXMaxF     ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res6@trYMinF        =  res1@trYMinF     ;-0.2 ;-1 ;-0.2 ;-0.04    ;52.5
  res6@trYMaxF        =  res1@trYMaxF     ;1.5  ;54.5  ; 30.   ;30000
  res7@trXMinF        =  res1@trXMinF     ;0    ;60.
  res7@trXMaxF        =  res1@trXMaxF     ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res7@trYMinF        =  res1@trYMinF     ;-0.2 ;-1 ;-0.2 ;-0.04    ;52.5
  res7@trYMaxF        =  res1@trYMaxF     ;1.5  ;54.5  ; 30.   ;30000
  res8@trXMinF        =  res1@trXMinF     ;0    ;60.
  res8@trXMaxF        =  res1@trXMaxF     ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res8@trYMinF        =  res1@trYMinF     ;-0.2 ;-1 ;-0.2 ;-0.04    ;52.5
  res8@trYMaxF        =  res1@trYMaxF     ;1.5  ;54.5  ; 30.   ;30000
  res9@trXMinF        =  res1@trXMinF     ;0    ;60.
  res9@trXMaxF        =  res1@trXMaxF     ;24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res9@trYMinF        =  res1@trYMinF     ;-0.2 ;-1 ;-0.2 ;-0.04    ;52.5
  res9@trYMaxF        =  res1@trYMaxF     ;1.5  ;54.5  ; 30.   ;30000
  res10@trXMinF        = res1@trXMinF     ; 0    ;60.
  res10@trXMaxF        = res1@trXMaxF     ; 24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res10@trYMinF        = res1@trYMinF     ; -0.2 ;-1 ;-0.2 ;-0.04    ;52.5
  res10@trYMaxF        = res1@trYMaxF     ; 1.5  ;54.5  ; 30.   ;30000
  res11@trXMinF        = res1@trXMinF     ; 0    ;60.
  res11@trXMaxF        = res1@trXMaxF     ; 24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res11@trYMinF        = res1@trYMinF     ; -0.2 ;-1 ;-0.2 ;-0.04    ;52.5
  res11@trYMaxF        = res1@trYMaxF     ; 1.5  ;54.5  ; 30.   ;30000
  res12@trXMinF        = res1@trXMinF     ; 0    ;60.
  res12@trXMaxF        = res1@trXMaxF     ; 24   ;62.  ;1. ;  max(time_hour_from_zero)    ; Control end of X axis
  res12@trYMinF        = res1@trYMinF     ; -0.2 ;-1 ;-0.2 ;-0.04    ;52.5
  res12@trYMaxF        = res1@trYMaxF     ; 1.5  ;54.5  ; 30.   ;30000

  ;res1@lbOrientation   = "Vertical"
  ;res1@gsnMaximize = True
  ;res1@tmXTOn         = False

  colours = (/"darkorchid2","black","orange","red","deeppink","green","springgreen4","orange","blue","cyan","red","darkorchid2"/); "red","deeppink","green","springgreen4","blue","darkorchid2","orange","cyan","green","deeppink","red"
  ;thicknesses = (/8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0/)
  ;thicknesses = (/6.0,6.0,6.0,6.0,6.0,6.0,6.0,6.0,6.0,6.0,6.0,6.0/)
  thicknesses = (/10.0,10.0,10.0,10.0,10.0,10.0,10.0,10.0,10.0,10.0,10.0,10.0/)
  patterns = (/16,16,16,14,14,14,14,0,0,0,0,0/)  ;(/1,1,1,2,2,2,2,0,0,0,0,0/)
  ;labels = (/" std(MSE_subcloud)"," std(T_500hPa)"," std(W_700hPa)"," std(T2)"," std(CAPE)"," ave(rain rate)"," ave(PW)"," ave(MSE_subcloud)"," ave(T_500hPa)"/)
  labels = (/" std(MSE_sub)"," std(W_700)"," std(CAPE)"," std(T_500)"," std(T2)"," std(Q_500)"," std(Q2)"," ave(CAPE)"," ave(rain rate)",string_pw_get_hor_ave," ave(T_500)",string_mse_subcloud_layer_ave_hor_ave/)
  types   = (/    7   ,   12    ,  9  ,  3   ,  14   ,   15  ,  16 /)

  res1@xyLineColor = colours(0)      
  res2@xyLineColor = colours(1)      
  res3@xyLineColor = colours(2)      
  res4@xyLineColor = colours(3)      
  res5@xyLineColor = colours(4)      
  res6@xyLineColor = colours(5)      
  res7@xyLineColor = colours(6)      
  res8@xyLineColor = colours(7)      
  res9@xyLineColor = colours(8)      
  res10@xyLineColor = colours(9)      
  res11@xyLineColor = colours(10)      
  res12@xyLineColor = colours(11)      

  res1@xyLineThicknesses = thicknesses(0)
  res1@xyDashPattern     = patterns(0)
  res2@xyLineThicknesses = thicknesses(1)
  res2@xyDashPattern     = patterns(1)
  res3@xyLineThicknesses = thicknesses(2)
  res3@xyDashPattern     = patterns(2)
  res4@xyLineThicknesses = thicknesses(3)
  res4@xyDashPattern     = patterns(3)
  res5@xyLineThicknesses = thicknesses(4)
  res5@xyDashPattern     = patterns(4)
  res6@xyLineThicknesses = thicknesses(5)
  res6@xyDashPattern     = patterns(5)
  res7@xyLineThicknesses = thicknesses(6)
  res7@xyDashPattern     = patterns(6)
  res8@xyLineThicknesses = thicknesses(7)
  res8@xyDashPattern     = patterns(7)
  res9@xyLineThicknesses = thicknesses(8)
  res9@xyDashPattern     = patterns(8)
  res10@xyLineThicknesses = thicknesses(9)
  res10@xyDashPattern     = patterns(9)
  res11@xyLineThicknesses = thicknesses(10)
  res11@xyDashPattern     = patterns(10)
  res12@xyLineThicknesses = thicknesses(11)
  res12@xyDashPattern     = patterns(11)
  ;res1@tiXAxisString = "Time (hours since strong damping started)"

  res1@tiYAxisString    = "Normalised quantities";labels(0)
  res2@tiYAxisString    = labels(1)
  res3@tiYAxisString    = labels(2)
  res4@tiYAxisString    = labels(3)
  res5@tiYAxisString    = labels(4)
  res6@tiYAxisString    = labels(5)
  res7@tiYAxisString    = labels(6)
  res8@tiYAxisString    = labels(7)
  res9@tiYAxisString    = labels(8)
  res10@tiYAxisString    = labels(9)
  res11@tiYAxisString    = labels(10)
  res12@tiYAxisString    = labels(11)
  ;res3@amOrthogonalPosF = 0.72   ; Move "v" axis line to right a little.
  res1@tiMainString = "" ;"Time series since strong nudging starts"

  ;res1@xyLineColor            = colours(0)
  ;res1@xyMarkerColor          = colours(0)
  res1@tiMainString           = ""
  res1@tiXAxisString          = "Time (hours since strong nudging started)"
  res1@tiYAxisString          = "Normalised quantities"   ;labels(0)
  ;res1@xyMarker               = types(0)
  ;res1@xyMarkerSizeF          = 10
  ;res2@xyLineColor            = colours(1)
  ;res2@xyMarkerColor          = colours(1)
  res2@tiMainString           = res1@tiMainString
  res2@tiXAxisString          = res1@tiXAxisString
  res2@tiYAxisString          = labels(1)
  ;res2@xyMarker               = types(1)
  ;res3@xyLineColor            = colours(2)
  ;res3@xyMarkerColor          = colours(2)
  res3@tiMainString           = res1@tiMainString
  res3@tiXAxisString          = res1@tiXAxisString
  res3@tiYAxisString          = labels(2)
  ;res3@xyMarker               = types(2)
  ;res4@xyLineColor            = colours(3)
  ;res4@xyMarkerColor          = colours(3)
  res4@tiMainString           = res1@tiMainString
  res4@tiXAxisString          = res1@tiXAxisString
  res4@tiYAxisString          = labels(3)
  ;res4@xyMarker               = types(3)
  ;res5@xyLineColor            = colours(4)
  ;res5@xyMarkerColor          = colours(4)
  res5@tiMainString           = res1@tiMainString
  res5@tiXAxisString          = res1@tiXAxisString
  res5@tiYAxisString          = labels(4)
  ;res5@xyMarker               = types(4)
  ;res6@xyLineColor            = colours(5)
  ;res6@xyMarkerColor          = colours(5)
  res6@tiMainString           = res1@tiMainString
  res6@tiXAxisString          = res1@tiXAxisString
  res6@tiYAxisString          = labels(5)
  ;res6@xyMarker               = types(5)
  ;res7@xyLineColor            = colours(6)
  ;res7@xyMarkerColor          = colours(6)
  res7@tiMainString           = res1@tiMainString
  res7@tiXAxisString          = res1@tiXAxisString
  res7@tiYAxisString          = labels(6)
  ;res7@xyMarker               = types(6)
  ;res8@xyLineColor            = colours(7)
  ;res8@xyMarkerColor          = colours(7)
  res8@tiMainString           = res1@tiMainString
  res8@tiXAxisString          = res1@tiXAxisString
  res8@tiYAxisString          = labels(7)
  ;res8@xyMarker               = types(7)
  ;res9@xyLineColor            = colours(8)
  ;res9@xyMarkerColor          = colours(8)
  res9@tiMainString           = res1@tiMainString
  res9@tiXAxisString          = res1@tiXAxisString
  res9@tiYAxisString          = labels(8)
  ;res9@xyMarker               = types(8)
  ;res10@xyLineColor            = colours(9)
  ;res10@xyMarkerColor          = colours(9)
  res10@tiMainString           = res1@tiMainString
  res10@tiXAxisString          = res1@tiXAxisString
  res10@tiYAxisString          = labels(9)
  ;res10@xyMarker               = types(9)
  ;res11@xyLineColor            = colours(10)
  ;res11@xyMarkerColor          = colours(10)
  res11@tiMainString           = res1@tiMainString
  res11@tiXAxisString          = res1@tiXAxisString
  res11@tiYAxisString          = labels(10)
  ;res11@xyMarker               = types(10)
  ;res12@xyLineColor            = colours(11)
  ;res12@xyMarkerColor          = colours(11)
  res12@tiMainString           = res1@tiMainString
  res12@tiXAxisString          = res1@tiXAxisString
  res12@tiYAxisString          = labels(11)
  ;res12@xyMarker               = types(11)


  ;plot = gsn_csm_xy9(wks, time_hour_from_zero, mse_subcloud_layer_ave_hor_std, temp_500hPa_hor_std, wa_700hPa_hor_std, T2_hor_std, cape_2D_hor_std, rain_rate_hor_ave, pw_get_hor_ave, mse_subcloud_layer_ave_hor_ave, temp_500hPa_hor_ave, res1,res2,res3,res4,res5,res6,res7,res8,res9)

  ;plot123 = gsn_csm_xy3(wks,time_hour_from_zero,mse_subcloud_layer_ave_hor_std,temp_500hPa_hor_std,wa_700hPa_hor_std, res1,res2,res3)
  ;plot45  = gsn_csm_xy2(wks, time_hour_from_zero, T2_hor_std, cape_2D_hor_std, res4,res5)
  ;plot6   = gsn_csm_xy( wks, time_hour_from_zero_adapted_for_integrated_variables_shorter, rain_rate_hor_ave, res6)
  ;plot789 = gsn_csm_xy3(wks, time_hour_from_zero, pw_get_hor_ave, mse_subcloud_layer_ave_hor_ave, temp_500hPa_hor_ave, res7,res8,res9)
  ;overlay(plot123, plot45)
  ;overlay(plot123, plot6)
  ;overlay(plot123, plot789)
  
  ;printVarSummary(time_hour_from_zero)
  ;printVarSummary(mse_subcloud_layer_ave_hor_std)
  ;labels = (/" std(T_500hPa)"," std(T2)"," std(Q_500hPa)"," std(Q2)"," ave(rain rate)"," ave(CAPE)",string_pw_get_hor_ave/)
  ;labels = (/" std(T_500hPa)"," std(T2)"," std(Q_500hPa)"," std(Q2)"," ave(rain rate)"," ave(CAPE)",string_pw_get_hor_ave/)
  plot1 = gsn_csm_xy(wks, time_hour_from_zero, mse_subcloud_layer_ave_hor_std_rescaled, res1)
  plot2 = gsn_csm_xy(wks, time_hour_from_zero, wa_700hPa_hor_std_rescaled, res2)
  plot3 = gsn_csm_xy(wks, time_hour_from_zero, cape_2D_hor_std_rescaled, res3)
  plot4 = gsn_csm_xy(wks, time_hour_from_zero, temp_500hPa_hor_std_rescaled, res4)
  plot5 = gsn_csm_xy(wks, time_hour_from_zero, T2_hor_std_rescaled, res5)
  plot6 = gsn_csm_xy(wks, time_hour_from_zero, qvapor_500hPa_hor_std_rescaled, res6)
  plot7 = gsn_csm_xy(wks, time_hour_from_zero, Q2_hor_std_rescaled, res7)
  plot8 = gsn_csm_xy(wks, time_hour_from_zero, cape_2D_hor_ave_rescaled, res8)
  plot9 = gsn_csm_xy(wks, time_hour_from_zero_adapted_for_integrated_variables_shorter, rain_rate_hor_ave_rescaled, res9)
  plot10 = gsn_csm_xy(wks, time_hour_from_zero, pw_get_hor_ave_rescaled, res10)
  plot11 = gsn_csm_xy(wks, time_hour_from_zero, temp_500hPa_hor_ave_rescaled, res11)
  plot12 = gsn_csm_xy(wks, time_hour_from_zero, mse_subcloud_layer_ave_hor_ave_rescaled, res12)

  overlay(plot1,plot2)
  overlay(plot1,plot3)
  overlay(plot1,plot4)
  overlay(plot1,plot5)
  overlay(plot1,plot6)
  overlay(plot1,plot7)
  overlay(plot1,plot8)
  overlay(plot1,plot9)
  overlay(plot1,plot10)
  overlay(plot1,plot11)
  overlay(plot1,plot12)


  lgres                     = False   ;True
  ;;lgres@pmLegendDisplayMode = "Always"
  ;;lgres@pmLegendSide = "Top"
  ;;lgres@pmLegendOrthogonalPosF = -1.  ;-0.58  ;-0.02 (too high), 0.15 the same, -0.15 half box is too high
  ;;lgres@pmLegendParallelPosF = 0.4 ;.67     ; 0.2 is very good
  ;;lgres@pmLegendWidthF = 0.0425  ;0.0375
  ;;lgres@pmLegendHeightF = 0.15   ;0.28
  ;;lgres@lgLabelFontHeightF = 0.02
  ;;lgres@xyExplicitLegendLabels = (/" Before strong nudging", " During strong nudging"/)

  ;lgres@lgLineColors       = colours
  ;lgres@lgItemType         = "Lines"        ; show lines only (default)
  ;lgres@lgLabelFontHeightF = 0.2   ;0.3   ;0.12           ; legend label font thickness
  ;lgres@vpWidthF           = 0.3   ;0.13           ; width of legend (NDC)
  ;lgres@vpHeightF          = 0.5   ;0.4   ;0.20           ; height of legend (NDC)
  ;lgres@lgPerimThicknessF  = 2.0            ; thicken the box perimeter
  ;lgres@lgLineThicknessF   = 6.0   ;8.0
  ;lgres@lgMonoDashIndex    = False   ;True
  ;lgres@lgDashIndexes      = patterns

  ;nitems = dimsizes(labels)                 ; number of legend items
  ;lbid = gsn_create_legend(wks,nitems,labels,lgres)

  ;amres                  = True
  ;amres@amJust           = "BottomRight"    ; Use bottom right corner of box for determining its location.
  ;;amres@amParallelPosF   = 0.5  ;-0.08 ;-0.5  ;0.5              ; Move legend to right
  ;;amres@amOrthogonalPosF = 0.5  ;0 ;-0.5  ;0.3              ; Move legend down.
  ;amres@amParallelPosF   = -0.105  ;-0.08 ;-0.5  ;0.5              ; Move legend to right
  ;amres@amOrthogonalPosF = 0.125  ;0 ;-0.5  ;0.3              ; Move legend down.
  ;;annoid = gsn_add_annotation(plot123,lbid,amres)  ; add legend to plot
  ;annoid = gsn_add_annotation(plot1,lbid,amres)  ; add legend to plot

  psres = True                                                               
  maximize_output(wks,psres)  ; calls draw and frame for you 


  delete(colours)
  delete(thicknesses)
  delete(patterns)
  delete(labels)
  delete(wks)
  delete(lgres)
  ;delete(amres)
  delete(res1)











end

