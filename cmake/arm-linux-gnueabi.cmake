set(MARCH "armv4t")
set(MCPU "arm920t")
set(SYSROOT_PATH "${CMAKE_SYSROOT}/usr")
set(TOOLCHAIN_HOST "arm-linux-gnueabi")
set(TOOLCHAIN_PATH "${SYSROOT_PATH}/${TOOLCHAIN_HOST}")

set(TOOLCHAIN_CC "${TOOLCHAIN_HOST}-gcc")
set(TOOLCHAIN_CXX "${TOOLCHAIN_HOST}-g++")
set(TOOLCHAIN_LD "${TOOLCHAIN_HOST}-ld")
set(TOOLCHAIN_AR "${TOOLCHAIN_HOST}-ar")
set(TOOLCHAIN_RANLIB "${TOOLCHAIN_HOST}-ranlib")
set(TOOLCHAIN_STRIP "${TOOLCHAIN_HOST}-strip")
set(TOOLCHAIN_NM "${TOOLCHAIN_HOST}-nm")

set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_CROSSCOMPILING TRUE)
#set(CMAKE_SYSROOT "${SYSROOT_PATH}")
#set(CMAKE_SYSTEM_PROCESSOR arm)
set(CMAKE_SYSTEM_PROCESSOR ${MARCH})

# Define the compiler
set(CMAKE_C_COMPILER ${TOOLCHAIN_CC})
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_CXX})

# List of library dirs where LD has to look. Pass them directly through gcc. 
# LD_LIBRARY_PATH is not evaluated by arm-*-ld
set(LIB_DIRS 
  "${TOOLCHAIN_PATH}/lib"
  "${TOOLCHAIN_PATH}/libhf")

# You can additionally check the linker paths if you add the flags ' -Xlinker --verbose'
set(COMMON_FLAGS "-I${TOOLCHAIN_PATH}/include ")
FOREACH(LIB ${LIB_DIRS})
  set(COMMON_FLAGS "${COMMON_FLAGS} -L${LIB} -Wl,-rpath-link,${LIB} ")
ENDFOREACH()

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
set(CMAKE_C_FLAGS "-mcpu=${MCPU} -march=${MARCH} ${COMMON_FLAGS}" CACHE STRING "Flags for ARM920T")
set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS}" CACHE STRING "Flags for ARM920T")
set(CMAKE_EXE_LINKER_FLAGS "-B${TOOLCHAIN_PATH}/lib")
set(CMAKE_PREFIX_PATH "${CMAKE_PREFIX_PATH};${TOOLCHAIN_PATH}")
set(CMAKE_FIND_ROOT_PATH "${CMAKE_INSTALL_PREFIX};${CMAKE_PREFIX_PATH};${CMAKE_SYSROOT};${SYSROOT_PATH}")

# search for programs in the build host directories
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

unset(CMAKE_C_IMPLICIT_INCLUDE_DIRECTORIES)
unset(CMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES)
