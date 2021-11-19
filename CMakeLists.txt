cmake_minimum_required(VERSION 3.8)

if (NOT ${CMAKE_HOST_SYSTEM_NAME} MATCHES "!!!NATIVE!!!")
  set(CMAKE_TOOLCHAIN_FILE 
    "${CMAKE_SOURCE_DIR}/cmake/arm-linux-gnueabi.cmake")
endif ()

project(armdemo)

add_executable(${PROJECT_NAME} main.cc)

find_program(QEMU_STATIC
  qemu-arm-static)

if (QEMU_STATIC)  
  add_custom_target(exec 
    DEPENDS ${PROJECT_NAME}
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    COMMAND ${QEMU_STATIC} -cpu arm926
    -L ${TOOLCHAIN_PATH} ${PROJECT_NAME})
endif()
