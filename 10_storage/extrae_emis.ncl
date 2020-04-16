begin
  fils = systemfunc("ls ./wrfchemi.d01.RADM2.2014-04-22_*")
  npts=dimsizes(fils)+1
  data  = new( npts, "string")
  var     = (/ "E_CO","E_NO","E_NO2","E_PM25","E_ECI" /)
  unidad  =(/"mol km^-2 hr^-1","mol km^-2 hr^-1","mol km^-2 hr^-1","ug m-2 s-1","ug m-2 s-1" /)
  desc  =(/"CO emiss","NO emiss","NO2 emiss","PM25 emiss","ECI emiss"/)
  sitio =(/"Tecnologico","V_Cuauhtemoc","S_Antonio","Tollocan" /)
  lonpnt  = (/-99.707447,-99.557647,-99.562950,-99.583819/)
  latpnt  = (/19.269250,19.927222,19.155436,19.286383/)
  fName="estaciones_emis.csv"
  data(0)="Num,Year,Mes,Dia,Hora"
   do j=0,dimsizes(var)-1
     data(0)= data(0)+","+var(j)+" ("+unidad(j)+")"
     do i=0, dimsizes(sitio)-1
      data(0)= data(0)+","+sitio(i)
     end do
   end do
;
  do npt=0,dimsizes(fils)-1
    npt1=npt+1
    fi = addfile(fils(npt)+".nc","r")
    lon2d    = fi->XLONG(0,:,:)
    lat2d    = fi->XLAT(0,:,:)
    date     = fi->Times(0,:)
    hours    = fi->Times(:,0)
    ;--- update ---
   data(npt1) = sprinti("%0.5i ", (npt+1) )
   data(npt1) = data(npt1)+","+date(0:3)+","+date(5:6)+","+date(8:9)
    do ii=0, dimsizes(hours)-1
   data(npt1) =data(npt1)+","+ii
    do i = 0, dimsizes(var)-1
      x = fi->$var(i)$
;  Para convertir de ppm a ppb
      if (i.gt.0) then
       x = x*1.
      end if
      xnew1= rcm2points (lat2d,lon2d,x,latpnt,lonpnt,2)
    xnew =xnew1(:,0,:)
;print(xnew)
    data(npt1) = data(npt1)+","+var(i)
     do j = 0, dimsizes(lonpnt)-1
    data(npt1) = data(npt1)+"," +sprintf("%8.5f ", xnew(ii,j))
    end do
    end do
    ;  print(" updating ... "+var(i))
    end do
    asciiwrite (fName , data)
   end do ;ii

end

