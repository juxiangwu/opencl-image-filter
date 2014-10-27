TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
CONFIG -= qt

SOURCES += main.cpp \
    fileutils.cpp

LIBS += \
    -L$$PWD/../../../../../../opt/AMDAPP/lib/x86_64/ \
    -lOpenCL \
    -lfreeimage \
    -lm

LIBS += \
       -lopencv_calib3d \
       -lopencv_contrib \
       -lopencv_core \
       -lopencv_features2d \
       -lopencv_flann \
       -lopencv_gpu \
       -lopencv_highgui \
       -lopencv_imgproc \
       -lopencv_legacy \
       -lopencv_ml \
       -lopencv_nonfree \
       -lopencv_objdetect \
       -lopencv_ocl \
       -lopencv_photo \
       -lopencv_stitching \
       -lopencv_superres \
       -lopencv_video \
       -lopencv_videostab

DEFINES += __CL_ENABLE_EXCEPTIONS


INCLUDEPATH += $$PWD/../../../../../../opt/AMDAPP/include
DEPENDPATH += $$PWD/../../../../../../opt/AMDAPP/include

HEADERS += \
    fileutils.h

OTHER_FILES += \
    kernels/filters.cl
