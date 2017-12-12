# Emissions_Ecacor

The conversis system is a set of forran codes in order to convert the annual emissions inventory into a input file for WRF-chem model for Central Mexico. Consider the following mechanims: RADM2, SAPRC99, RACM, and CBM05.
   |---Emiss_XXXX-master/
        |
        |---01_datos/		(Información para distribución espacial)
        |---02_aemis/		(Distribución geográfica fuentes de área)
        |---03_movilspatial /	(Distribución de vialidades y carreteras)
        |---04_temis/		(distribución temporal fuentes de área)
        |---05_semisM/		(Distribución geográfica fuentes móviles)
        |---06_temisM/		(Distribución temporal F. Móviles)
        |---07_puntual/		(Distrib. Geo. y temporal F. Puntuales)
        |---08_spec/		(Especiación de COV área, móvil y puntual)
        |---09_pm25spec/	(Especiación PM2.5 área, móvil y puntual)
        |---10_storage/		(Generación archivo de emisiones netCDF)
        |---Makefile		(Compila los ejecutables)
        |---abril_2014.sh	(Genera emisione para el 22 abril 2014)
        |---README.md		(información del directorio)


More documentation in directory doc
