cmake_minimum_required(VERSION 3.5...4.2.1 FATAL_ERROR)

option(LIBGPIOD_BUILD_CXX_WRAPPER "Build C++ binding layer library." ON)

list(INSERT CMAKE_MODULE_PATH 0 ${CMAKE_CURRENT_SOURCE_DIR}/CMake)

file(READ "${CMAKE_CURRENT_SOURCE_DIR}/configure.ac" AUTOMAKE_CONTENTS)

string(REGEX MATCH
	"AC_SUBST\\(API_VERSION, *\\[([0-9]+\\.[0-9]+\\.[0-9]+)\\]\\)"
	_API_VERSION_MATCH
	"${AUTOMAKE_CONTENTS}"
)

if(NOT _API_VERSION_MATCH)
	message(FATAL_ERROR "Failed to parse 'API_VERSION' value from 'configure.ac' file.")
endif()

set(API_VERSION "${CMAKE_MATCH_1}")

set(_LIBGPIOD_CONFIG_HEADER_FILE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/include/config.h")

project(libgpiod VERSION ${API_VERSION} LANGUAGES C CXX)

set(LIBRARY_NAME libgpiod)

add_library(${LIBRARY_NAME}
	lib/chip-info.c
	lib/chip.c
	lib/edge-event.c
	lib/info-event.c
	lib/internal.c
	lib/internal.h
	lib/line-config.c
	lib/line-info.c
	lib/line-request.c
	lib/line-settings.c
	lib/misc.c
	lib/request-config.c
	lib/uapi/gpio.h
)

add_library(${PROJECT_NAME}::${LIBRARY_NAME} ALIAS ${LIBRARY_NAME})

target_sources(${LIBRARY_NAME}
	PUBLIC
		FILE_SET HEADERS
		TYPE HEADERS
		BASE_DIRS
			${CMAKE_CURRENT_SOURCE_DIR}/include
		FILES
			include/gpiod.h
)

target_include_directories(${LIBRARY_NAME}
	PUBLIC
		$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
		$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
	PRIVATE
		${CMAKE_CURRENT_SOURCE_DIR}/lib
)

set_target_properties(${LIBRARY_NAME} PROPERTIES
	LINKER_LANGUAGE C
	C_STANDARD 99
	C_STANDARD_REQUIRED ON
)

target_compile_definitions(${PROJECT_NAME}
		PRIVATE
		_GNU_SOURCE
		GPIOD_API_VERSION_STR=\"${API_VERSION}\"
)

include(CheckDependencies)
include(GNUInstallDirs)

set(CONFIG_INSTALL_DIR "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}")
set(GENERATED_DIR "${CMAKE_CURRENT_BINARY_DIR}/generated")
set(VERSION_CONFIG "${GENERATED_DIR}/${PROJECT_NAME}ConfigVersion.cmake")
set(PROJECT_CONFIG "${GENERATED_DIR}/${PROJECT_NAME}Config.cmake")
set(TARGETS_EXPORT_NAME "${PROJECT_NAME}Targets")
set(NAMESPACE "${PROJECT_NAME}::")

include(CMakePackageConfigHelpers)

if(LIBGPIOD_BUILD_CXX_WRAPPER)
	add_subdirectory(bindings/cxx)
endif()

write_basic_package_version_file(
	"${VERSION_CONFIG}" COMPATIBILITY SameMajorVersion
)

configure_package_config_file(
	"CMake/Config.cmake.in"
	"${PROJECT_CONFIG}"
	INSTALL_DESTINATION "${CONFIG_INSTALL_DIR}"
)

install(
	TARGETS ${LIBRARY_NAME}
	EXPORT "${TARGETS_EXPORT_NAME}"
	LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
	ARCHIVE DESTINATION "${CMAKE_INSTALL_LIBDIR}"
	RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
	FILE_SET HEADERS
		DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)

install(
	FILES ${LIBRARY_HEADER_FILES}
	DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)

install(
	FILES "${PROJECT_CONFIG}" "${VERSION_CONFIG}"
	DESTINATION "${CONFIG_INSTALL_DIR}"
)

install(
	EXPORT "${TARGETS_EXPORT_NAME}"
	NAMESPACE "${NAMESPACE}"
	DESTINATION "${CONFIG_INSTALL_DIR}"
)
