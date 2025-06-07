cmake_minimum_required(VERSION 3.16)

project(ToDoList VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)
add_subdirectory(SQLiteCpp)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/SQLiteCpp/include)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appToDoList
    main.cpp
)

qt_add_qml_module(appToDoList
    URI ToDoList
    VERSION 1.0
    QML_FILES
        Main.qml
        QML_FILES NewMenu.qml
        QML_FILES TodoListPage.qml
        QML_FILES TodoBoardPage.qml
        QML_FILES StatsPage.qml
        QML_FILES HelpPage.qml
        QML_FILES DialogData.qml
        QML_FILES DialogCreate.qml
        QML_FILES CurrentDate.qml
        SOURCES DataBase.h
        SOURCES GlobalVariables.h
        SOURCES GlobalVariables.cpp
        SOURCES Task.h
        SOURCES TaskData.h
        SOURCES TaskData.cpp
        QML_FILES TaskDelegate.qml
        QML_FILES DialogEdit.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appToDoList PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appToDoList
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appToDoList
    PRIVATE Qt6::Quick
    SQLiteCpp
)

include(GNUInstallDirs)
install(TARGETS appToDoList
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
