QT       += core gui opengl openglwidgets network

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++17

LIBS += -lOpenGL32

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    axis.cpp \
    glwidget.cpp \
    main.cpp \
    dialog.cpp \
    marker.cpp \
    path.cpp \
    pathdisplay.cpp \
    pointcloud.cpp \
    simpoints.cpp \
    slider.cpp

HEADERS += \
    axis.h \
    dialog.h \
    glwidget.h \
    marker.h \
    path.h \
    pathdisplay.h \
    pointcloud.h \
    simpoints.h \
    slider.h \
    transducer.h \
    vector3d.h

CUDA_SOURCES += \
    sim.cu

DISTFILES += \
	$$CUDA_SOURCES \
	../axis.frag \
	../axis.vert \
	../marker.frag \
	../marker.vert \
	../markerGeo.vert \
	../path.frag \
	../path.vert \
	../plane.frag \
	../plane.vert \
	../pointcloud.frag \
	../pointcloud.vert \
	sim.cu

# MSVCRT link option (static or dynamic, it must be the same with your Qt SDK link option)
MSVCRT_LINK_FLAG_DEBUG   = "/MDd"
MSVCRT_LINK_FLAG_RELEASE = "/MD"

# CUDA settings
CUDA_DIR = d:/CUDA		    # ***** Set to your CUDA path *****
CUDA_DIR = $$(CUDA_PATH)            # Path to cuda toolkit install
SYSTEM_NAME = x64                   # Depending on your system either 'Win32', 'x64', or 'Win64'
SYSTEM_TYPE = 64                    # '32' or '64', depending on your system
CUDA_ARCH = sm_60                   # Type of CUDA architecture
NVCC_OPTIONS = --use_fast_math

# include paths
INCLUDEPATH += $$CUDA_DIR/include \
	       $$CUDA_DIR/common/inc \
	       $$CUDA_DIR/../shared/inc

# The following makes sure all path names (which often include spaces) are put between quotation marks
CUDA_INC = $$join(INCLUDEPATH,'" -I"','-I"','"')

# Add the necessary libraries
CUDA_LIB_NAMES = cudart_static kernel32 user32 gdi32 winspool comdlg32 \
		 advapi32 shell32 ole32 oleaut32 uuid odbc32 odbccp32 \
		 #freeglut glew32

for(lib, CUDA_LIB_NAMES) {
    CUDA_LIBS += -l$$lib
}
LIBS += $$CUDA_LIBS

win32:LIBS += -Ld:/CUDA/lib/x64


# Configuration of the Cuda compiler
CONFIG(debug, debug|release) {
    # Debug mode
    cuda_d.input = CUDA_SOURCES
    cuda_d.output = $$CUDA_OBJECTS_DIR/${QMAKE_FILE_BASE}_cuda.obj
    cuda_d.commands = $$CUDA_DIR/bin/nvcc.exe -D_DEBUG $$NVCC_OPTIONS $$CUDA_INC $$LIBS \
		      --machine $$SYSTEM_TYPE -arch=$$CUDA_ARCH \
		      --compile -cudart static -g -DWIN32 -D_MBCS \
		      -Xcompiler "/wd4819,/EHsc,/W3,/nologo,/Od,/Zi,/RTC1" \
		      -Xcompiler $$MSVCRT_LINK_FLAG_DEBUG \
		      -c -o ${QMAKE_FILE_OUT} ${QMAKE_FILE_NAME}
    cuda_d.dependency_type = TYPE_C
    QMAKE_EXTRA_COMPILERS += cuda_d
}
else {
    # Release mode
    cuda.input = CUDA_SOURCES
    cuda.output = $$CUDA_OBJECTS_DIR/${QMAKE_FILE_BASE}_cuda.obj
    cuda.commands = $$CUDA_DIR/bin/nvcc.exe $$NVCC_OPTIONS $$CUDA_INC $$LIBS \
		    --machine $$SYSTEM_TYPE -arch=$$CUDA_ARCH \
		    --compile -cudart static -DWIN32 -D_MBCS \
		    -Xcompiler "/wd4819,/EHsc,/W3,/nologo,/O2,/Zi" \
		    -Xcompiler $$MSVCRT_LINK_FLAG_RELEASE \
		    -c -o ${QMAKE_FILE_OUT} ${QMAKE_FILE_NAME}
    cuda.dependency_type = TYPE_C
    QMAKE_EXTRA_COMPILERS += cuda
}


# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
