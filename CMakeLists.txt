cmake_minimum_required(VERSION 3.22)
project(List LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 COMPONENTS Core Quick REQUIRED)
find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick Widgets)

qt_standard_project_setup()

qt_policy(SET QTP0001 NEW)

qt_add_executable(${PROJECT_NAME}
        #        main.cpp

)

qt_add_qml_module(${PROJECT_NAME}
        URI MainApplication
        VERSION 1.0
        QML_FILES
        main.qml
        SOURCES
        main.cpp
        controlls.cpp
        controlls.h
        RESOURCES
        cat.jpg
        kitty.jpg
)

target_link_libraries(${PROJECT_NAME} PRIVATE
        Qt6::Core
        Qt6::Gui
        Qt6::Qml
        Qt6::Quick
        Qt6::Widgets
)