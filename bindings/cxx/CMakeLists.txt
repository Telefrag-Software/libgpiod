cmake_minimum_required(VERSION 3.5...4.2.1 FATAL_ERROR)

set(WRAPPER_NAME libgpiodcxx)

add_library(${WRAPPER_NAME}
	chip-info.cpp
	chip.cpp
	edge-event-buffer.cpp
	edge-event.cpp
	exception.cpp
	info-event.cpp
	internal.hpp
	internal.cpp
	line-config.cpp
	line-info.cpp
	line-request.cpp
	line-settings.cpp
	line.cpp
	misc.cpp
	request-builder.cpp
	request-config.cpp
)

add_library(${PROJECT_NAME}::${WRAPPER_NAME} ALIAS ${WRAPPER_NAME})

target_sources(${WRAPPER_NAME}
	PUBLIC
		FILE_SET HEADERS
		TYPE HEADERS
		BASE_DIRS
			${CMAKE_CURRENT_SOURCE_DIR}
		FILES
			gpiod.hpp
			gpiodcxx/chip-info.hpp
			gpiodcxx/chip.hpp
			gpiodcxx/edge-event.hpp
			gpiodcxx/edge-event-buffer.hpp
			gpiodcxx/exception.hpp
			gpiodcxx/info-event.hpp
			gpiodcxx/line-config.hpp
			gpiodcxx/line-info.hpp
			gpiodcxx/line-request.hpp
			gpiodcxx/line-settings.hpp
			gpiodcxx/line.hpp
			gpiodcxx/misc.hpp
			gpiodcxx/request-builder.hpp
			gpiodcxx/request-config.hpp
			gpiodcxx/timestamp.hpp
)

target_include_directories(${WRAPPER_NAME}
	PUBLIC
		$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/bindings/cxx/gpiodcxx>
		$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)

set_target_properties(${WRAPPER_NAME} PROPERTIES
	CXX_STANDARD 17
	CXX_STANDARD_REQUIRED ON
)

target_link_libraries(${WRAPPER_NAME}
	PUBLIC
		${LIBRARY_NAME}
)

install(
	TARGETS ${WRAPPER_NAME}
	EXPORT "${TARGETS_EXPORT_NAME}"
	LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
	ARCHIVE DESTINATION "${CMAKE_INSTALL_LIBDIR}"
	RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
	FILE_SET HEADERS
		DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)

install(
	FILES ${WRAPPER_HEADER_FILES}
	DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)
