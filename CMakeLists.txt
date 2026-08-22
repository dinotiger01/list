cmake_minimum_required(VERSION 3.20)
project(List LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

if(APPLE)
    file(MAKE_DIRECTORY "${CMAKE_BINARY_DIR}/mock_frameworks/AGL.framework")
    file(WRITE "${CMAKE_BINARY_DIR}/agl_stub.c" "void dummy_agl_symbol(void) {}\n")
    execute_process(
            COMMAND clang -x c "${CMAKE_BINARY_DIR}/agl_stub.c" -shared -o "${CMAKE_BINARY_DIR}/mock_frameworks/AGL.framework/AGL"
            RESULT_VARIABLE CLANG_STUB_RESULT
    )
    set(OPENGL_agl_LIBRARY "${CMAKE_BINARY_DIR}/mock_frameworks/AGL.framework/AGL" CACHE FILEPATH "" FORCE)
    set(WrapOpenGL_FOUND TRUE CACHE BOOL "" FORCE)
endif()

find_package(Qt6 REQUIRED COMPONENTS Core Gui Quick Widgets Sql OpenGL Concurrent)
find_package(SQLite3 REQUIRED)


if(COMMAND qt_policy)
    qt_policy(SET QTP0001 NEW)
    qt_policy(SET QTP0004 NEW)
endif()

add_executable(${PROJECT_NAME} MACOSX_BUNDLE
        main.cpp
)

if(APPLE)
    target_link_options(${PROJECT_NAME} PRIVATE "-F${CMAKE_BINARY_DIR}/mock_frameworks")
endif()

qt_add_qml_module(${PROJECT_NAME}
        URI EngineMod
        VERSION 1.0
        RESOURCE_PREFIX "/qt/qml"
        QML_FILES
        QML/main.qml
        SOURCES
        Engine.h
        Engine.cpp
        data.db
)

target_link_libraries(${PROJECT_NAME} PRIVATE
        Qt6::Core
        Qt6::Gui
        Qt6::Quick
        Qt6::Widgets
        Qt6::Sql
        Qt6::Concurrent
)
target_link_libraries(${PROJECT_NAME} PRIVATE SQLite3::SQLite3)

