#############################################################################
# Makefile for building: cl-filter
# Generated by qmake (3.0) (Qt 5.2.0)
# Project:  cl-filter.pro
# Template: app
# Command: /home/jenson/Develop/Tools/Qt5.2.0/5.2.0/gcc_64/bin/qmake -spec linux-g++ -o Makefile cl-filter.pro
#############################################################################

MAKEFILE      = Makefile

####### Compiler, tools and options

CC            = gcc
CXX           = g++
DEFINES       = -D__CL_ENABLE_EXCEPTIONS
CFLAGS        = -pipe -O2 -Wall -W -fPIE $(DEFINES)
CXXFLAGS      = -pipe -O2 -Wall -W -fPIE $(DEFINES)
INCPATH       = -I../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/linux-g++ -I. -I/opt/AMDAPP/include
LINK          = g++
LFLAGS        = -Wl,-O1 -Wl,-rpath,/home/jenson/Develop/Tools/Qt5.2.0/5.2.0/gcc_64
LIBS          = $(SUBLIBS) -L/home/jenson/Develop/Workspaces/OpenCL/opencl-image-filter/../../../../../../opt/AMDAPP/lib/x86_64/ -lOpenCL -lfreeimage -lm -lopencv_calib3d -lopencv_contrib -lopencv_core -lopencv_features2d -lopencv_flann -lopencv_gpu -lopencv_highgui -lopencv_imgproc -lopencv_legacy -lopencv_ml -lopencv_nonfree -lopencv_objdetect -lopencv_ocl -lopencv_photo -lopencv_stitching -lopencv_superres -lopencv_video -lopencv_videostab 
AR            = ar cqs
RANLIB        = 
QMAKE         = /home/jenson/Develop/Tools/Qt5.2.0/5.2.0/gcc_64/bin/qmake
TAR           = tar -cf
COMPRESS      = gzip -9f
COPY          = cp -f
SED           = sed
COPY_FILE     = cp -f
COPY_DIR      = cp -f -R
STRIP         = strip
INSTALL_FILE  = install -m 644 -p
INSTALL_DIR   = $(COPY_DIR)
INSTALL_PROGRAM = install -m 755 -p
DEL_FILE      = rm -f
SYMLINK       = ln -f -s
DEL_DIR       = rmdir
MOVE          = mv -f
CHK_DIR_EXISTS= test -d
MKDIR         = mkdir -p

####### Output directory

OBJECTS_DIR   = ./

####### Files

SOURCES       = main.cpp \
		fileutils.cpp 
OBJECTS       = main.o \
		fileutils.o
DIST          = ../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/spec_pre.prf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/common/shell-unix.conf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/common/unix.conf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/common/linux.conf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/common/gcc-base.conf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/common/gcc-base-unix.conf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/common/g++-base.conf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/common/g++-unix.conf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/qconfig.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_bluetooth.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_bluetooth_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_bootstrap_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_clucene_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_concurrent.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_concurrent_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_core.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_core_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_dbus.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_dbus_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_declarative.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_declarative_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_designer.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_designer_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_designercomponents_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_gui.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_gui_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_help.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_help_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_multimedia.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_multimedia_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_multimediawidgets.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_multimediawidgets_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_network.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_network_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_nfc.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_nfc_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_opengl.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_opengl_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_openglextensions.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_openglextensions_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_platformsupport_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_positioning.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_positioning_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_printsupport.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_printsupport_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_qml.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_qml_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_qmldevtools_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_qmltest.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_qmltest_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_qtmultimediaquicktools_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_quick.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_quick_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_quickparticles_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_script.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_script_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_scripttools.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_scripttools_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_sensors.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_sensors_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_serialport.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_serialport_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_sql.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_sql_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_svg.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_svg_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_testlib.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_testlib_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_uitools.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_uitools_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_webkit.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_webkit_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_webkitwidgets.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_webkitwidgets_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_widgets.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_widgets_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_x11extras.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_x11extras_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_xml.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_xml_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_xmlpatterns.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_xmlpatterns_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/qt_functions.prf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/qt_config.prf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/linux-g++/qmake.conf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/spec_post.prf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/exclusive_builds.prf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/default_pre.prf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/resolve_config.prf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/default_post.prf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/unix/gdb_dwarf_index.prf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/warn_on.prf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/testcase_targets.prf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/exceptions.prf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/yacc.prf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/lex.prf \
		cl-filter.pro \
		cl-filter.pro
QMAKE_TARGET  = cl-filter
DESTDIR       = #avoid trailing-slash linebreak
TARGET        = cl-filter


first: all
####### Implicit rules

.SUFFIXES: .o .c .cpp .cc .cxx .C

.cpp.o:
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o "$@" "$<"

.cc.o:
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o "$@" "$<"

.cxx.o:
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o "$@" "$<"

.C.o:
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o "$@" "$<"

.c.o:
	$(CC) -c $(CFLAGS) $(INCPATH) -o "$@" "$<"

####### Build rules

all: Makefile $(TARGET)

$(TARGET):  $(OBJECTS)  
	$(LINK) $(LFLAGS) -o $(TARGET) $(OBJECTS) $(OBJCOMP) $(LIBS)

Makefile: cl-filter.pro ../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/linux-g++/qmake.conf ../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/spec_pre.prf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/common/shell-unix.conf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/common/unix.conf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/common/linux.conf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/common/gcc-base.conf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/common/gcc-base-unix.conf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/common/g++-base.conf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/common/g++-unix.conf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/qconfig.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_bluetooth.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_bluetooth_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_bootstrap_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_clucene_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_concurrent.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_concurrent_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_core.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_core_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_dbus.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_dbus_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_declarative.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_declarative_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_designer.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_designer_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_designercomponents_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_gui.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_gui_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_help.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_help_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_multimedia.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_multimedia_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_multimediawidgets.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_multimediawidgets_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_network.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_network_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_nfc.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_nfc_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_opengl.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_opengl_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_openglextensions.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_openglextensions_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_platformsupport_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_positioning.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_positioning_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_printsupport.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_printsupport_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_qml.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_qml_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_qmldevtools_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_qmltest.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_qmltest_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_qtmultimediaquicktools_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_quick.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_quick_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_quickparticles_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_script.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_script_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_scripttools.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_scripttools_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_sensors.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_sensors_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_serialport.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_serialport_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_sql.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_sql_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_svg.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_svg_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_testlib.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_testlib_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_uitools.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_uitools_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_webkit.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_webkit_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_webkitwidgets.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_webkitwidgets_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_widgets.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_widgets_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_x11extras.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_x11extras_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_xml.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_xml_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_xmlpatterns.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_xmlpatterns_private.pri \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/qt_functions.prf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/qt_config.prf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/linux-g++/qmake.conf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/spec_post.prf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/exclusive_builds.prf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/default_pre.prf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/resolve_config.prf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/default_post.prf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/unix/gdb_dwarf_index.prf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/warn_on.prf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/testcase_targets.prf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/exceptions.prf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/yacc.prf \
		../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/lex.prf \
		cl-filter.pro
	$(QMAKE) -spec linux-g++ -o Makefile cl-filter.pro
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/spec_pre.prf:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/common/shell-unix.conf:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/common/unix.conf:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/common/linux.conf:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/common/gcc-base.conf:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/common/gcc-base-unix.conf:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/common/g++-base.conf:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/common/g++-unix.conf:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/qconfig.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_bluetooth.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_bluetooth_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_bootstrap_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_clucene_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_concurrent.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_concurrent_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_core.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_core_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_dbus.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_dbus_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_declarative.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_declarative_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_designer.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_designer_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_designercomponents_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_gui.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_gui_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_help.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_help_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_multimedia.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_multimedia_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_multimediawidgets.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_multimediawidgets_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_network.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_network_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_nfc.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_nfc_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_opengl.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_opengl_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_openglextensions.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_openglextensions_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_platformsupport_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_positioning.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_positioning_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_printsupport.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_printsupport_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_qml.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_qml_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_qmldevtools_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_qmltest.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_qmltest_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_qtmultimediaquicktools_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_quick.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_quick_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_quickparticles_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_script.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_script_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_scripttools.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_scripttools_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_sensors.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_sensors_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_serialport.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_serialport_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_sql.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_sql_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_svg.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_svg_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_testlib.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_testlib_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_uitools.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_uitools_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_webkit.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_webkit_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_webkitwidgets.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_webkitwidgets_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_widgets.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_widgets_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_x11extras.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_x11extras_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_xml.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_xml_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_xmlpatterns.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/modules/qt_lib_xmlpatterns_private.pri:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/qt_functions.prf:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/qt_config.prf:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/linux-g++/qmake.conf:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/spec_post.prf:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/exclusive_builds.prf:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/default_pre.prf:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/resolve_config.prf:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/default_post.prf:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/unix/gdb_dwarf_index.prf:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/warn_on.prf:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/testcase_targets.prf:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/exceptions.prf:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/yacc.prf:
../../../Tools/Qt5.2.0/5.2.0/gcc_64/mkspecs/features/lex.prf:
cl-filter.pro:
qmake: FORCE
	@$(QMAKE) -spec linux-g++ -o Makefile cl-filter.pro

qmake_all: FORCE

dist: 
	@test -d .tmp/cl-filter1.0.0 || mkdir -p .tmp/cl-filter1.0.0
	$(COPY_FILE) --parents $(SOURCES) $(DIST) .tmp/cl-filter1.0.0/ && (cd `dirname .tmp/cl-filter1.0.0` && $(TAR) cl-filter1.0.0.tar cl-filter1.0.0 && $(COMPRESS) cl-filter1.0.0.tar) && $(MOVE) `dirname .tmp/cl-filter1.0.0`/cl-filter1.0.0.tar.gz . && $(DEL_FILE) -r .tmp/cl-filter1.0.0


clean:compiler_clean 
	-$(DEL_FILE) $(OBJECTS)
	-$(DEL_FILE) *~ core *.core


####### Sub-libraries

distclean: clean
	-$(DEL_FILE) $(TARGET) 
	-$(DEL_FILE) Makefile


check: first

compiler_yacc_decl_make_all:
compiler_yacc_decl_clean:
compiler_yacc_impl_make_all:
compiler_yacc_impl_clean:
compiler_lex_make_all:
compiler_lex_clean:
compiler_clean: 

####### Compile

main.o: main.cpp fileutils.h \
		/opt/AMDAPP/include/CL/cl.h \
		/opt/AMDAPP/include/CL/cl_platform.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o main.o main.cpp

fileutils.o: fileutils.cpp fileutils.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o fileutils.o fileutils.cpp

####### Install

install:   FORCE

uninstall:   FORCE

FORCE:
