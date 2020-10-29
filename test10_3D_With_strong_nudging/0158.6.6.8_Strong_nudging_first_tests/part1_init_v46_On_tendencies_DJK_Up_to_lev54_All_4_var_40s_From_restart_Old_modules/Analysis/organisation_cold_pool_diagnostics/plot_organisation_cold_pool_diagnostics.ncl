
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl" 
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
;load "./NCL_colormap/NCV_blu_red.rgb"

begin

  num_day_max = 1    ;100, 90
  NUMBER_PROF = 3
  level_top_for_pbl = 9
  level_top_for_mid_tropo = 26
  month=8   ;9   ;6
  day=0

  ;/srv/ccrc/data40/z3339052/Raijin_seabreeze2d/test10_3D_With_strong_nudging/0158.6.6.8_Strong_nudging_first_tests/part1_init_v46_On_tendencies_DJK_Up_to_lev54_All_4_var_40s_From_restart_Old_modules/Analysis/organisation_cold_pool_diagnostics
  ;data_dir_for_plots = "0187_Imposed_surf_fluxes_CTRL"
  data_dir_for_plots = "part1_init_v46_On_tendencies_DJK_Up_to_lev54_All_4_var_40s_From_restart_Old_modules"
  data_dir = "/srv/ccrc/data40/z3339052/Raijin_seabreeze2d/test10_3D_With_strong_nudging/0158.6.6.8_Strong_nudging_first_tests/" + data_dir_for_plots

  output_path = data_dir + "/Analysis/organisation_cold_pool_diagnostics"

  data_settings = addfile(data_dir + "/wrfout_d01_2007-08-01_05:00:00_part1_init_v46_On_tendencies_DJK_Up_to_lev54_All_4_var_40s_From_restart_Old_modules.nc","r")
  ;data_settings = addfile(data_dir + "/wrfout_d01_2007-09-01_05:00:00.nc","r")
  data_settings_suffix = "part1_init_v46_On_tendencies_DJK_Up_to_lev54_All_4_var_40s_From_restart_Old_modules"

  xtime  = data_settings->XTIME
  p      = data_settings->P
  length_single_file = dimsizes(xtime)
  p_dims = dimsizes(p)
  z_dim  = p_dims(1)
  y_dim  = p_dims(2)
  x_dim  = p_dims(3)
  print("p_dims is " + p_dims)
  print("dimsizes(xtime) is " + dimsizes(xtime))
  theta_horizontal_ave_big_array   = new((/num_day_max*length_single_file,z_dim/),float)
  rh_hor_ave_big_array             = new((/num_day_max*length_single_file,z_dim/),float)
  heights_hor_ave_big_array        = new((/num_day_max*length_single_file,z_dim/),float)
  total_p__hor_ave_big_array       = new((/num_day_max*length_single_file,z_dim/),float)
  time_day_big_array               = new((/num_day_max*length_single_file/),float)

  pw_big_array                       = new((/num_day_max*length_single_file,y_dim,x_dim/),float)
  pw_hor_std_big_array               = new((/num_day_max*length_single_file/),float)
  olr_hor_ave_big_array              = new((/num_day_max*length_single_file/),float)
  olr_big_array                      = new((/num_day_max*length_single_file,y_dim,x_dim/),float)
  theta_BL_vert_ave_big_array         = new((/num_day_max*length_single_file,y_dim,x_dim/),float)
  qvapor_BL_vert_ave_big_array        = new((/num_day_max*length_single_file,y_dim,x_dim/),float)
  theta_mid_tropo_vert_ave_big_array  = new((/num_day_max*length_single_file,y_dim,x_dim/),float)
  qvapor_mid_tropo_vert_ave_big_array = new((/num_day_max*length_single_file,y_dim,x_dim/),float)
  
  total_p_hor_ave_big_array        = new((/num_day_max*length_single_file,z_dim/),float)

  ;array_of_theta_prof   = new((/NUMBER_PROF,z_dim/),float)
  ;array_of_temp_prof    = new((/NUMBER_PROF,z_dim/),float)
  ;array_of_eth_prof     = new((/NUMBER_PROF,z_dim/),float)
  ;array_of_heights        = new((/NUMBER_PROF,z_dim/),float)



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
    else if ((month .eq. 9) .and. (day .gt. 30) ) then
      month=10
      day=1
    else if ((month .eq. 10) .and. (day .gt. 31) ) then
      month=11
      day=1    
    end if
    end if
    end if
    end if
    end if

    mmonth = tostring_with_format(month, "%0.2d")
    dday = tostring_with_format(day, "%0.2d")
    file_name = "wrfout_d01_2007-" + mmonth + "-" + dday + "_05:00:00_" + data_settings_suffix
    print(" ")
    print("file_name is " + file_name)
 
    data = addfile(data_dir + "/" + file_name + ".nc","r")




    ; DEFINE AND LOAD THE VARIABLES TO USE                      
    ;  cape_WRF = wrf_user_getvar(data,"cape_3d",-1)     ; Read the variable to memory
    ;  printVarSummary(cape_WRF)
    ;  pw = wrf_user_getvar(data,"pw",-1)     ; Apparently this doesn't work... and I don't know why... (Either file (nc_file) isn't defined or variable (pw) is not a variable in the file)
    ;  w      = data->W
    ;  qcloud = data->QCLOUD
    z            = wrf_user_getvar(data,"z",-1)
    theta_get    = wrf_user_getvar(data,"theta",-1)
    ;temp         = wrf_user_getvar(data,"tk",-1)
    pw_get       = wrf_user_getvar(data,"pw",-1) 
    rh           = wrf_user_getvar(data,"rh",-1) 
    delta_theta  = data->T
    p            = data->P
    pb           = data->PB
    xtime        = data->XTIME

    olr          = data->OLR
    qvapor       = data->QVAPOR


    ; ANALYSE THE VARIABLES
    total_p = p + pb


    ; COMPUTATION OF PRECIPITABLE WATER VIA GETVAR
    printVarSummary(pw_get)
    pw_get_horizontal_average = dim_avg(dim_avg(pw_get))
    pw_get_hor_std            = dim_stddev_n( pw_get, (/1,2/) )
    printVarSummary(pw_get_hor_std)


    ; INFOS COMPUTATIONS
    indices = dimsizes(theta_get)
    index_max_time = indices(0)
    print(indices)
    print(index_max_time)


    ; MASK FOR A ROUGH APPROXIMATE OF THE PBL
    wgt_pbl = new(z_dim,float)
    printVarSummary(wgt_pbl)
    do level = 0, z_dim-1
        if (level .le. level_top_for_pbl) then
            wgt_pbl(level) = 1.
        else
            wgt_pbl(level) = 0.
        end if
    end do
    print("wgt_pbl is " + wgt_pbl)


    ; COLD POOL DIAGNOSTIC COMPUTATIONS
    qvapor_rough_pbl_ave = dim_avg_wgt_n( qvapor, wgt_pbl, 0, 1 )
    theta_get_rough_pbl_ave = dim_avg_wgt_n( theta_get, wgt_pbl, 0, 1 )


    ; MASK FOR A ROUGH DIAGNOSTICS OF MID-TROPO (FROM PBL TOP TO 600hPa)
    wgt_mid_tropo = new(z_dim,float)
    do level = 0, z_dim-1
        if ((level .gt. level_top_for_pbl) .and. (level .le. level_top_for_mid_tropo)) then
            wgt_mid_tropo(level) = 1.
        else
            wgt_mid_tropo(level) = 0.
        end if
    end do
    print("wgt_mid_tropo is " + wgt_mid_tropo)
 
    ; AIR ABOVE COLD POOL DIAGNOSTICS
    qvapor_mid_tropo_vert_ave = dim_avg_wgt_n( qvapor, wgt_mid_tropo, 0, 1 ) 
    theta_mid_tropo_vert_ave  = dim_avg_wgt_n( theta_get, wgt_mid_tropo, 0, 1 )


    ; OTHER COMPUTATIONS
    theta_get_hor_ave = dim_avg(dim_avg(theta_get))
    rh_hor_ave    = dim_avg(dim_avg(rh))
    z_hor_ave     = dim_avg(dim_avg(z))
    total_p_hor_ave        = dim_avg(dim_avg(total_p))
    olr_hor_ave            = dim_avg(dim_avg(olr))


    ; TIME VARIABLES
    time_hour = xtime/60.
    time_day = time_hour/24.


    ; SAVE IN BIG ARRAYS
    do n = 0,dimsizes(xtime)-1
        theta_horizontal_ave_big_array(length_single_file*(num_day-1)+n,:) = theta_get_hor_ave(n,:)
        rh_hor_ave_big_array(length_single_file*(num_day-1)+n,:) = rh_hor_ave(n,:)
        heights_hor_ave_big_array(length_single_file*(num_day-1)+n,:) = z_hor_ave(n,:)
        total_p_hor_ave_big_array(length_single_file*(num_day-1)+n,:) = total_p_hor_ave(n,:)
        time_day_big_array(length_single_file*(num_day-1)+n) = time_day(n)

        pw_big_array(length_single_file*(num_day-1)+n,:,:)  = pw_get(n,:,:)
        pw_hor_std_big_array(length_single_file*(num_day-1)+n)  = pw_get_hor_std(n)
        olr_hor_ave_big_array(length_single_file*(num_day-1)+n) = olr_hor_ave(n)
        olr_big_array(length_single_file*(num_day-1)+n,:,:) = olr(n,:,:)
        theta_BL_vert_ave_big_array(length_single_file*(num_day-1)+n,:,:)  = theta_get_rough_pbl_ave(n,:,:)
        qvapor_BL_vert_ave_big_array(length_single_file*(num_day-1)+n,:,:) = qvapor_rough_pbl_ave(n,:,:)
        qvapor_mid_tropo_vert_ave_big_array(length_single_file*(num_day-1)+n,:,:) = qvapor_mid_tropo_vert_ave(n,:,:)
        theta_mid_tropo_vert_ave_big_array(length_single_file*(num_day-1)+n,:,:) = theta_mid_tropo_vert_ave(n,:,:)
        if (n .eq. 0) then
            print("index length_single_file*(num_day-1)+n is " + length_single_file*(num_day-1)+n)
            print("num_day is " + num_day)
            print("time_day(n) is " + time_day(n))
        end if
    end do

    ;total_p_hor_ave_big_array_time_ave = dim_avg(transpose(total_p_hor_ave_big_array))


    ; OUTPUT A DAILY FILE FOR THE 3D VARIABLES
    filename_daily = output_path + "/ncl_computed_daily" + "/ncl_computed_output_" + file_name + ".nc"
    system("/bin/rm -f " + filename_daily) ; remove any pre-existing file
    setfileoption("nc","Format","NetCDF4Classic")
    ncdf_daily = addfile(filename_daily,"c") ; open output netCDF file

    ncdf_daily->PW_GET    = pw_get
    ncdf_daily->QVAPOR_ROUGH_PBL_AVE      =  qvapor_rough_pbl_ave
    ncdf_daily->THETA_GET_ROUGH_PBL_AVE   =  theta_get_rough_pbl_ave
    ncdf_daily->QVAPOR_MID_TROPO_VERT_AVE =  qvapor_mid_tropo_vert_ave
    ncdf_daily->THETA_MID_TROPO_VERT_AVE  =  theta_mid_tropo_vert_ave





    ; PLOT SOME FIGURES FOR THE LAST DAY
    if (num_day .eq. num_day_max) then
        do num_output = 0, 90   ;30
            num_day_s = tostring_with_format(num_day, "%0.2d")
            num_output_s = tostring_with_format(num_output, "%0.2d")
            type = "png"

            ; PLOT NUMBER A1
            ;delete(wks)
            ;delete(res)
            wks = gsn_open_wks(type,"./movies/plot_pw_big_array_" + data_dir_for_plots + "_num_day_" + num_day_s + "_num_output_" + num_output_s + "_v1")
            gsn_define_colormap(wks,"NCV_blu_red")
            res = True
            res@cnFillOn = True
            res@gsnSpreadColors = True
            res@cnLineLabelsOn = False
            res@lbOrientation   = "Vertical"
            res@cnLevelSelectionMode = "ManualLevels" ;"AutomaticLevels"
            res@cnMaxLevelValF = 68.  ;66.
            res@cnMinLevelValF = 42.  ;48.
            res@cnLevelSpacingF = 2.
            res@gsnMaximize = True
            res@tiYAxisString = "y (km)"
            res@tiXAxisString = "x (km)"
            res@tiMainString = "PW, num_day=" + num_day + ", num_output=" + num_output
            res@gsnMaximize = True
            plot = gsn_csm_contour(wks,pw_big_array(length_single_file*(num_day-1)+num_output,:,:),res)

            ; PLOT NUMBER A2
            delete(wks)
            delete(res)
            wks = gsn_open_wks(type,"./movies/plot_olr_big_array_" + data_dir_for_plots + "_num_day_" + num_day_s + "_num_output_" + num_output_s + "_v1")
            gsn_define_colormap(wks,"NCV_blu_red")
            res = True
            res@cnFillOn = True
            res@gsnSpreadColors = True
            res@cnLineLabelsOn = False
            res@lbOrientation   = "Vertical"
            res@cnLevelSelectionMode = "ManualLevels" ;"AutomaticLevels"
            res@cnMaxLevelValF = 280.
            res@cnMinLevelValF = 100.
            res@cnLevelSpacingF = 20.
            res@gsnMaximize = True
            res@tiYAxisString = "y (km)"
            res@tiXAxisString = "x (km)"
            res@tiMainString = "OLR, num_day=" + num_day + ", num_output=" + num_output
            res@gsnMaximize = True
            plot = gsn_csm_contour(wks,olr_big_array(length_single_file*(num_day-1)+num_output,:,:),res)

            ; PLOT NUMBER A3
            delete(wks)
            delete(res)
            wks = gsn_open_wks(type,"./movies/plot_theta_BL_vert_ave_big_array_" + data_dir_for_plots + "_num_day_" + num_day_s + "_num_output_" + num_output_s + "_v1")
            gsn_define_colormap(wks,"NCV_blu_red")
            res = True
            res@cnFillOn = True
            res@gsnSpreadColors = True
            res@cnLineLabelsOn = False
            res@lbOrientation   = "Vertical"
            res@cnLevelSelectionMode = "ManualLevels" ;"AutomaticLevels"
            res@cnMaxLevelValF = 301.2  ;301.5
            res@cnMinLevelValF = 299.8  ;299.5
            res@cnLevelSpacingF = 0.1
            res@gsnMaximize = True
            res@tiYAxisString = "y (km)"
            res@tiXAxisString = "x (km)"
            res@tiMainString = "Pot. Temp., BL-vert ave , num_day=" + num_day + ", num_output=" + num_output
            res@gsnMaximize = True
            plot = gsn_csm_contour(wks,theta_BL_vert_ave_big_array(length_single_file*(num_day-1)+num_output,:,:),res)

            ; PLOT NUMBER A4
            delete(wks)
            delete(res)
            wks = gsn_open_wks(type,"./movies/plot_qvapor_BL_vert_ave_big_array_" + data_dir_for_plots + "_num_day_" + num_day_s + "_num_output_" + num_output_s + "_v1")
            gsn_define_colormap(wks,"NCV_blu_red")
            res = True
            res@cnFillOn = True
            res@gsnSpreadColors = True
            res@cnLineLabelsOn = False
            res@lbOrientation   = "Vertical"
            res@cnLevelSelectionMode = "ManualLevels" ;"AutomaticLevels"
            res@cnMaxLevelValF = 19.  ;19.
            res@cnMinLevelValF = 16.  ;13.
            res@cnLevelSpacingF = 0.5
            res@gsnMaximize = True
            res@tiYAxisString = "y (km)"
            res@tiXAxisString = "x (km)"
            res@tiMainString = "Qvapor, BL-vert ave , num_day=" + num_day + ", num_output=" + num_output
            res@gsnMaximize = True
            plot = gsn_csm_contour(wks,1000.*qvapor_BL_vert_ave_big_array(length_single_file*(num_day-1)+num_output,:,:),res)

            ; PLOT NUMBER A5
            delete(wks)
            delete(res)
            wks = gsn_open_wks(type,"./movies/plot_theta_mid_tropo_vert_ave_big_array_" + data_dir_for_plots + "_num_day_" + num_day_s + "_num_output_" + num_output_s + "_v1")
            gsn_define_colormap(wks,"NCV_blu_red")
            res = True
            res@cnFillOn = True
            res@gsnSpreadColors = True
            res@cnLineLabelsOn = False
            res@lbOrientation   = "Vertical"
            res@cnLevelSelectionMode = "ManualLevels" ;"AutomaticLevels"
            res@cnMaxLevelValF = 309.0
            res@cnMinLevelValF = 307.0
            res@cnLevelSpacingF = 0.1
            res@gsnMaximize = True
            res@tiYAxisString = "y (km)"
            res@tiXAxisString = "x (km)"
            res@tiMainString = "Pot. Temp., Mid-tropo ave , num_day=" + num_day + ", num_output=" + num_output
            res@gsnMaximize = True
            plot = gsn_csm_contour(wks,theta_mid_tropo_vert_ave_big_array(length_single_file*(num_day-1)+num_output,:,:),res)

            ; PLOT NUMBER A6
            delete(wks)
            delete(res)
            wks = gsn_open_wks(type,"./movies/plot_qvapor_mid_tropo_vert_ave_big_array_" + data_dir_for_plots + "_num_day_" + num_day_s + "_num_output_" + num_output_s + "_v1")
            gsn_define_colormap(wks,"NCV_blu_red")
            res = True
            res@cnFillOn = True
            res@gsnSpreadColors = True
            res@cnLineLabelsOn = False
            res@lbOrientation   = "Vertical"
            res@cnLevelSelectionMode = "ManualLevels" ;"AutomaticLevels"
            res@cnMaxLevelValF = 12.  ;14.0
            res@cnMinLevelValF = 8.   ;9.0
            res@cnLevelSpacingF = 0.5
            res@gsnMaximize = True
            res@tiYAxisString = "y (km)"
            res@tiXAxisString = "x (km)"
            res@tiMainString = "Qvapor, Mid-tropo ave , num_day=" + num_day + ", num_output=" + num_output
            res@gsnMaximize = True
            plot = gsn_csm_contour(wks,1000.*qvapor_mid_tropo_vert_ave_big_array(length_single_file*(num_day-1)+num_output,:,:),res)



        end do 
    end if


    ; PLOT SOME SNAPSHOTS OF OLR TO CHECK ORGANISATION AT PARTICULAR TIMES

    if ( (num_day .eq. 21) .or. (num_day .eq. 39) ) then
        do num_output = 0, 10
            num_day_s = tostring_with_format(num_day, "%0.2d")
            num_output_s = tostring_with_format(num_output, "%0.2d")
            type = "png"

            ; PLOT NUMBER B1
            wks = gsn_open_wks(type,"./movies_OLR_specific_days/plot_snapshot_OLR_big_array_" + data_dir_for_plots + "_num_day_" + num_day_s + "_num_output_" + num_output_s + "_v1")
            gsn_define_colormap(wks,"NCV_blu_red")
            res = True
            res@cnFillOn = True
            res@gsnSpreadColors = True
            res@cnLineLabelsOn = False
            res@lbOrientation   = "Vertical"
            res@cnLevelSelectionMode = "ManualLevels" ;"AutomaticLevels"
            res@cnMaxLevelValF = 300  ;300
            res@cnMinLevelValF = 100  ;120
            res@cnLevelSpacingF = 10
            res@gsnMaximize = True
            res@tiYAxisString = "y (km)"
            res@tiXAxisString = "x (km)"
            res@tiMainString = "OLR , num_day=" + num_day + ", num_output=" + num_output
            res@gsnMaximize = True
            plot = gsn_csm_contour(wks,olr_big_array(length_single_file*(num_day-1)+num_output,:,:),res)

            ; PLOT NUMBER B2
            delete(wks)
            delete(res)
            wks = gsn_open_wks(type,"./movies_OLR_specific_days/plot_snapshot_OLR_" + data_dir_for_plots + "_num_day_" + num_day_s + "_num_output_" + num_output_s + "_v1")
            gsn_define_colormap(wks,"NCV_blu_red")
            res = True
            res@cnFillOn = True
            res@gsnSpreadColors = True
            res@cnLineLabelsOn = False
            res@lbOrientation   = "Vertical"
            res@cnLevelSelectionMode = "ManualLevels" ;"AutomaticLevels"
            res@cnMaxLevelValF = 300  ;300
            res@cnMinLevelValF = 100  ;120
            res@cnLevelSpacingF = 20
            res@gsnMaximize = True
            res@tiYAxisString = "y (km)"
            res@tiXAxisString = "x (km)"
            res@tiMainString = "OLR , num_day=" + num_day + ", num_output=" + num_output
            res@gsnMaximize = True
            plot = gsn_csm_contour(wks,olr(num_output,:,:),res)

        end do
    end if





    delete(xtime)
    delete(p)
    delete(pb)

  end do




  ; AVERAGING ON THE LAST MONTH
;  wgt_3rd_m = new((/num_day_max*length_single_file/),float)
;  do time = 0, num_day_max*length_single_file-1
;      if (time .lt. 60*length_single_file-1) then
;          wgt_3rd_m(time) = 0.
;      else if ((time .ge. 60*length_single_file-1) .and. (time .lt. 90*length_single_file-1)) then
;          wgt_3rd_m(time) = 1.
;      else
;          wgt_3rd_m(time) = 0.
;      end if
;      end if
;  end do

  wgt_3rd_m = new((/num_day_max*length_single_file/),float)
  do time = 0, num_day_max*length_single_file-1
      if (time .lt. (num_day_max-30)*length_single_file-1) then
          wgt_3rd_m(time) = 0.
      else if ((time .ge. (num_day_max-30)*length_single_file-1) .and. (time .lt. 90*length_single_file-1)) then
          wgt_3rd_m(time) = 1.
      else
          wgt_3rd_m(time) = 0.
      end if
      end if
  end do

  theta_hor_ave_3rd_month   = dim_avg_wgt_n( theta_horizontal_ave_big_array, wgt_3rd_m, 0, 0 )
  pw_big_array_3rd_month    = dim_avg_wgt_n( pw_big_array, wgt_3rd_m, 0, 0 )
  olr_big_array_3rd_month   = dim_avg_wgt_n( olr_big_array, wgt_3rd_m, 0, 0 )
  rh_hor_ave_3rd_month      = dim_avg_wgt_n( rh_hor_ave_big_array, wgt_3rd_m, 0, 0 )
  heights_hor_ave_3rd_month = dim_avg_wgt_n( heights_hor_ave_big_array, wgt_3rd_m, 0, 0 )
  total_p_hor_ave_3rd_month = dim_avg_wgt_n( total_p_hor_ave_big_array, wgt_3rd_m, 0, 0 ) 
  qvapor_rough_pbl_ave_3rd_month      = dim_avg_wgt_n( qvapor_BL_vert_ave_big_array, wgt_3rd_m, 0, 0 ) 
  theta_get_rough_pbl_ave_3rd_month   = dim_avg_wgt_n( theta_BL_vert_ave_big_array, wgt_3rd_m, 0, 0 ) 
  qvapor_mid_tropo_vert_ave_3rd_month = dim_avg_wgt_n( qvapor_mid_tropo_vert_ave_big_array, wgt_3rd_m, 0, 0 ) 
  theta_mid_tropo_vert_ave_3rd_month  = dim_avg_wgt_n( theta_mid_tropo_vert_ave_big_array, wgt_3rd_m, 0, 0 ) 


  ; PRINT THE VERTICAL INFO IN A FILE
  index_array = new((/z_dim/),integer)
  do level = 0, z_dim-1
    index_array(level) = level
  end do
  alist = [/index_array, heights_hor_ave_3rd_month, total_p_hor_ave_3rd_month/]
  alist_string = "[/index_array, heights_hor_ave_3rd_month, total_p_hor_ave_3rd_month/]"

  header = (/"--------------------------------", \
            "Vertical info", \
            alist_string, \
            "for " + data_dir_for_plots, \
            "--------------------------------"/)
  footer = (/"--------------------------------", \
            "This is a file footer", \
            "--------------------------------"/)

  hlist = [/header/]
  flist = [/footer/]

  write_table("vertical_info_index_heights_total_p_hor_ave_3rd_month.txt", "w", hlist, "%s")
  write_table("vertical_info_index_heights_total_p_hor_ave_3rd_month.txt", "a", alist, "%d%5.2f%5.2f")
  write_table("vertical_info_index_heights_total_p_hor_ave_3rd_month.txt", "a", flist, "%s")


  ; PRINTS
  print("")
  print("level_top_for_pbl : " + level_top_for_pbl)
  print("heights_hor_ave_3rd_month(level_top_for_pbl) " + heights_hor_ave_3rd_month(level_top_for_pbl))
  print("total_p_hor_ave_3rd_month(level_top_for_pbl) " + total_p_hor_ave_3rd_month(level_top_for_pbl))
  print("rh_hor_ave_3rd_month(level_top_for_pbl) is " + rh_hor_ave_3rd_month(level_top_for_pbl))
  print("rh_hor_ave_3rd_month is " + rh_hor_ave_3rd_month)

  print("")
  print("level_top_for_mid_tropo : " + level_top_for_mid_tropo)
  print("heights_hor_ave_3rd_month(level_top_for_mid_tropo) " + heights_hor_ave_3rd_month(level_top_for_mid_tropo))
  print("total_p_hor_ave_3rd_month(level_top_for_mid_tropo) " + total_p_hor_ave_3rd_month(level_top_for_mid_tropo))

  print("")
  print("rh_hor_ave_3rd_month is " + rh_hor_ave_3rd_month)
  print("heights_hor_ave_3rd_month is " + heights_hor_ave_3rd_month)
  print("total_p_hor_ave_3rd_month is " + total_p_hor_ave_3rd_month)





  ; OUTPUTTING NETCDF FILES, IN CASE PLOTTING FAILS
  filename = output_path + "/ncl_output_ALL_52days.nc"
  system("/bin/rm -f " + filename) ; remove any pre-existing file
  setfileoption("nc","Format","NetCDF4Classic")
  ncdf = addfile(filename,"c") ; open output netCDF file

  ncdf->THETA_HORIZONTAL_AVE_BIG_ARRAY      = theta_horizontal_ave_big_array
  ncdf->RH_HOR_AVE_BIG_ARRAY                = rh_hor_ave_big_array
  ncdf->HEIGHTS_HOR_AVE_BIG_ARRAY           = heights_hor_ave_big_array
  ncdf->TOTAL_P_HOR_AVE_BIG_ARRAY           = total_p_hor_ave_big_array
  ncdf->TIME_DAY_BIG_ARRAY                  = time_day_big_array
  ncdf->PW_BIG_ARRAY                        = pw_big_array
  ncdf->PW_HOR_STD_BIG_ARRAY                = pw_hor_std_big_array
  ncdf->OLR_HOR_AVE_BIG_ARRAY               = olr_hor_ave_big_array
  ncdf->OLR_BIG_ARRAY                       = olr_big_array
  ncdf->THETA_BL_VERT_AVE_BIG_ARRAY         = theta_BL_vert_ave_big_array
  ncdf->QVAPOR_BL_VERT_AVE_BIG_ARRAY        = qvapor_BL_vert_ave_big_array
  ncdf->QVAPOR_MID_TROPO_VERT_AVE_BIG_ARRAY = qvapor_mid_tropo_vert_ave_big_array
  ncdf->THETA_MID_TROPO_VERT_AVE_BIG_ARRAY  = theta_mid_tropo_vert_ave_big_array
  ncdf->PW_BIG_ARRAY_3RD_MONTH              = pw_big_array_3rd_month
  ncdf->OLR_BIG_ARRAY_3RD_MONTH             = olr_big_array_3rd_month
  ncdf->RH_HOR_AVE_3RD_MONTH                = rh_hor_ave_3rd_month
  ncdf->HEIGHTS_HOR_AVE_3RD_MONTH           = heights_hor_ave_3rd_month
  ncdf->TOTAL_P_HOR_AVE_3RD_MONTH           = total_p_hor_ave_3rd_month
  ncdf->QVAPOR_ROUGH_PBL_AVE_3RD_MONTH      = qvapor_rough_pbl_ave_3rd_month
  ncdf->THETA_GET_ROUGH_PBL_AVE_3RD_MONTH   = theta_get_rough_pbl_ave_3rd_month
  ncdf->QVAPOR_MID_TROPO_VERT_AVE_3RD_MONTH = qvapor_mid_tropo_vert_ave_3rd_month
  ncdf->THETA_MID_TROPO_VERT_AVE_3RD_MONTH  = theta_mid_tropo_vert_ave_3rd_month






; SPECIFY THE KIND OF OUTPUT YOU WANT
;  type = "x11"
  type = "png"
;  type = "pdf"
;  type = "ps"
;  type = "ncgm"

; CREATE YOUR PLOT
;  type@wkPaperSize = "A4"
  wks = gsn_open_wks(type,"plot_olr_hor_ave_" + data_dir_for_plots + "_1day_v1")   ; Create a plot workstation + TITLE OF THE FILE TO SAVE
;  gsn_define_colormap(wks,"ncl_default")
;  gsn_define_colormap(wks,"matlab_jet")
;  gsn_define_colormap(wks,"MPL_rainbow")
;  gsn_define_colormap(wks,"NCV_blu_red")
  
  opts = True
  res = opts 
;  res@cnFillOn = True
;  res@gsnSpreadColors = True
;  res@cnLineLabelsOn = False
  res@lbOrientation   = "Vertical"

;  res@MainTitle = " "
;  res@gsnLeftString = " "

;  res@cnLevelSelectionMode = "ManualLevels"
;  res@cnLevelSelectionMode = "AutomaticLevels"
;  res@cnMinLevelValF = 0.
;  res@cnMaxLevelValF = 1000.
;  res@cnLevelSpacingF = 0.5

  res@gsnMaximize = True
;  res@vpWidthF = 1.0
;  res@vpHeightF = 1.0


;  res = True
  res@tmXTOn         = False        
  res@xyLineThicknesses = 8        
  res@xyLineColor    =  "blue" 
  ;res@trXMinF        =  200
  ;res@trXMaxF        =  800
  ;res@trYMinF        =  0
  ;res@trYMaxF        =  30   ;30000
  res@tiXAxisString = "Time (day)"
  res@tiYAxisString = "OLR (W/m2)"
  res@tiMainString = "OLR, hor ave"

  plot  = gsn_csm_xy(wks, time_day_big_array, olr_hor_ave_big_array, res)







; PLOT NUMBER 2
;  type@wkPaperSize = "A4"
  delete(res)
  delete(wks)
  wks = gsn_open_wks(type,"plot_pw_hor_std_" + data_dir_for_plots + "_1day_v1")   ; Create a plot workstation + TITLE OF THE FILE TO SAVE
  opts = True
  res2 = opts
  res2@lbOrientation   = "Vertical"
  res2@gsnMaximize = True
  res2@tmXTOn         = False
  res2@xyLineThicknesses = 8
  res2@xyLineColor    =  "blue"
  ;res2@trXMinF        =  0
  ;res2@trXMaxF        =  num_day_max
  ;res2@trYMinF       = min(temp_500hPa_hor_ave_big_array)
  ;res2@trYMaxF       = max(temp_500hPa_hor_ave_big_array)
  res2@tiYAxisString = "std deviation of PW (mm)"
  res2@tiXAxisString = "Time (day)"
  res2@tiMainString = "PW, hor standard deviation"

  plot  = gsn_csm_xy(wks,time_day_big_array, pw_hor_std_big_array, res2)




; PLOT NUMBER 3
;  type@wkPaperSize = "A4"
  delete(res2)
  delete(wks)
  wks = gsn_open_wks(type,"plot_prof_rh_hor_ave_3rd_month_" + data_dir_for_plots + "_1day_v1")   ; Create a plot workstation + TITLE OF THE FILE TO SAVE 
  opts = True
  res = opts
  res@lbOrientation   = "Vertical"
  res@gsnMaximize = True
  res@tmXTOn         = False
  res@xyLineThicknesses = 8
  res@xyLineColor    =  "blue"
  res@trXMinF        =  0
  res@trXMaxF        =  100
  res@trYMinF        =  0
  res@trYMaxF        =  30   ;30000
  res@tiXAxisString = "Relative Humidity (%)"
  res@tiYAxisString = "z (km)"
  res@tiMainString = "RH, hor ave, 3rd month"

  plot  = gsn_csm_xy(wks,rh_hor_ave_3rd_month,0.001*heights_hor_ave_3rd_month,res)





; PLOT NUMBER 4
;  type@wkPaperSize = "A4"
  delete(res)
  delete(wks)
  wks = gsn_open_wks(type,"plot_prof_theta_hor_ave_3rd_month_" + data_dir_for_plots + "_1day_v1")   ; Create a plot workstation + TITLE OF THE FILE TO SAVE 
  opts = True
  res = opts
  res@lbOrientation   = "Vertical"
  res@gsnMaximize = True
  res@tmXTOn         = False
  res@xyLineThicknesses = 8
  res@xyLineColor    =  "blue"
  res@trXMinF        =  200
  res@trXMaxF        =  800
  res@trYMinF        =  0
  res@trYMaxF        =  30   ;30000
  res@tiXAxisString = "Potential Temperature (K)"
  res@tiYAxisString = "z (km)"
  res@tiMainString = "Potential Temperature, hor ave, 3rd month"

  plot  = gsn_csm_xy(wks,theta_hor_ave_3rd_month,0.001*heights_hor_ave_3rd_month,res)



; PLOT NUMBER 5
;  type@wkPaperSize = "A4"
  delete(res)
  delete(wks)
  wks = gsn_open_wks(type,"plot_prof_total_p_hor_ave_3rd_month_" + data_dir_for_plots + "_1day_v1")   ; Create a plot workstation + TITLE OF THE FILE TO SAVE 
  opts = True
  res = opts
  res@lbOrientation   = "Vertical"
  res@gsnMaximize = True
  res@tmXTOn         = False
  res@xyLineThicknesses = 8
  res@xyLineColor    =  "blue"
  res@xyMonoMarkLineMode = True
  res@xyMarkLineMode    = "MarkLines"
  res@xyMarker       =  "0"
  res@xyMarkerColor  =  "red"
  ;res@trXMinF        =  0
  ;res@trXMaxF        =  30
  res@trYMinF        =  0
  res@trYMaxF        =  30   ;30000
  res@tiXAxisString = "Total pressure (hPa)"
  res@tiYAxisString = "z (km)"
  res@tiMainString = "Total pressure, hor ave, 3rd month"

  plot  = gsn_csm_xy(wks,0.01*total_p_hor_ave_3rd_month,0.001*heights_hor_ave_3rd_month,res)




; PLOT NUMBER 6
;  type@wkPaperSize = "A4"
  delete(res)
  delete(wks)
  wks = gsn_open_wks(type,"plot_pw_big_array_3rd_month_" + data_dir_for_plots + "_1day_v1")
  ;gsn_define_colormap(wks,"matlab_jet")
  gsn_define_colormap(wks,"NCV_blu_red")
  res = True
  res@cnFillOn = True
  res@gsnSpreadColors = True
  res@cnLineLabelsOn = False
  res@lbOrientation   = "Vertical"
;  res@MainTitle = "TOTAL P AS A FUNCTION OF Z AND TIME"
  res@cnLevelSelectionMode = "AutomaticLevels"
  res@gsnMaximize = True
  res@tiYAxisString = "y (km)"
  res@tiXAxisString = "x (km)"
  res@tiMainString = "PW(mm), 3rd month ave"
  res@gsnMaximize = True

  plot = gsn_csm_contour(wks,pw_big_array_3rd_month(:,:),res)




; PLOT NUMBER 7
;  type@wkPaperSize = "A4"
  delete(res)
  delete(wks)
  wks = gsn_open_wks(type,"plot_olr_big_array_3rd_month_" + data_dir_for_plots + "_1day_v1")
  ;gsn_define_colormap(wks,"matlab_jet")
  gsn_define_colormap(wks,"NCV_blu_red")
  res = True
  res@cnFillOn = True
  res@gsnSpreadColors = True
  res@cnLineLabelsOn = False
  res@lbOrientation   = "Vertical"
;  res@MainTitle = "TOTAL P AS A FUNCTION OF Z AND TIME"
  res@cnLevelSelectionMode = "AutomaticLevels"
  res@gsnMaximize = True
  res@tiYAxisString = "y (km)"
  res@tiXAxisString = "x (km)"
  res@tiMainString = "OLR(W/m2), 3rd month ave"
  res@gsnMaximize = True

  plot = gsn_csm_contour(wks,olr_big_array_3rd_month(:,:),res)



; PLOT NUMBER 8
;  type@wkPaperSize = "A4"
  delete(res)
  delete(wks)
  wks = gsn_open_wks(type,"plot_qvapor_rough_pbl_ave_3rd_month_" + data_dir_for_plots + "_1day_v1")
  ;gsn_define_colormap(wks,"matlab_jet")
  gsn_define_colormap(wks,"NCV_blu_red")
  res = True
  res@cnFillOn = True
  res@gsnSpreadColors = True
  res@cnLineLabelsOn = False
  res@lbOrientation   = "Vertical"
;  res@MainTitle = "TOTAL P AS A FUNCTION OF Z AND TIME"
  res@cnLevelSelectionMode = "AutomaticLevels"
  res@gsnMaximize = True
  res@tiYAxisString = "y (km)"
  res@tiXAxisString = "x (km)"
  res@tiMainString = "Qvapor(g/kg), PBL ave, 3rd month ave"
  res@gsnMaximize = True

  plot = gsn_csm_contour(wks,1000.*qvapor_rough_pbl_ave_3rd_month(:,:),res)




; PLOT NUMBER 9
;  type@wkPaperSize = "A4"
  delete(res)
  delete(wks)
  wks = gsn_open_wks(type,"plot_theta_get_rough_pbl_ave_3rd_month" + data_dir_for_plots + "_1day_v1")
  ;gsn_define_colormap(wks,"matlab_jet")
  gsn_define_colormap(wks,"NCV_blu_red")
  res = True
  res@cnFillOn = True
  res@gsnSpreadColors = True
  res@cnLineLabelsOn = False
  res@lbOrientation   = "Vertical"
;  res@MainTitle = "TOTAL P AS A FUNCTION OF Z AND TIME"
  res@cnLevelSelectionMode = "AutomaticLevels"
  res@gsnMaximize = True
  res@tiYAxisString = "y (km)"
  res@tiXAxisString = "x (km)"
  res@tiMainString = "Pot. Temp.(K), PBL ave, 3rd month ave"
  res@gsnMaximize = True

  plot = gsn_csm_contour(wks,theta_get_rough_pbl_ave_3rd_month(:,:),res)



; PLOT NUMBER 10
;  type@wkPaperSize = "A4"
  delete(res)
  delete(wks)
  wks = gsn_open_wks(type,"plot_qvapor_mid_tropo_vert_ave_3rd_month_" + data_dir_for_plots + "_1day_v1")
  ;gsn_define_colormap(wks,"matlab_jet")
  gsn_define_colormap(wks,"NCV_blu_red")
  res = True
  res@cnFillOn = True
  res@gsnSpreadColors = True
  res@cnLineLabelsOn = False
  res@lbOrientation   = "Vertical"
;  res@MainTitle = "TOTAL P AS A FUNCTION OF Z AND TIME"
  res@cnLevelSelectionMode = "AutomaticLevels"
  res@gsnMaximize = True
  res@tiYAxisString = "y (km)"
  res@tiXAxisString = "x (km)"
  res@tiMainString = "Qvapor(g/kg), Mid-tropo ave, 3rd month ave"
  res@gsnMaximize = True

  plot = gsn_csm_contour(wks,1000.*qvapor_mid_tropo_vert_ave_3rd_month(:,:),res)




; PLOT NUMBER 11
;  type@wkPaperSize = "A4"
  delete(res)
  delete(wks)
  wks = gsn_open_wks(type,"plot_theta_mid_tropo_vert_ave_3rd_month_" + data_dir_for_plots + "_1day_v1")
  ;gsn_define_colormap(wks,"matlab_jet")
  gsn_define_colormap(wks,"NCV_blu_red")
  res = True
  res@cnFillOn = True
  res@gsnSpreadColors = True
  res@cnLineLabelsOn = False
  res@lbOrientation   = "Vertical"
;  res@MainTitle = "TOTAL P AS A FUNCTION OF Z AND TIME"
  res@cnLevelSelectionMode = "AutomaticLevels"
  res@gsnMaximize = True
  res@tiYAxisString = "y (km)"
  res@tiXAxisString = "x (km)"
  res@tiMainString = "Pot. Temp.(K), Mid-tropo ave, 3rd month ave"
  res@gsnMaximize = True

  plot = gsn_csm_contour(wks,theta_mid_tropo_vert_ave_3rd_month(:,:),res)




end

