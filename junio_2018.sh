#!/bin/bash
#
# bsub -q q_hpc -oo salida_postwrf -n2 -R "span[hosts=1]" './junio_2018.csh'
#  junio_2018.csh
#
#
#  Creado por Jose Agustin Garcia Reynoso el 26/07/17.
#
#  Proposito:
#         Realiza la secuencia de pasos para generar diferentes fechas
#         del inventario de emisiones.
#  Modificaciones:
#         14/08/2013 Actualizacion para IE del 2014
#         14/10/2017 para bash
#SBATCH -J emi_pron
#SBATCH -o emi_eca%j.o
#SBATCH -n 4
#SBATCH --ntasks-per-node=24
#SBATCH -p id
ProcessDir=$PWD
echo $ProcessDir
#
#  Build the fecha.txt file

mes=6
dia=3
 
while [ $dia -le 8 ] ;do
echo $dia
cd $ProcessDir/04_temis

echo $PWD
#
if [ -e fecha.txt ]; then
rm fecha.txt
fi
#    Aqui cambiar el año a modelar
#
ln -sf anio2018.csv  anio2014.csv
#
cat << End_Of_File > fecha.txt
$mes       ! month jan =1 to dec=12
$dia       ! day in the month (from 1 to 28,30 or 31)
End_Of_File
#
echo ' '
echo '  Mes ='$mes 'DIA '$dia
#
echo 'Area Temporal distribution'
./Atemporal.exe  > ../area.log &
echo 'Point Temporal distribution'
cd ../07_puntual/
./Puntual.exe >& ../puntual.log 
echo 'Movil Temporal distribution'
cd ../06_temisM/
./Mtemporal.exe > ../movil.log &
wait
#
#echo 'Biogenic'
#cd ../12_biogenic
#./Btemporal.exe > biog.log&
#
echo 'Speciation distribution PM2.5'
#
cd ../09_pm25spec
./spm25p.exe >> ../puntual.log &
./spm25m.exe >> ../movil.log &
./spm25a.exe >> ../area.log&
#
echo 'Speciation distribution VOCs'
#
cd ../08_spec
echo '   RADM2 *****'
ln -sf profile_radm2.csv profile_mech.csv
echo 'Movile'
./spm.exe >> ../movil.log &
echo 'Puntual'
./spp.exe >> ../puntual.log  &
echo 'Area '
./spa.exe >> ../area.log
#
#echo '    CBM05 *****'
#ln -sf profile_cbm05.csv profile_mech.csv
#echo 'Movile'
#./spm.exe >> ../movil.log &
#echo 'Puntual'
#./spp.exe >> ../puntual.log  &
#echo 'Area '
#./spa.exe >> ../area.log
#echo '    SAPRC99 *****'
#ln -sf profile_saprc99.csv profile_mech.csv
#echo 'Movile'
#./spm.exe >> ../movil.log &
#echo 'Puntual'
#./spp.exe >> ../puntual.log  &
#echo 'Area '
#./spa.exe >> ../area.log
#
#echo '    RACM2 *****'
#ln -sf profile_racm2.csv profile_mech.csv
#echo 'Movile'
#./spm.exe >> ../movil.log &
#echo 'Puntual'
#./spp.exe >> ../puntual.log  &
#echo 'Area '
#./spa.exe >> ../area.log

echo ' Guarda'

cd ../10_storage
./radm2018.exe  > ../radm2.log
#./saprc.exe > ../saprc.log
#./cbm5.exe  > ../cbm5.log
#./racm2.exe > ../racm2.log
 let dia=dia+1
done
ncrcat -O wrfchemi.d01.RADM2.2018-06-03* wrfchemi.d01.RADM2.2018-06-04* wrfchemi.d01.RADM2.2018-06-05* wrfchemi_d01_2018-06-03_00:00:00
ncrcat -O wrfchemi.d01.RADM2.2018-06-04* wrfchemi.d01.RADM2.2018-06-05* wrfchemi.d01.RADM2.2018-06-06* wrfchemi_d01_2018-06-04_00:00:00
ncrcat -O wrfchemi.d01.RADM2.2018-06-05* wrfchemi.d01.RADM2.2018-06-06* wrfchemi.d01.RADM2.2018-06-07* wrfchemi_d01_2018-06-05_00:00:00
ncrcat -O wrfchemi.d01.RADM2.2018-06-06* wrfchemi.d01.RADM2.2018-06-07* wrfchemi.d01.RADM2.2018-06-08* wrfchemi_d01_2018-06-06_00:00:00

mv wrfchemi_d01_2018-06-0?_00:00:00 /LUSTRE/ID/FQA/agustin/pronostico/wrfprd

echo "DONE  guarda_RADM"
