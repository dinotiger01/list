cmake_minimum_required(VERSION 3.20)
project(QtQmlCppApp LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

# Find components (Added Core explicitly as it helps LinguistTools)
find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick LinguistTools)

# Declare your source files explicitly in a list
set(SOURCES
        main.cpp
        main.qml
)

add_executable(List ${SOURCES})

# Declare the translation source files
set(TS_FILES
        i18n/QtQmlCppApp_de.ts
        i18n/QtQmlCppApp_es.ts
)

# ALTERNATIVE METHOD: Creates the lupdate/lrelease targets safely without
# matching internal CLion directory strings as build targets
qt_create_translation(QM_FILES
        ${SOURCES}
        ${TS_FILES}
)

# Keep your library links
target_link_libraries(List PRIVATE Qt6::Gui Qt6::Qml Qt6::Quick)
configure_file(main.qml ${CMAKE_CURRENT_BINARY_DIR}/main.qml COPYONLY)
