#  
#	Lower level Makefile for 02_aemis
#
#       Suffix rules and commands
##
.SUFFIXES:              .F .f .i .o

.F.i:
		$(RM) $@
		$(CPP) $(CPPFLAGS) -D$(MACH) $*.F > $@

.F.o:
		$(RM) $@
		$(CPP) $(CPPFLAGS) -D$(MACH) $*.F > $*.f
		$(FC) -c $(FCFLAGS) $*.f
		$(RM) $*.f

.F.f:
		$(RM) $@
		$(CPP) $(CPPFLAGS) -D$(MACH) $*.F > $@

.f.o:
		$(RM) $@
		$(FC) -c $(FCFLAGS) $*.f

objects = area_espacial.o

AR      =       ar ru
CD      =       cd
LN      =       ln -s
MAKE    =       make -i -f Makefile
RM      =       /bin/rm -f
RM_LIST =       *.mod *.o core .tmpfile *.exe A*_2014.csv
INTEL_LIB =     /opt/intel/lib

# Ejecuta
default:
	uname -a > .tmpfile
	grep Linux .tmpfile ; \
	if [ $$? = 0 ]; then echo "Compiling for Linux" ;               \
	( $(MAKE) all                          \
	"RM             = $(RM)"        "RM_LIST        = $(RM_LIST)"   \
	"LN             = $(LN)"        "MACH           = DEC"          \
	"MAKE           = $(MAKE)"      "CPP            = fpp"  \
	"CPPFLAGS       = -I. -C "      \
	"FC             = ifort"        "FCFLAGS        = -O2 -axAVX  -align commons" \
	"LDOPTIONS      = -O2 -axAVX  -align commons " \
	"CFLAGS         = -I."          \
	"LOCAL_LIBRARIES=  " ) ; \
	else \
	grep Darwin .tmpfile ; \
	if [ $$? = 0 ]; then echo "Compiling for Darwin" ;              \
	( $(MAKE) all                          \
	"RM             = $(RM)"        "RM_LIST        = $(RM_LIST)"   \
	"LN             = $(LN)"        "MACH           = DEC"          \
	"MAKE           = $(MAKE)"      "CPP            = fpp"  \
	"CPPFLAGS       = -I. -C "      \
	"FC             = ifort"        "FCFLAGS        = -fast -axAVX  -align commons" \
	"LDOPTIONS      = -fast -axAVX  -align commons " \
	"CFLAGS         = -I."          \
	"LOCAL_LIBRARIES=  " ) ; \
	else echo "Do not know how to compile for the `cat .tmpfile` machine." \
	fi ; \
	fi ; \
	fi ; \

pgi:
	uname -a >  .tmpfile
	grep Linux .tmpfile ; \
	if [ $$? = 0 ]; then echo "Compiling for Linux PGI" ;               \
	( $(MAKE) all                          \
	"RM             = $(RM)"        "RM_LIST        = $(RM_LIST)"   \
	"LN             = $(LN)"        "MACH           = PGI"          \
	"MAKE           = $(MAKE)"      "CPP            = fpp"  \
 	"CPPFLAGS       = -I.  "      \
	"FC             = pgf90"        "FCFLAGS        = -O3 -fastsse -Mfree" \
	"LDOPTIONS      = -O3 -fastsse -Mfree " \
	"CFLAGS         = -I."          \
	"LOCAL_LIBRARIES=  " ) ; \
	else \
	grep Darwin .tmpfile ; \
	if [ $$? = 0 ]; then echo "Compiling for Darwin PGI" ;              \
	( $(MAKE) all                          \
	"RM             = $(RM)"        "RM_LIST        = $(RM_LIST)"   \
	"LN             = $(LN)"        "MACH           = PGI"          \
	"MAKE           = $(MAKE)"      "CPP            = fpp"  \
	"CPPFLAGS       =  "      \
	"FC             = pgf90"        "FCFLAGS        = -O3 -fastsse -Mfree" \
	"LDOPTIONS      = -O3 -fastsse -Mfree " \
	"CFLAGS         = -I."          \
	"LOCAL_LIBRARIES=  " ) ; \
	else echo "Do not know how to compile for the `cat .tmpfile` machine." \
	fi ; \
	fi ; \
	fi ; \

all :	ASpatial.exe

ASpatial.exe: $(objects)
	$(FC) -o $@ $(objects) $(LDOPTIONS) 

area_espacial.o: area_espacial.F90
	$(FC) -c  $< $(FCFLAGS) -D$(MACH) 
 
clean:
		$(RM) $(RM_LIST)

#
#
