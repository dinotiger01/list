cmake_minimum_required(VERSION 3.20)
project(List VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)


find_package(Qt6 REQUIRED COMPONENTS Core Gui Quick Widgets Sql OpenGL Concurrent Svg)
find_package(SQLite3 REQUIRED)
if(COMMAND qt_policy)
    qt_policy(SET QTP0001 NEW)
    qt_policy(SET QTP0004 NEW)
endif()
if(APPLE)
    set(BUNDLE_TYPE MACOSX_BUNDLE)
else()
    set(BUNDLE_TYPE "")
endif()

set(APP_SOURCES
        main.cpp
        Engine.h
        Engine.cpp
)

if(APPLE)
    file(GLOB_RECURSE SQL_FILES "${CMAKE_CURRENT_SOURCE_DIR}/SQL/*")
endif()

add_executable(${PROJECT_NAME} ${BUNDLE_TYPE}
        ${APP_SOURCES}
        ${SQL_FILES} # Informs CMake these belong in the macOS Bundle Resource folder
)

qt_add_qml_module(${PROJECT_NAME}
        URI EngineMod
        VERSION 1.0
        RESOURCE_PREFIX "/qt/qml"
        QML_FILES
        QML/main.qml
        QML/pryQml.qml
        QML/taskQml.qml
        SOURCES
        Engine.h
        Engine.cpp
        RESOURCES
        SVG/check.svg
        SVG/edit.svg
        SVG/garbage.svg
        SVG/home.svg
        SVG/minus.svg
        SVG/plus.svg
        SVG/restart.svg
        SVG/search.svg
        SVG/settings.svg
        SVG/sync.svg
        SVG/up-arrow.svg
        SVG/up-arrow2.svg
        SVG/X.svg

#        SQL/data.db
)

if(APPLE)
    set_target_properties(${PROJECT_NAME} PROPERTIES
            MACOSX_BUNDLE_BUNDLE_NAME "ListApp"
            MACOSX_BUNDLE_GUI_IDENTIFIER "com.example.listapp"
            MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION}
    )
    if(SQL_FILES)
        set_target_properties(${PROJECT_NAME} PROPERTIES
                RESOURCE "${SQL_FILES}"
        )
    endif()
endif()

target_include_directories(${PROJECT_NAME} PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}/SQL
        ${CMAKE_CURRENT_SOURCE_DIR}/QML
        ${CMAKE_CURRENT_SOURCE_DIR}/SVG
)

target_link_libraries(${PROJECT_NAME} PRIVATE
        Qt6::Core
        Qt6::Gui
        Qt6::Quick
        Qt6::Widgets
        Qt6::Sql
        Qt6::Concurrent
        Qt6::Svg
        SQLite3::SQLite3
)
target_link_libraries(${PROJECT_NAME} PRIVATE SQLite3::SQLite3)

if(NOT APPLE)
    add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
            COMMAND ${CMAKE_COMMAND} -E copy_directory
            "${CMAKE_CURRENT_SOURCE_DIR}/SQL"
            "$<TARGET_FILE_DIR:${PROJECT_NAME}>/SQL"
            COMMAND ${CMAKE_COMMAND} -E copy_directory
            "${CMAKE_CURRENT_SOURCE_DIR}/SVG"
            "$<TARGET_FILE_DIR:${PROJECT_NAME}>/SVG"
    )
endif()




