
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
;load "./NCL_colormap/NCV_blu_red.rgb"

begin

  num_day_max = 9   ;19   ;100    ;90
  last_growth_day = 4
  NUMBER_PROF = 3
  restart_count_days = 1.                                 ; TO CHANGE    (1, 3, 5, 10, 21.5)

  month=8  ;6
  day=0
  NUMBER_EXP = num_day_max  ;9  ;1  ;9
  nb_of_members = "1"
  experiments = new((/NUMBER_EXP/),string)
  experiments_full_name = new((/NUMBER_EXP/),string)
  experiments_full_name_symbol = new((/NUMBER_EXP/),string)
  data_dir_for_plots = new((/NUMBER_EXP/),string)


  level_top_for_pbl = 9
  level_top_for_mid_tropo = 26
  level_top_for_free_tropo = 53
  level_bottom_for_high_clouds = 33


  test_directory = "test9_3D_No_strong_nudging/"                   ; TO CHANGE
  test_directory_short = "test9"                                   ; TO CHANGE
  output_dt = 15.                                                  ; TO CHANGE IF THE DELAY BETWEEN OUTPUTS CHANGES (in min)

  template_prefix = "target_prof--ncwa_Times--time_mean--fld_mean--20day_file_mean--wrfout_d01_2007-08-"
  template_suffix = "_05:00:00--selected_var"

  data_dir_for_plots(0) = "0138_Corrected_SW_solvar_faster_BIS"

  experiments_type_0 = "/compute_target_profiles/targets/"
  ;experiments_type_1 = "D_The_double_variable_impact/Analysis/more_variables/19members/compute_Ens_average_One_exp_Improved"

  data_path_0 = "/srv/ccrc/data08/z3339052/Raijin_seabreeze2d/" + test_directory + data_dir_for_plots(0) + experiments_type_0
  ;data_path_1 = "/home/z3339052/Raijin_seabreeze2d/" + test_directory + "Ensemble_averages/" + experiments_type_1

  data_path_secondary = "/srv/ccrc/data08/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging/0138_Corrected_SW_solvar_faster_BIS/compute_target_profiles/Analysis/target_profile_analysis/" + "C01_Preparing_secondary_target_variables/targets/"

  output_path = "/srv/ccrc/data08/z3339052/Raijin_seabreeze2d/test9_3D_No_strong_nudging/0138_Corrected_SW_solvar_faster_BIS/compute_target_profiles/Analysis/target_profile_analysis/C02_target_profile_analysis_without_getvar/"




  data_settings = addfile(data_path_0+ template_prefix + "01" + template_suffix,"r")
  ;xtime  = data_settings->XTIME
  p      = data_settings->P
  p_dims = dimsizes(p)
  print("p_dims is " + p_dims)
  z_dim  = p_dims(0)
  ;length_single_file = z_dim    ;dimsizes(xtime)
  ;y_dim  = p_dims(2)
  ;x_dim  = p_dims(3)
  ;print("dimsizes(xtime) is " + dimsizes(xtime))

  ;nb_of_members = tostring_with_format(num_day_max, "%0.2d")

  pw_manual_members    = new((/num_day_max/),float)
  cape_0D_members      = new((/num_day_max/),float)
  cin_0D_members       = new((/num_day_max/),float)
  LCL_members          = new((/num_day_max/),float)
  LFC_members          = new((/num_day_max/),float)
  temp_500hPa_members  = new((/num_day_max/),float)
  rh_500hPa_members    = new((/num_day_max/),float)
  mse_500hPa_members   = new((/num_day_max/),float)
  qvapor_500hPa_members = new((/num_day_max/),float)

  theta_get_subcloud_layer_ave_members = new((/num_day_max/),float)
  rh_subcloud_layer_ave_members        = new((/num_day_max/),float)
  mse_subcloud_layer_ave_members       = new((/num_day_max/),float)
  qvapor_subcloud_layer_ave_members    = new((/num_day_max/),float)
  temp_subcloud_layer_ave_members      = new((/num_day_max/),float)

  temp_members          = new((/p_dims, num_day_max/),float)
  theta_get_members     = new((/p_dims, num_day_max/),float)
  qvapor_members        = new((/p_dims, num_day_max/),float)
  rh_members            = new((/p_dims, num_day_max/),float)
  mse_members           = new((/p_dims, num_day_max/),float)
  total_density_members = new((/p_dims, num_day_max/),float)
  u_members             = new((/p_dims, num_day_max/),float)
  v_members             = new((/p_dims, num_day_max/),float)


  ;olr_hor_ave_members         = new((/num_day_max/),float)
  pw_manual_hor_ave_members   = new((/num_day_max/),float)
  pw_manual_hor_std_members   = new((/num_day_max/),float)
  ;THF_hor_ave_members         = new((/num_day_max/),float)
  ;THF_hor_std_members         = new((/num_day_max/),float)
  mse_500hPa_hor_std_members  = new((/num_day_max/),float)
  eth_500hPa_hor_std_members  = new((/num_day_max/),float)
  cape_0D_hor_ave_members     = new((/num_day_max/),float)
  cin_0D_hor_ave_members      = new((/num_day_max/),float)
  LCL_hor_ave_members         = new((/num_day_max/),float)
  LFC_hor_ave_members         = new((/num_day_max/),float)
  cldfra_hor_ave_vert_max_members  = new((/num_day_max/),float)
  temp_500hPa_hor_ave_members      = new((/num_day_max/),float)
  rh_500hPa_hor_ave_members        = new((/num_day_max/),float)
  mse_500hPa_hor_ave_members       = new((/num_day_max/),float)
  theta_get_subcloud_layer_ave_hor_ave_members  = new((/num_day_max/),float)
  rh_subcloud_layer_ave_hor_ave_members         = new((/num_day_max/),float)
  mse_subcloud_layer_ave_hor_ave_members        = new((/num_day_max/),float)
  mse_hor_std_subcloud_layer_ave_members        = new((/num_day_max/),float)
  eth_hor_std_subcloud_layer_ave_members        = new((/num_day_max/),float)
  mse_hor_std_level_0_members  = new((/num_day_max/),float)
  eth_hor_std_level_0_members  = new((/num_day_max/),float)
  cldfra_hor_ave_high_cloud_ave_members  = new((/num_day_max/),float)
  cld_cover_high_clouds_hor_ave_members  = new((/num_day_max/),float)
  rain_rate_hor_ave_members              = new((/num_day_max/),float)

  total_density_members                  = new((/z_dim,num_day_max/),float)
  total_density_hor_ave_members          = new((/z_dim,num_day_max/),float)
  total_density_hor_ave_time_ave_members = new((/z_dim,num_day_max/),float)
  TKE_2_members                          = new((/z_dim,num_day_max/),float)
  total_wind_members                     = new((/z_dim,num_day_max/),float)

  qvapor_500hPa_hor_ave_members     = new((/num_day_max/),float)
  qvapor_500hPa_hor_std_members     = new((/num_day_max/),float)
  temp_500hPa_hor_ave_members       = new((/num_day_max/),float)
  temp_500hPa_hor_std_members       = new((/num_day_max/),float)
  TKE_500hPa_hor_ave_members        = new((/num_day_max/),float)
  TKE_500hPa_hor_std_members        = new((/num_day_max/),float)
  total_wind_500hPa_hor_ave_members = new((/num_day_max/),float)
  total_wind_500hPa_hor_std_members = new((/num_day_max/),float)
  total_wind_500hPa_hor_var_members = new((/num_day_max/),float)
    
  qvapor_subcloud_layer_ave_hor_ave_members     = new((/num_day_max/),float)
  qvapor_hor_std_subcloud_layer_ave_members     = new((/num_day_max/),float)
  temp_subcloud_layer_ave_hor_ave_members       = new((/num_day_max/),float)
  temp_hor_std_subcloud_layer_ave_members       = new((/num_day_max/),float)
  total_wind_subcloud_layer_ave_hor_ave_members = new((/num_day_max/),float)
  total_wind_hor_std_subcloud_layer_ave_members = new((/num_day_max/),float)
  total_wind_hor_var_subcloud_layer_ave_members = new((/num_day_max/),float)
  TKE_2_subcloud_layer_ave_hor_ave_members      = new((/num_day_max/),float)
  TKE_2_hor_std_subcloud_layer_ave_members      = new((/num_day_max/),float)

  covar_MSE_500hPa_sub_members        = new((/num_day_max/),float)
  covar_MSE_500hPa_sub_auto_members   = new((/num_day_max/),float)
  covar_MSE_500hPa_sub_manual_members = new((/num_day_max/),float)

  ccorr_MSE_500hPa_sub_members        = new((/num_day_max/),float)
  ccorr_MSE_500hPa_sub_auto_members   = new((/num_day_max/),float)
  ccorr_MSE_500hPa_sub_manual_members = new((/num_day_max/),float)





  do num_day = 1,num_day_max

    ; LOAD THE DATA TO USE
    day = day+1
    if ((month .eq. 6) .and. (day .gt. 30)) then
      month=7
      day=1
    else if ((month .eq. 7) .and. (day .gt. 31)) then
      month=8
      day=1
    else if ((month .eq. 8) .and. (day .gt. 31) ) then
      month=9
      day=1
    end if

    end if
    end if

    mmonth = tostring_with_format(month, "%0.2d")
    dday = tostring_with_format(day, "%0.2d")
    file_name = template_prefix + dday + template_suffix ;"wrfout_d01_2007-" + mmonth + "-" + dday + "_05:00:00"
    print(" ")
    print("file_name is " + file_name)

    data = addfile(data_path_0 + "/" + file_name + ".nc","r")

    data_secondary = addfile(data_path_secondary + "/" + file_name + ".nc","r")





    ; DEFINE AND LOAD THE VARIABLES TO USE     
  
    ;xtime  = data->XTIME
    ;olr    = data->OLR
    ;cldfra = data->CLDFRA
    lev    = data->lev 
    qvapor = data->QVAPOR
    ph     = data->PH
    phb    = data->PHB
    p      = data->P
    pb     = data->PB
    ;w      = data->W
    ;LH     = data->LH
    ;HFX    = data->HFX
    u      = data->U
    v      = data->V
    ;w      = data->W
    ;rainnc = data->RAINNC
    t      = data->T
    ;density??
    ;pw_get       = wrf_user_getvar(data,"pw",-1)
    rh           = wrf_user_getvar(data,"rh",-1)
    theta_get    = wrf_user_getvar(data,"theta",-1)
    temp         = wrf_user_getvar(data,"tk",-1)
    ;eth          = wrf_user_getvar(data,"eth",-1)
    ;cape_WRF     = wrf_user_getvar(data,"cape_3d",-1)
    ;cape_2D_all  = wrf_user_getvar(data,"cape_2d",-1)
    ;z_get        = wrf_user_getvar(data,"z",-1)
    ;ua           = wrf_user_getvar(data,"ua",-1)
    ;va           = wrf_user_getvar(data,"va",-1)
    ;wa           = wrf_user_getvar(data,"wa",-1)

    hgt      = data_secondary->HGT
    psfc     = data_secondary->PSFC

    rh!0   = "lev"
    rh&lev = lev
    printVarSummary(rh)
    p_dims = dimsizes(p)
    ;z_dim  = p_dims(1)
    ;y_dim  = p_dims(2)
    ;x_dim  = p_dims(3)

    sizes_temp     = dimsizes(temp)
    time_size_temp = sizes_temp(0)
    print("time_size_temp is "+ time_size_temp)


    ; COMPUTE MORE MANUALLY THE VARIABLES THAT CANNOT WORK WITH wrf_user_getvar BECAUSE OF THE 1D FEATURE

    ; PW

    gas_const = 287.  ; J/K/kg
    Cp_air    = 1004. ; J/K/kg     

    pres   =  p + pb
    height = (ph + phb)/9.8           ; height at full levels 
    theta  =  t + 300.
    temp_manual   = theta * (pres/100000) ^ (gas_const/Cp_air)
    vtemp  = (1 + 0.61*qvapor) * temp_manual  ; virtual temp

    t_dims = dimsizes(t)
    nd = dimsizes(t_dims)
       
    zdiff  = 0.
    pw_sfc_ptop_manual = 0.
    do k = 0,t_dims-1
        zdiff = (height(k+1) - height(k))
        pw_sfc_ptop_manual =  pw_sfc_ptop_manual + ((pres(k)/(gas_const * vtemp(k))) * qvapor(k) * zdiff)
    end do
    pw_manual = pw_sfc_ptop_manual

    ; CAPE

    ph_tot_3d        = new((/t_dims+1,1,1/),float)
    ph_tot_unstag_1d = new((/t_dims/),float)
    pres_3d          = new((/t_dims,1,1/),float)
    temp_3d          = new((/t_dims,1,1/),float)
    qvapor_3d        = new((/t_dims,1,1/),float)
    cape_by_fct_0d   = new((/4/),float)
    hgt_2d           = new((/1,1/),float)
    psfc_hPa_2d      = new((/1,1/),float)
    z_from_ph_tot_1d = new((/t_dims/),float)

    pres_3d(:,0,0)   = pres(:)
    temp_3d(:,0,0)   = temp(:)
    qvapor_3d(:,0,0) = qvapor(:)
    hgt_2d(0,0)      = hgt

    ph_tot   = ph + phb
    psfc_hPa = psfc / 100.
    psfc_hPa_2d(0,0) = psfc_hPa
    ph_tot_3d(:,0,0) = ph_tot(:)
    ph_tot_3d!0 = "Z"
    ph_tot_3d!1 = "Y"
    ph_tot_3d!2 = "X"
    ph_tot_3d_unstag = wrf_user_unstagger(ph_tot_3d,"Z")
    z_from_ph_tot_3d = ph_tot_3d_unstag/9.81
    z_from_ph_tot_1d(:) = z_from_ph_tot_3d(:,0,0)

    cape_by_fct = wrf_cape_2d( pres_3d, temp_3d, qvapor_3d, z_from_ph_tot_3d, hgt_2d, psfc_hPa_2d, True )
    copy_VarAtts_except(t,cape_by_fct,(/"MemoryOrder","description","units"/))
    cape_by_fct@MemoryOrder = "XY"
    cape_by_fct@description = "mcape ; mcin ; lcl ; lfc"
    printVarSummary(cape_by_fct)

    ;cape_by_fct_0d(:) = cape_by_fct(:,0,0)





    ; COMPUTE RELATED VARIABLES

    gravity = 9.81        
    Lvap    = 2.5e6  
    Cp_air  = 1004.
    R_d = 287.
    epsilon = 0.622

    ;cape = cape_WRF(0,:,:,:,:)
    ;cin  = cape_WRF(1,:,:,:,:)

    cape_0D = cape_by_fct(0,0,0)
    cin_0D  = cape_by_fct(1,0,0)
    LCL     = cape_by_fct(2,0,0)
    LFC     = cape_by_fct(3,0,0)  

    ;mse = temp                               ; trick to keep cv's
    ;mse = Cp_air*temp + gravity*z_get + Lvap*qvapor
    mse = Cp_air*temp + gravity*z_from_ph_tot_1d + Lvap*qvapor

    ;THF = LH + HFX  ; Total Heat Flux

    printVarSummary(phb)
    printVarSummary(z_from_ph_tot_1d)
    printVarSummary(mse)

    total_p = p + pb
    printVarSummary(total_p)

    R_prime = R_d * ( 1 + (1./epsilon -1)*qvapor )
    total_density = 1.0 * total_p / (R_prime * temp)
    printVarSummary(total_density)
    print("total_density(:) " + total_density(:))


    ; ANALYSE THE VARIABLES

    ;printVarSummary(pw_manual)
    ;;olr_hor_ave     = dim_avg(dim_avg(olr))
    ;pw_manual_hor_ave  = dim_avg(dim_avg(pw_manual))

    ;pw_manual_hor_std  = dim_stddev_n( pw_manual, (/1,2/) )
    ;;THF_hor_ave     = dim_avg(dim_avg(THF))
    ;;THF_hor_std     = dim_stddev_n( THF, (/1,2/) )

    ;mse_hor_std = dim_stddev_n( mse, (/2,3/) )
    ;eth_hor_std = dim_stddev_n( eth, (/2,3/) )

    ;cape_0D_hor_ave = dim_avg(dim_avg(cape_0D))
    ;cin_0D_hor_ave  = dim_avg(dim_avg(cin_0D))
    ;LCL_hor_ave = dim_avg(dim_avg(LCL))
    ;LFC_hor_ave = dim_avg(dim_avg(LFC))

    ;cldfra_hor_ave = dim_avg(dim_avg(cldfra))
    ;printVarSummary(cldfra_hor_ave)
    ;cldfra_hor_ave_vert_max = dim_max(cldfra_hor_ave)

    ;total_density_hor_ave = dim_avg(dim_avg(total_density))
    ;total_density_hor_ave_time_ave = dim_avg_n(total_density_hor_ave, 0)
    ;printVarSummary(total_density_hor_ave_time_ave)
    ;print("total_density_hor_ave_time_ave " + total_density_hor_ave_time_ave)

    ;qvapor_hor_std = dim_stddev_n( qvapor, (/2,3/) )
    ;temp_hor_std = dim_stddev_n( temp, (/2,3/) )



    ; COMPUTE WIND-RELATED VARIABLES



    ; INTERPOLATION AT 500hPa

    total_p_hPa = total_p * 0.01

    rh_3d          = new((/t_dims,1,1/),float)
    mse_3d         = new((/t_dims,1,1/),float)
    total_p_hPa_3d = new((/t_dims,1,1/),float)
    rh_3d(:,0,0)   = rh(:)
    mse_3d(:,0,0)  = mse(:)
    total_p_hPa_3d(:,0,0) = total_p_hPa(:)

    temp_500hPa = wrf_interp_3d_z(temp_3d,total_p_hPa_3d,500.)
    printVarSummary(temp_500hPa)
    ;temp_500hPa_hor_ave = dim_avg(dim_avg(temp_500hPa))
    ;printVarSummary(temp_500hPa_hor_ave)

    rh_500hPa = wrf_interp_3d_z(rh_3d,total_p_hPa_3d,500.)
    ;rh_500hPa_hor_ave = dim_avg(dim_avg(rh_500hPa))

    mse_500hPa = wrf_interp_3d_z(mse_3d,total_p_hPa_3d,500.)
    ;mse_500hPa_hor_ave = dim_avg(dim_avg(mse_500hPa))
    ;mse_500hPa_hor_std = dim_stddev_n( mse_500hPa, (/1,2/) )

    ;eth_500hPa = wrf_interp_3d_z(eth,total_p_hPa,500.)
    ;eth_500hPa_hor_std = dim_stddev_n( eth_500hPa, (/1,2/) )
    ;printVarSummary(eth_500hPa_hor_std)

    qvapor_500hPa = wrf_interp_3d_z(qvapor_3d,total_p_hPa_3d,500.)
    ;qvapor_500hPa_hor_ave = dim_avg(dim_avg(qvapor_500hPa))
    ;qvapor_500hPa_hor_std = dim_stddev_n( qvapor_500hPa, (/1,2/) )

    ;temp_500hPa = wrf_interp_3d_z(temp,total_p_hPa,500.)
    ;temp_500hPa_hor_ave = dim_avg(dim_avg(temp_500hPa))
    ;temp_500hPa_hor_std = dim_stddev_n( temp_500hPa, (/1,2/) ) 

    ;ua_500hPa = wrf_interp_3d_z(ua,total_p_hPa,500.)
    ;va_500hPa = wrf_interp_3d_z(va,total_p_hPa,500.)
    ;wa_500hPa = wrf_interp_3d_z(wa,total_p_hPa,500.)
    ;ua_500hPa_hor_ave = dim_avg(dim_avg(ua_500hPa))
    ;va_500hPa_hor_ave = dim_avg(dim_avg(va_500hPa))
    ;wa_500hPa_hor_ave = dim_avg(dim_avg(wa_500hPa))
    ;ua_500hPa_hor_ave_resized = conform_dims (dimsizes(ua_500hPa),ua_500hPa_hor_ave,(/0/))
    ;va_500hPa_hor_ave_resized = conform_dims (dimsizes(va_500hPa),va_500hPa_hor_ave,(/0/))
    ;wa_500hPa_hor_ave_resized = conform_dims (dimsizes(wa_500hPa),wa_500hPa_hor_ave,(/0/))

    ;TKE_500hPa = 0.5 * ( (ua_500hPa - ua_500hPa_hor_ave_resized)^2 + (va_500hPa - va_500hPa_hor_ave_resized)^2 + (wa_500hPa - wa_500hPa_hor_ave_resized)^2 )
    ;TKE_500hPa_hor_ave = dim_avg(dim_avg(TKE_500hPa))
    ;TKE_500hPa_hor_std = dim_stddev_n( TKE_500hPa, (/1,2/) )

    ;total_wind_500hPa = sqrt(ua_500hPa^2 + va_500hPa^2 + wa_500hPa^2)
    ;total_wind_500hPa_hor_ave = dim_avg(dim_avg(total_wind_500hPa))
    ;total_wind_500hPa_hor_std = dim_stddev_n( total_wind_500hPa, (/1,2/) )
    ;total_wind_500hPa_hor_var = dim_variance_n( total_wind_500hPa, (/1,2/) )


    ; AVERAGE OVER THE SUB-CLOUD LAYER (~PBL)

    wgt_subcloud_layer = new((/z_dim/),float)
    do level = 0, z_dim-1
        if (level .le. level_top_for_pbl) then
            wgt_subcloud_layer(level) = 1.*total_density(level)
        else
            wgt_subcloud_layer(level) = 0.
        end if
    end do
    print("wgt_subcloud_layer is " + wgt_subcloud_layer)

    theta_get_subcloud_layer_ave = dim_avg_wgt_n( theta_get, wgt_subcloud_layer, 0, 0 )
    rh_subcloud_layer_ave        = dim_avg_wgt_n( rh, wgt_subcloud_layer, 0, 0 )
    mse_subcloud_layer_ave       = dim_avg_wgt_n( mse, wgt_subcloud_layer, 0, 0 )
    qvapor_subcloud_layer_ave    = dim_avg_wgt_n( qvapor, wgt_subcloud_layer, 0, 0 )
    temp_subcloud_layer_ave       = dim_avg_wgt_n( temp, wgt_subcloud_layer, 0, 0 )

    ;theta_get_subcloud_layer_ave_hor_ave = dim_avg(dim_avg(theta_get_subcloud_layer_ave))
    ;rh_subcloud_layer_ave_hor_ave        = dim_avg(dim_avg(rh_subcloud_layer_ave))
    ;mse_subcloud_layer_ave_hor_ave       = dim_avg(dim_avg(mse_subcloud_layer_ave))
    ;mse_subcloud_layer_ave_hor_std       = dim_stddev_n( mse_subcloud_layer_ave, (/1,2/) )

    ;mse_hor_std_subcloud_layer_ave = dim_avg_wgt_n( mse_hor_std, wgt_subcloud_layer, 0, 1 )
    ;eth_hor_std_subcloud_layer_ave = dim_avg_wgt_n( eth_hor_std, wgt_subcloud_layer, 0, 1 )

    ;qvapor_subcloud_layer_ave = dim_avg_wgt_n( qvapor, wgt_subcloud_layer, 0, 1 )
    ;qvapor_subcloud_layer_ave_hor_ave = dim_avg(dim_avg(qvapor_subcloud_layer_ave))
    ;qvapor_hor_std_subcloud_layer_ave = dim_avg_wgt_n( qvapor_hor_std , wgt_subcloud_layer, 0, 1 )

    ;temp_subcloud_layer_ave = dim_avg_wgt_n( temp, wgt_subcloud_layer, 0, 1 )
    ;temp_subcloud_layer_ave_hor_ave = dim_avg(dim_avg(temp_subcloud_layer_ave))
    ;temp_hor_std_subcloud_layer_ave = dim_avg_wgt_n( temp_hor_std , wgt_subcloud_layer, 0, 1 )

    ;total_wind_subcloud_layer_ave = dim_avg_wgt_n( total_wind, wgt_subcloud_layer, 0, 1 )
    ;total_wind_subcloud_layer_ave_hor_ave = dim_avg(dim_avg(total_wind_subcloud_layer_ave))
    ;total_wind_hor_std_subcloud_layer_ave = dim_avg_wgt_n( total_wind_hor_std , wgt_subcloud_layer, 0, 1 )
    ;total_wind_hor_var_subcloud_layer_ave = dim_avg_wgt_n( total_wind_hor_var , wgt_subcloud_layer, 0, 1 )

    ;TKE_2_subcloud_layer_ave = dim_avg_wgt_n( TKE_2, wgt_subcloud_layer, 0, 1 )
    ;TKE_2_subcloud_layer_ave_hor_ave = dim_avg(dim_avg(TKE_2_subcloud_layer_ave))
    ;TKE_2_hor_std_subcloud_layer_ave = dim_avg_wgt_n( TKE_2_hor_std , wgt_subcloud_layer, 0, 1 )


    ; COVARIANCE OF MSE AT 500hPa AND MSE IN SUB-CLOUD LAYER

    ;covar_MSE_500hPa_sub = new((/time_size_temp/),float)
    ;ccorr_MSE_500hPa_sub = new((/time_size_temp/),float)
    ;do time_ind = 0, time_size_temp-1
    ;    mse_500hPa_now_reshaped = reshape(mse_500hPa(time_ind,:,:), (/y_dim*x_dim/))
    ;    mse_subcloud_layer_ave_now_reshaped = reshape(mse_subcloud_layer_ave(time_ind,:,:), (/y_dim*x_dim/))
    ;    covar_MSE_500hPa_sub(time_ind) = escovc(mse_500hPa_now_reshaped, mse_subcloud_layer_ave_now_reshaped)
    ;    ccorr_MSE_500hPa_sub(time_ind) = esccr(mse_500hPa_now_reshaped, mse_subcloud_layer_ave_now_reshaped, 0)
    ;end do
    ;printVarSummary(covar_MSE_500hPa_sub)
    ;printVarSummary(ccorr_MSE_500hPa_sub)
    ;print("covar_MSE_500hPa_sub " + covar_MSE_500hPa_sub)
    ;print("ccorr_MSE_500hPa_sub(0) " + ccorr_MSE_500hPa_sub(0))

    ;mse_500hPa_reshaped = reshape( mse_500hPa, (/time_size_temp, y_dim*x_dim/) )
    ;mse_subcloud_layer_ave_reshaped = reshape( mse_subcloud_layer_ave, (/time_size_temp, y_dim*x_dim/) )
    ;covar_MSE_500hPa_sub_auto = escovc(mse_500hPa_reshaped,mse_subcloud_layer_ave_reshaped)
    ;ccorr_MSE_500hPa_sub_auto_clumsy = esccr(mse_500hPa_reshaped,mse_subcloud_layer_ave_reshaped, 0)
    ;ccorr_MSE_500hPa_sub_auto = ccorr_MSE_500hPa_sub_auto_clumsy(:,0)
    ;printVarSummary(covar_MSE_500hPa_sub_auto)
    ;print("covar_MSE_500hPa_sub_auto " + covar_MSE_500hPa_sub_auto)
    ;printVarSummary(ccorr_MSE_500hPa_sub_auto)
    ;print("ccorr_MSE_500hPa_sub_auto " + ccorr_MSE_500hPa_sub_auto)

    ;if ( any( covar_MSE_500hPa_sub_auto .ne. covar_MSE_500hPa_sub ) ) then
    ;    print("ERROR: The two ways of calculating covariance do not give the same results: normal and auto")
    ;end if
    ;if ( any( ccorr_MSE_500hPa_sub_auto .ne. ccorr_MSE_500hPa_sub ) ) then
    ;    print("ERROR: The two ways of calculating cross-correlation do not give the same results: normal and auto")
    ;end if

    ;covar_MSE_500hPa_sub_manual = new((/time_size_temp/),float)
    ;ccorr_MSE_500hPa_sub_manual = new((/time_size_temp/),float)
    ;do time_ind = 0, time_size_temp-1
    ;    sum_here = 0.
    ;    count_here = 0.
    ;    do y_ind = 0,y_dim-1
    ;        do x_ind = 0,x_dim-1
    ;            diff_mse_500hPa = mse_500hPa(time_ind,y_ind,x_ind)-mse_500hPa_hor_ave(time_ind)
    ;            diff_mse_subcloud_layer_ave = mse_subcloud_layer_ave(time_ind,y_ind,x_ind)-mse_subcloud_layer_ave_hor_ave(time_ind)
    ;            sum_here = sum_here + diff_mse_500hPa * diff_mse_subcloud_layer_ave
    ;            count_here = count_here + 1.
    ;        end do
    ;    end do
    ;    covar_MSE_500hPa_sub_manual(time_ind) = sum_here * 1.0 / (count_here-1)
    ;    ccorr_MSE_500hPa_sub_manual(time_ind) = sum_here * 1.0 / (mse_500hPa_hor_std(time_ind) * mse_subcloud_layer_ave_hor_std(time_ind) * (count_here-1))
    ;end do
    ;printVarSummary(covar_MSE_500hPa_sub_manual)
    ;print("covar_MSE_500hPa_sub_manual " + covar_MSE_500hPa_sub_manual)
    ;printVarSummary(ccorr_MSE_500hPa_sub_manual)
    ;print("ccorr_MSE_500hPa_sub_manual " + ccorr_MSE_500hPa_sub_manual)
    ;print("ccorr_MSE_500hPa_sub " + ccorr_MSE_500hPa_sub)
    ;print("mse_500hPa_hor_std " + mse_500hPa_hor_std)
    ;print("mse_subcloud_layer_ave_hor_std " + mse_subcloud_layer_ave_hor_std) 
    ;print("sum_here " + sum_here)
    ;print("count_here " + count_here)

    ;if ( any(covar_MSE_500hPa_sub_manual .ne. covar_MSE_500hPa_sub) ) then
    ;    print("ERROR: The two ways of calculating covariance do not give the same results: normal and manual")
    ;    diff_covar = covar_MSE_500hPa_sub_manual-covar_MSE_500hPa_sub
    ;    print("The difference: covar_MSE_500hPa_sub_manual-covar_MSE_500hPa_sub " + diff_covar)
    ;    print("")
    ;end if
    ;if ( any( ccorr_MSE_500hPa_sub_manual .ne. ccorr_MSE_500hPa_sub ) ) then
    ;    print("ERROR: The two ways of calculating cross-correlation do not give the same results: normal and manual")
    ;    diff_ccorr = ccorr_MSE_500hPa_sub_manual-ccorr_MSE_500hPa_sub
    ;    print("The difference: ccorr_MSE_500hPa_sub_manual-ccorr_MSE_500hPa_sub " + diff_ccorr)
    ;    print("")
    ;end if




    ; SURFACE FIELDS

    ;mse_hor_std_level_0 = mse_hor_std(:,0)
    ;eth_hor_std_level_0 = eth_hor_std(:,0)

  
    ; HIGH CLOUD FRACTION

    ;wgt_high_cloud_layer = new((/z_dim/),float)
    ;do level = 0, z_dim-1
    ;    if ((level .le. level_top_for_free_tropo) .and. (level .ge. level_bottom_for_high_clouds)) then
    ;        wgt_high_cloud_layer(level) = 1.
    ;    else
    ;        wgt_high_cloud_layer(level) = 0.
    ;    end if
    ;end do
    ;print("wgt_high_cloud_layer is " + wgt_high_cloud_layer)

    ;cldfra_hor_ave_high_cloud_ave = dim_avg_wgt_n( cldfra_hor_ave, wgt_high_cloud_layer, 0, 1 )

    ;cld_cover_high_clouds = new((/time_size_temp, y_dim, x_dim/),float)
    ;do x_val = 0, x_dim-1
    ;    do y_val = 0, y_dim-1
    ;        my_sum_cldfra = new((/time_size_temp/),float)
    ;        my_sum_cldfra = 0.
    ;        do level = level_bottom_for_high_clouds, level_top_for_free_tropo
    ;            my_sum_cldfra(:) = my_sum_cldfra(:) + cldfra(:,level,y_val,x_val)
    ;        end do
    ;        cld_cover_high_clouds(:,y_val,x_val) = my_sum_cldfra(:)
    ;    end do
    ;end do
    ;cld_cover_high_clouds_corrected = where(cld_cover_high_clouds .le. 1. , cld_cover_high_clouds , 1.)
    ;printVarSummary(cld_cover_high_clouds_corrected)

    ;cld_cover_high_clouds_hor_ave = dim_avg(dim_avg(cld_cover_high_clouds_corrected))



    ; RAIN RATE

    ;printVarSummary(rainnc)
    ;print("length_single_file " + length_single_file)
    ;print("y_dim " + y_dim)
    ;print("x_dim " + x_dim)
    ;rainnc_dims = dimsizes(rainnc)
    ;if ( (rainnc_dims(0) .ne. length_single_file) .or. (rainnc_dims(1) .ne. y_dim) .or. (rainnc_dims(2) .ne. x_dim)  ) then
    ;    print("Error: dimsizes(rainnc) and dimsizes(p) are different!!")
    ;end if

    ;rain_rate = new((/length_single_file-1,y_dim,x_dim/),float)                             ; CAUTION: IT IS NOT CLEAN HERE AS WE WILL HAVE A 0 AT THE END. WE HAVE TO DECREASE THE FIRST DIMENSION OF RAIN_RATE BY 1.
    ;do n=0, length_single_file-2
    ;  rain_rate(n,:,:) = (rainnc(n+1,:,:)-rainnc(n,:,:))*60./output_dt
    ;end do
    ;;rain_rate(length_single_file-1,:,:)= (rainnc_second_day(0,:,:) - rainnc(length_single_file-1,:,:))*60./output_dt
    ;printVarSummary(rain_rate)
  
    ;rain_rate_hor_ave = dim_avg(dim_avg(rain_rate))
    ;printVarSummary(rain_rate_hor_ave)
  



    ; SAVE ALL THE AVERAGES FOR EACH MEMBER (i.e. FOR EACH DAY)

    printVarSummary(temp_500hPa_members)
    ;olr_hor_ave_members(:,num_day-1)    = olr_hor_ave(:)
    pw_manual_members(num_day-1) = pw_manual
    ;pw_manual_hor_std_members(:,num_day-1) = pw_manual_hor_std(:)
    ;THF_hor_ave_members(:,num_day-1)    = THF_hor_ave(:)
    ;THF_hor_std_members(:,num_day-1)    = THF_hor_std(:)
    cape_0D_members(num_day-1)  = cape_0D
    cin_0D_members(num_day-1)   = cin_0D
    LCL_members(num_day-1)      = LCL
    LFC_members(num_day-1)      = LFC
    ;cldfra_hor_ave_vert_max_members(:,num_day-1)   = cldfra_hor_ave_vert_max(:)
    temp_500hPa_members(num_day-1)       = temp_500hPa(0,0)
    rh_500hPa_members(num_day-1)         = rh_500hPa(0,0)
    mse_500hPa_members(num_day-1)        = mse_500hPa(0,0)
    ;eth_500hPa_members(num_day-1)        = eth_500hPa(0,0)
    theta_get_subcloud_layer_ave_members(num_day-1)   = theta_get_subcloud_layer_ave
    rh_subcloud_layer_ave_members(num_day-1)          = rh_subcloud_layer_ave
    mse_subcloud_layer_ave_members(num_day-1)         = mse_subcloud_layer_ave
    ;mse_hor_std_subcloud_layer_ave_members(:,num_day-1)         = mse_hor_std_subcloud_layer_ave(:)
    ;eth_hor_std_subcloud_layer_ave_members(:,num_day-1)         = eth_hor_std_subcloud_layer_ave(:)
    ;mse_hor_std_level_0_members(:,num_day-1)   = mse_hor_std_level_0(:)
    ;eth_hor_std_level_0_members(:,num_day-1)   = eth_hor_std_level_0(:)
    ;cldfra_hor_ave_high_cloud_ave_members(:,num_day-1)   = cldfra_hor_ave_high_cloud_ave(:)
    ;cld_cover_high_clouds_hor_ave_members(:,num_day-1)   = cld_cover_high_clouds_hor_ave(:)
    ;rain_rate_hor_ave_members(:,num_day-1)               = rain_rate_hor_ave(:)

    temp_members(:,num_day-1)            = temp(:)
    theta_get_members(:,num_day-1)       = theta_get(:)
    qvapor_members(:,num_day-1)          = qvapor(:)
    rh_members(:,num_day-1)              = rh(:)
    mse_members(:,num_day-1)             = mse(:)
    total_density_members(:,num_day-1)   = total_density(:)
    u_members(:,num_day-1)               = u(:)
    v_members(:,num_day-1)               = v(:)
    ;total_density_hor_ave_members(:,:,num_day-1)        = total_density_hor_ave(:,:)
    ;total_density_hor_ave_time_ave_members(:,num_day-1) = total_density_hor_ave_time_ave(:)
    ;TKE_2_members(:,:,:,:,num_day-1)                    = TKE_2(:,:,:,:)
    ;total_wind_members(:,:,:,:,num_day-1)               = total_wind(:,:,:,:)

    qvapor_500hPa_members(num_day-1)     = qvapor_500hPa(0,0)
    ;qvapor_500hPa_hor_std_members(:,num_day-1)     = qvapor_500hPa_hor_std(:)
    ;temp_500hPa_members(num_day-1)       = temp_500hPa
    ;temp_500hPa_hor_std_members(:,num_day-1)       = temp_500hPa_hor_std(:)
    ;TKE_500hPa_hor_ave_members(:,num_day-1)        = TKE_500hPa_hor_ave(:)
    ;TKE_500hPa_hor_std_members(:,num_day-1)        = TKE_500hPa_hor_std(:)
    ;total_wind_500hPa_hor_ave_members(:,num_day-1) = total_wind_500hPa_hor_ave(:)
    ;total_wind_500hPa_hor_std_members(:,num_day-1) = total_wind_500hPa_hor_std(:)
    ;total_wind_500hPa_hor_var_members(:,num_day-1) = total_wind_500hPa_hor_var(:)

    qvapor_subcloud_layer_ave_members(num_day-1)     = qvapor_subcloud_layer_ave
    ;qvapor_hor_std_subcloud_layer_ave_members(:,num_day-1)     = qvapor_hor_std_subcloud_layer_ave(:)
    temp_subcloud_layer_ave_members(num_day-1)       = temp_subcloud_layer_ave
    ;temp_hor_std_subcloud_layer_ave_members(:,num_day-1)       = temp_hor_std_subcloud_layer_ave(:)
    ;total_wind_subcloud_layer_ave_hor_ave_members(:,num_day-1) = total_wind_subcloud_layer_ave_hor_ave(:)
    ;total_wind_hor_std_subcloud_layer_ave_members(:,num_day-1) = total_wind_hor_std_subcloud_layer_ave(:)
    ;total_wind_hor_var_subcloud_layer_ave_members(:,num_day-1) = total_wind_hor_var_subcloud_layer_ave(:)
    ;TKE_2_subcloud_layer_ave_hor_ave_members(:,num_day-1)      = TKE_2_subcloud_layer_ave_hor_ave(:)
    ;TKE_2_hor_std_subcloud_layer_ave_members(:,num_day-1)      = TKE_2_hor_std_subcloud_layer_ave(:)

    ;covar_MSE_500hPa_sub_members(:,num_day-1)        = covar_MSE_500hPa_sub(:)
    ;covar_MSE_500hPa_sub_auto_members(:,num_day-1)   = covar_MSE_500hPa_sub_auto(:)
    ;covar_MSE_500hPa_sub_manual_members(:,num_day-1) = covar_MSE_500hPa_sub_manual(:)

    ;ccorr_MSE_500hPa_sub_members(:,num_day-1)        = ccorr_MSE_500hPa_sub(:)
    ;ccorr_MSE_500hPa_sub_auto_members(:,num_day-1)   = ccorr_MSE_500hPa_sub_auto(:)
    ;ccorr_MSE_500hPa_sub_manual_members(:,num_day-1) = ccorr_MSE_500hPa_sub_manual(:)



    ; DEFINE THE TIME AXIS IN A CONVENIENT WAY


    ;time_hour = xtime/60.
    ;time_day = time_hour/24.
    ;if (num_day .eq. 1) then
    ;    time_day_ref = time_day
    ;end if

    ;print("time_hour is " + time_hour)
    ;time_hour_from_zero = time_hour - 24*(61+restart_count_days-1)
    ;print("time_hour_from_zero is " + time_hour_from_zero)
    ;time_hour_from_local_time = time_hour_from_zero + 5.
    ;time_hour_from_local_time_adapted_for_integrated_variables = time_hour_from_local_time + (output_dt/2.)/60. ; TRUE IF THE OUTPUT TIME STEP IS EVERY output_dt MIN!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

    ;time_size = dimsizes(time_hour_from_local_time_adapted_for_integrated_variables)
    ;print("dimsizes(time_hour_from_local_time_adapted_for_integrated_variables) " + dimsizes(time_hour_from_local_time_adapted_for_integrated_variables))
    ;time_hour_from_local_time_adapted_for_integrated_variables_shorter = new((/time_size - 1/),float)
    ;do n=0, time_size - 2
    ;  time_hour_from_local_time_adapted_for_integrated_variables_shorter(n) = time_hour_from_local_time_adapted_for_integrated_variables(n)
    ;end do
    ;print("dimsizes(time_hour_from_local_time_adapted_for_integrated_variables_shorter) " + dimsizes(time_hour_from_local_time_adapted_for_integrated_variables_shorter))

    ;time_hour_from_zero_adapted_for_integrated_variables = time_hour_from_zero + (output_dt/2.)/60.

    ;;print("time_hour " + time_hour)

    ;;if (all(time_day(:) .eq. time_day_ref(:))) then
    ;;  print("x-axis for day number " + num_day + " OK")
    ;;else
    ;;  print("x-axis for day number " + num_day + " ERROR: the x-axes for the two curves do not match")
    ;;end if





  end do




  ; COMPUTE THE MEMBER AVERAGE (AVERAGE OVER DIFFERENT DAYS)

  ;printVarSummary(olr_hor_ave_members)
  ;print("olr_hor_ave_members(0,0) is " + olr_hor_ave_members(0,0))


  pw_manual_members_ave = dim_avg( pw_manual_members )
  cape_0D_members_ave = dim_avg( cape_0D_members )
  cin_0D_members_ave = dim_avg( cin_0D_members )
  LCL_members_ave = dim_avg( LCL_members )
  LFC_members_ave = dim_avg( LFC_members )
  temp_500hPa_members_ave = dim_avg( temp_500hPa_members )
  rh_500hPa_members_ave = dim_avg( rh_500hPa_members )
  mse_500hPa_members_ave = dim_avg( mse_500hPa_members )
  qvapor_500hPa_members_ave = dim_avg( qvapor_500hPa_members )

  theta_get_subcloud_layer_ave_members_ave = dim_avg( theta_get_subcloud_layer_ave_members )
  rh_subcloud_layer_ave_members_ave = dim_avg( rh_subcloud_layer_ave_members )
  mse_subcloud_layer_ave_members_ave = dim_avg( mse_subcloud_layer_ave_members )
  qvapor_subcloud_layer_ave_members_ave = dim_avg( qvapor_subcloud_layer_ave_members )
  temp_subcloud_layer_ave_members_ave = dim_avg( temp_subcloud_layer_ave_members )

  temp_members_ave = dim_avg( temp_members )
  theta_get_members_ave = dim_avg( theta_get_members )
  qvapor_members_ave = dim_avg( qvapor_members )
  rh_members_ave = dim_avg( rh_members )
  mse_members_ave = dim_avg( mse_members )
  total_density_members_ave = dim_avg( total_density_members )
  u_members_ave = dim_avg( u_members )
  v_members_ave = dim_avg( v_members )








  ; OUTPUTTING NETCDF FILES, IN CASE PLOTTING FAILS
  filename = output_path + "target_profiles_analysis_output_" + test_directory_short + "_" + data_dir_for_plots(0) + "_" + "_v1.nc"
  print("filename is " + filename)
  system("/bin/rm -f " + filename) ; remove any pre-existing file
  setfileoption("nc","Format","NetCDF4Classic")
  ncdf = addfile(filename,"c") ; open output netCDF file


  ncdf->pw_manual_members                        = pw_manual_members
  ncdf->cape_0D_members                          = cape_0D_members
  ncdf->cin_0D_members                           = cin_0D_members
  ncdf->LCL_members                              = LCL_members
  ncdf->LFC_members                              = LFC_members
  ncdf->temp_500hPa_members                      = temp_500hPa_members
  ncdf->rh_500hPa_members                        = rh_500hPa_members
  ncdf->mse_500hPa_members                       = mse_500hPa_members
  ncdf->qvapor_500hPa_members                    = qvapor_500hPa_members

  ncdf->theta_get_subcloud_layer_ave_members     = theta_get_subcloud_layer_ave_members
  ncdf->rh_subcloud_layer_ave_members            = rh_subcloud_layer_ave_members
  ncdf->mse_subcloud_layer_ave_members           = mse_subcloud_layer_ave_members
  ncdf->qvapor_subcloud_layer_ave_members        = qvapor_subcloud_layer_ave_members
  ncdf->temp_subcloud_layer_ave_members          = temp_subcloud_layer_ave_members

  ncdf->temp_members                             = temp_members
  ncdf->theta_get_members                        = theta_get_members
  ncdf->qvapor_members                           = qvapor_members
  printVarSummary(qvapor_members)
  printVarSummary(rh_members)
  ncdf->rh_members                               = rh_members
  ncdf->mse_members                              = mse_members
  ncdf->total_density_members                    = total_density_members
  ncdf->u_members                                = u_members
  ncdf->v_members                                = v_members



  ncdf->pw_manual_members_ave                        = pw_manual_members_ave
  ncdf->cape_0D_members_ave                          = cape_0D_members_ave
  ncdf->cin_0D_members_ave                           = cin_0D_members_ave
  ncdf->LCL_members_ave                              = LCL_members_ave
  ncdf->LFC_members_ave                              = LFC_members_ave
  ncdf->temp_500hPa_members_ave                      = temp_500hPa_members_ave
  ncdf->rh_500hPa_members_ave                        = rh_500hPa_members_ave
  ncdf->mse_500hPa_members_ave                       = mse_500hPa_members_ave
  ncdf->qvapor_500hPa_members_ave                    = qvapor_500hPa_members_ave

  ncdf->theta_get_subcloud_layer_ave_members_ave     = theta_get_subcloud_layer_ave_members_ave
  ncdf->rh_subcloud_layer_ave_members_ave            = rh_subcloud_layer_ave_members_ave
  ncdf->mse_subcloud_layer_ave_members_ave           = mse_subcloud_layer_ave_members_ave
  ncdf->qvapor_subcloud_layer_ave_members_ave        = qvapor_subcloud_layer_ave_members_ave
  ncdf->temp_subcloud_layer_ave_members_ave          = temp_subcloud_layer_ave_members_ave

  ncdf->temp_members_ave                             = temp_members_ave
  ncdf->theta_get_members_ave                        = theta_get_members_ave
  ncdf->qvapor_members_ave                           = qvapor_members_ave
  ncdf->rh_members_ave                               = rh_members_ave
  ncdf->mse_members_ave                              = mse_members_ave
  ncdf->total_density_members_ave                    = total_density_members_ave
  ncdf->u_members_ave                                = u_members_ave
  ncdf->v_members_ave                                = v_members_ave




  ; PREPARE THE STATS

  printVarSummary(pw_manual_members_ave)
  print("pw_manual_members(0:last_growth_day-1) is " + pw_manual_members(0:last_growth_day-1))

  variable_string_list = (/"PW                  ","CAPE                ","CIN                 ","LCL                 ","LFC                 ","temp_500hPa         ","rh_500hPa           ","mse_500hPa          ","qvapor_500hPa       ","theta_get_subcloud  ","rh_subcloud         ","mse_subcloud        ","qvapor_subcloud     ","temp_subcloud       "/)
  ;variable_string_list = (/"s1","s2","s3","s4"/)

  pw_ave               = pw_manual_members_ave
  cape_ave             = cape_0D_members_ave
  cin_ave              = cin_0D_members_ave
  LCL_ave              = LCL_members_ave
  LFC_ave              = LFC_members_ave
  all_day_average      = (/pw_manual_members_ave,cape_0D_members_ave,cin_0D_members_ave,LCL_members_ave,LFC_members_ave,temp_500hPa_members_ave,rh_500hPa_members_ave,mse_500hPa_members_ave,qvapor_500hPa_members_ave,theta_get_subcloud_layer_ave_members_ave,rh_subcloud_layer_ave_members_ave,mse_subcloud_layer_ave_members_ave,qvapor_subcloud_layer_ave_members_ave,temp_subcloud_layer_ave_members_ave/)
  ;all_day_average      = (/11,12,13,14/)

  pw_growth_ave                 = avg(pw_manual_members(0:last_growth_day-1))
  cape_growth_ave               = avg(cape_0D_members(0:last_growth_day-1))
  cin_growth_ave                = avg(cin_0D_members(0:last_growth_day-1))
  LCL_growth_ave                = avg(LCL_members(0:last_growth_day-1))
  LFC_growth_ave                = avg(LFC_members(0:last_growth_day-1))
  temp_500hPa_growth_ave        = avg(temp_500hPa_members(0:last_growth_day-1))
  rh_500hPa_growth_ave          = avg(rh_500hPa_members(0:last_growth_day-1))
  mse_500hPa_growth_ave         = avg(mse_500hPa_members(0:last_growth_day-1))
  qvapor_500hPa_growth_ave      = avg(qvapor_500hPa_members(0:last_growth_day-1))
  theta_get_subcloud_growth_ave = avg(theta_get_subcloud_layer_ave_members(0:last_growth_day-1))
  rh_subcloud_growth_ave        = avg(rh_subcloud_layer_ave_members(0:last_growth_day-1))
  mse_subcloud_growth_ave       = avg(mse_subcloud_layer_ave_members(0:last_growth_day-1))
  qvapor_subcloud_growth_ave    = avg(qvapor_subcloud_layer_ave_members(0:last_growth_day-1))
  temp_subcloud_growth_ave      = avg(temp_subcloud_layer_ave_members(0:last_growth_day-1))
  exp_growth_days_ave  = (/pw_growth_ave,cape_growth_ave,cin_growth_ave,LCL_growth_ave,LFC_growth_ave,temp_500hPa_growth_ave,rh_500hPa_growth_ave,mse_500hPa_growth_ave,qvapor_500hPa_growth_ave,theta_get_subcloud_growth_ave,rh_subcloud_growth_ave,mse_subcloud_growth_ave,qvapor_subcloud_growth_ave,temp_subcloud_growth_ave/)
  ;exp_growth_days_ave  = (/avg(pw_manual_members(0:last_growth_day-1)),avg(cape_0D_members(0:last_growth_day-1)),avg(cin_0D_members(0:last_growth_day-1)),avg(LCL_members(0:last_growth_day-1)),avg(LFC_members(0:last_growth_day-1)),avg(temp_500hPa_members(0:last_growth_day-1)),avg(rh_500hPa_members(0:last_growth_day-1)),avg(mse_500hPa_members(0:last_growth_day-1)),avg(qvapor_500hPa_members(0:last_growth_day-1)),avg(theta_get_subcloud_layer_ave_members(0:last_growth_day-1)),avg(rh_subcloud_layer_ave_members(0:last_growth_day-1)),avg(mse_subcloud_layer_ave_members(0:last_growth_day-1)),avg(qvapor_subcloud_layer_ave_members(0:last_growth_day-1)),avg(temp_subcloud_layer_ave_members(0:last_growth_day-1))/)
  ;exp_growth_days_ave  = (/5,6,7,8/)

  lin = num_day_max-1
  pw_decay_ave                 = avg(pw_manual_members(last_growth_day:lin))
  cape_decay_ave               = avg(cape_0D_members(last_growth_day:lin))
  cin_decay_ave                = avg(cin_0D_members(last_growth_day:lin))
  LCL_decay_ave                = avg(LCL_members(last_growth_day:lin))
  LFC_decay_ave                = avg(LFC_members(last_growth_day:lin))
  temp_500hPa_decay_ave        = avg(temp_500hPa_members(last_growth_day:lin))
  rh_500hPa_decay_ave          = avg(rh_500hPa_members(last_growth_day:lin))
  mse_500hPa_decay_ave         = avg(mse_500hPa_members(last_growth_day:lin))
  qvapor_500hPa_decay_ave      = avg(qvapor_500hPa_members(last_growth_day:lin))
  theta_get_subcloud_decay_ave = avg(theta_get_subcloud_layer_ave_members(last_growth_day:lin))
  rh_subcloud_decay_ave        = avg(rh_subcloud_layer_ave_members(last_growth_day:lin))
  mse_subcloud_decay_ave       = avg(mse_subcloud_layer_ave_members(last_growth_day:lin))
  qvapor_subcloud_decay_ave    = avg(qvapor_subcloud_layer_ave_members(last_growth_day:lin))
  temp_subcloud_decay_ave      = avg(temp_subcloud_layer_ave_members(last_growth_day:lin))
  exp_decay_days_ave   = (/pw_decay_ave,cape_decay_ave,cin_decay_ave,LCL_decay_ave,LFC_decay_ave,temp_500hPa_decay_ave,rh_500hPa_decay_ave,mse_500hPa_decay_ave,qvapor_500hPa_decay_ave,theta_get_subcloud_decay_ave,rh_subcloud_decay_ave,mse_subcloud_decay_ave,qvapor_subcloud_decay_ave,temp_subcloud_decay_ave/)
  ;exp_decay_days_ave   = (/avg(pw_manual_members(last_growth_day:lin)),avg(cape_0D_members(last_growth_day:lin)),avg(cin_0D_members(last_growth_day:lin)),avg(LCL_members(last_growth_day:lin)),avg(LFC_members(last_growth_day:lin)),avg(temp_500hPa_members(last_growth_day:lin)),avg(rh_500hPa_members(last_growth_day:lin)),avg(mse_500hPa_members(last_growth_day:lin)),avg(qvapor_500hPa_members(last_growth_day:lin)),avg(theta_get_subcloud_layer_ave_members(last_growth_day:lin)),avg(rh_subcloud_layer_ave_members(last_growth_day:lin)),avg(mse_subcloud_layer_ave_members(last_growth_day:lin)),avg(qvapor_subcloud_layer_ave_members(last_growth_day:lin)),avg(temp_subcloud_layer_ave_members(last_growth_day:lin))/)
  print ("pw_manual_members(last_growth_day:lin) : " + pw_manual_members(last_growth_day:lin))
  ;exp_decay_days_ave   = (/1,2,3,4/)

  pw_relative_var                 = abs(pw_decay_ave-pw_growth_ave)/pw_manual_members_ave*100
  cape_relative_var               = abs(cape_decay_ave-cape_growth_ave)/cape_0D_members_ave*100
  cin_relative_var                = abs(cin_decay_ave-cin_growth_ave)/cin_0D_members_ave*100
  LCL_relative_var                = abs(LCL_decay_ave-LCL_growth_ave)/LCL_members_ave*100
  LFC_relative_var                = abs(LFC_decay_ave-LFC_growth_ave)/LFC_members_ave*100
  temp_500hPa_relative_var        = abs(temp_500hPa_decay_ave-temp_500hPa_growth_ave)/temp_500hPa_members_ave*100
  rh_500hPa_relative_var          = abs(rh_500hPa_decay_ave-rh_500hPa_growth_ave)/rh_500hPa_members_ave*100
  mse_500hPa_relative_var         = abs(mse_500hPa_decay_ave-mse_500hPa_growth_ave)/mse_500hPa_members_ave*100
  qvapor_500hPa_relative_var      = abs(qvapor_500hPa_decay_ave-qvapor_500hPa_growth_ave)/qvapor_500hPa_members_ave*100
  theta_get_subcloud_relative_var = abs(theta_get_subcloud_decay_ave-theta_get_subcloud_growth_ave)/theta_get_subcloud_layer_ave_members_ave*100
  rh_subcloud_relative_var        = abs(rh_subcloud_decay_ave-rh_subcloud_growth_ave)/rh_subcloud_layer_ave_members_ave*100
  mse_subcloud_relative_var       = abs(mse_subcloud_decay_ave-mse_subcloud_growth_ave)/mse_subcloud_layer_ave_members_ave*100
  qvapor_subcloud_relative_var    = abs(qvapor_subcloud_decay_ave-qvapor_subcloud_growth_ave)/qvapor_subcloud_layer_ave_members_ave*100
  temp_subcloud_relative_var      = abs(temp_subcloud_decay_ave-temp_subcloud_growth_ave)/temp_subcloud_layer_ave_members_ave*100
  relative_var_array = (/pw_relative_var,cape_relative_var,cin_relative_var,LCL_relative_var,LFC_relative_var,temp_500hPa_relative_var,rh_500hPa_relative_var,mse_500hPa_relative_var,qvapor_500hPa_relative_var,theta_get_subcloud_relative_var,rh_subcloud_relative_var,mse_subcloud_relative_var,qvapor_subcloud_relative_var,temp_subcloud_relative_var/)
  print("relative_var_array : " + relative_var_array)


  ; PRINT SOME BASIC STATS IN A FILE
  index_array = new((/z_dim/),integer)
  do level = 0, z_dim-1
    index_array(level) = level
  end do
  ;alist = [/variable_string_list(0), all_day_average(0), exp_growth_days_ave(0), exp_decay_days_ave(0)/]
  alist = [/variable_string_list, all_day_average, exp_growth_days_ave, exp_decay_days_ave, relative_var_array/]
  alist_string = "[/variable_string_list, all_day_average, exp_growth_days_ave, exp_decay_days_ave, relative_var_array/]"

  print("test1")
  dir_for_plots_idea = data_dir_for_plots(0)
  header = (/"--------------------------------", \
            "Stats about the target profiles, depending on exp growth or decay", \
            alist_string, \
            "for the targets computed with " + dir_for_plots_idea, \
            "--------------------------------"/)
  footer = (/"--------------------------------", \
            "This is a file footer", \
            "--------------------------------"/)

  hlist = [/header/]
  flist = [/footer/]

  print("test2")
  ;write_table("stats_for_all_day_and_exp_growth_days_and_exp_decay_days.txt", "w", hlist, "%s")
  ;write_table("stats_for_all_day_and_exp_growth_days_and_exp_decay_days.txt", "a", alist, "%s%10.10f%10.10f%10.10f")
  ;write_table("stats_for_all_day_and_exp_growth_days_and_exp_decay_days.txt", "a", flist, "%s")
  write_table("./C02_target_profile_analysis_without_getvar/stats_for_all_day_and_exp_growth_days_and_exp_decay_days_v2.txt", "w", hlist, "%s")
  write_table("./C02_target_profile_analysis_without_getvar/stats_for_all_day_and_exp_growth_days_and_exp_decay_days_v2.txt", "a", alist, "%s%6.10f%6.10f%6.10f%6.10f")
  write_table("./C02_target_profile_analysis_without_getvar/stats_for_all_day_and_exp_growth_days_and_exp_decay_days_v2.txt", "a", flist, "%s")








end

