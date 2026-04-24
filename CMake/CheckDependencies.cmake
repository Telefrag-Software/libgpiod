include(CheckFunctionExists)
include(CheckSymbolExists)
include(CheckIncludeFile)
include(CheckCSourceRuns)

set(CMAKE_REQUIRED_DEFINITIONS -D_GNU_SOURCE)

check_include_file("fcntl.h" HAVE_FCNTL_H)

if(NOT HAVE_FCNTL_H)
	message(FATAL_ERROR "Missing 'fcntl.h' heade file!")
endif()

check_include_file("getopt.h" HAVE_GETOPT_H)

if(NOT HAVE_GETOPT_H)
	message(FATAL_ERROR "Missing 'getopt.h' header file!")
endif()

check_include_file("dirent.h" HAVE_DIRENT_H)

if(NOT HAVE_DIRENT_H)
	message(FATAL_ERROR "Missing 'dirent.h' header file!")
endif()

check_include_file("sys/sysmacros.h" HAVE_SYS_SYSMACROS_H)

if(NOT HAVE_SYS_SYSMACROS_H)
	message(FATAL_ERROR "Missing 'sys/sysmacros.h' header file!")
endif()

check_include_file("sys/ioctl.h" HAVE_SYS_IOCTL_H)

if(NOT HAVE_SYS_IOCTL_H)
	message(FATAL_ERROR "Missing 'sys/ioctl.h' header file!")
endif()

check_include_file("sys/param.h" HAVE_SYS_PARAM_H)

if(NOT HAVE_SYS_PARAM_H)
	message(FATAL_ERROR "Missing 'sys/param.h' header file!")
endif()

check_include_file("sys/stat.h" HAVE_SYS_STAT_H)

if(NOT HAVE_SYS_STAT_H)
	message(FATAL_ERROR "Missing 'sys/stat.h' header file!")
endif()

check_include_file("sys/types.h" HAVE_SYS_TYPES_H)

if(NOT HAVE_SYS_TYPES_H)
	message(FATAL_ERROR "Missing 'sys/types.h' header file!")
endif()

check_include_file("linux/const.h" HAVE_LINUX_CONST_H)

if(NOT HAVE_LINUX_CONST_H)
	message(FATAL_ERROR "Missing 'linux/const.h' header file!")
endif()

check_include_file("linux/ioctl.h" HAVE_LINUX_IOCTL_H)

if(NOT HAVE_LINUX_IOCTL_H)
	message(FATAL_ERROR "Missing 'linux/ioctl.h' header file!")
endif()

check_include_file("linux/types.h" HAVE_LINUX_TYPES_H)

if(NOT HAVE_LINUX_TYPES_H)
	message(FATAL_ERROR "Missing 'linux/types.h' header file!")
endif()

check_include_file("stdbool.h" HAVE_STDBOOL_H)

if(NOT HAVE_STDBOOL_H)
	message(FATAL_ERROR "Missing 'stdbool.h' header file!")
endif()

check_function_exists(ioctl HAVE_IOCTL)

if(NOT HAVE_IOCTL)
	message(FATAL_ERROR "Function 'ioctl' not found!")
endif()

check_symbol_exists(ioctl "sys/ioctl.h" HAVE_IOCTL)

if(NOT HAVE_IOCTL)
	message(FATAL_ERROR "Missing 'sys/ioctl.h' header!")
endif()

check_symbol_exists(open "fcntl.h" HAVE_OPEN)

if(NOT HAVE_OPEN)
	message(FATAL_ERROR "Missing 'open' symbol in 'fcntl.h' header!")
endif()

check_symbol_exists(close "unistd.h" HAVE_CLOSE)

if(NOT HAVE_CLOSE)
	message(FATAL_ERROR "Missing 'close' symbol in 'unistd.h' header!")
endif()

check_symbol_exists(read "unistd.h" HAVE_READ)

if(NOT HAVE_READ)
	message(FATAL_ERROR "Missing 'read' symbol in 'unistd.h' header!")
endif()

check_symbol_exists(realpath "stdlib.h" HAVE_REALPATH)

if(NOT HAVE_REALPATH)
	message(FATAL_ERROR "Missing 'realpath' symbol in 'stdlib.h' header!")
endif()

check_symbol_exists(readlink "unistd.h" HAVE_READLINK)

if(NOT HAVE_REALPATH)
	message(FATAL_ERROR "Missing 'readlink' symbol in 'unistd.h' header!")
endif()
