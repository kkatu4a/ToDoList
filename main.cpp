#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QFont>
#include <filesystem>
#include "DataBase.h"
#include "GlobalVariables.h"
#include "Task.h"
#include "TaskData.h"

void prepareGlobalVariables(char *argv[]){
    Global::setProjectName("ToDoList");

    std::filesystem::path exePath = argv[0];
    std::string thisPath = exePath.string();
    thisPath.erase(thisPath.begin() + thisPath.find(Global::getProjectName()), thisPath.end());

    Global::setProjectPath(thisPath + Global::getProjectName());
    Global::setDatabasePath(Global::getProjectPath() + "\\todo.db");
}

void prepareDB(){
    DataBase database(Global::getDatabasePath());
    qDebug() << "Database status in main():";
    database.db.exec("CREATE TABLE IF NOT EXISTS todo (id INTEGER PRIMARY KEY AUTOINCREMENT, "
                     "title TEXT NOT NULL, "
                     "note TEXT, "
                     "priority INTEGER DEFAULT 1, "
                     "date TEXT NOT NULL, "
                     "checked BOOLEAN DEFAULT FALSE)");
}

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QFont defaultFont("Montserrat");
    app.setFont(defaultFont);
    prepareGlobalVariables(argv);
    prepareDB();

    qmlRegisterType<TaskData>("TasksModel", 1, 0, "TaskData");
    qmlRegisterType<Task>("TaskModel", 1, 0, "Task");

    QQmlApplicationEngine engine;

    TaskData* taskModel = new TaskData(&engine);
    taskModel->loadTasks();
    engine.rootContext()->setContextProperty("taskModel", taskModel);

    TaskData* uncompletedTaskModel = new TaskData(&engine);
    uncompletedTaskModel->loadUncompletedTasks();
    engine.rootContext()->setContextProperty("uncompletedTaskModel", uncompletedTaskModel);

    TaskData* completedTaskModel = new TaskData(&engine);
    completedTaskModel->loadCompletedTasks();
    engine.rootContext()->setContextProperty("completedTaskModel", completedTaskModel);

    QObject::connect(taskModel, &TaskData::taskCompleted, uncompletedTaskModel, [uncompletedTaskModel](int taskId, bool checked, const QString &date) {
        uncompletedTaskModel->loadUncompletedTasks(QDate::currentDate().toString("yyyy-MM-dd"));
    });

    QObject::connect(taskModel, &TaskData::taskCompleted, completedTaskModel, [completedTaskModel](int taskId, bool checked, const QString &date) {
        completedTaskModel->loadCompletedTasks(QDate::currentDate().toString("yyyy-MM-dd"));
    });

    QObject::connect(taskModel, &TaskData::taskDeleted, uncompletedTaskModel, [uncompletedTaskModel](int taskId, const QString &date) {
        uncompletedTaskModel->loadUncompletedTasks(QDate::currentDate().toString("yyyy-MM-dd"));
    });

    QObject::connect(taskModel, &TaskData::taskDeleted, completedTaskModel, [completedTaskModel](int taskId, const QString &date) {
        completedTaskModel->loadCompletedTasks(QDate::currentDate().toString("yyyy-MM-dd"));
    });

    QObject::connect(taskModel, &TaskData::taskAdded, uncompletedTaskModel, [uncompletedTaskModel](const QString &date) {
        uncompletedTaskModel->loadUncompletedTasks(QDate::currentDate().toString("yyyy-MM-dd"));
    });

    QObject::connect(taskModel, &TaskData::taskAdded, completedTaskModel, [completedTaskModel](const QString &date) {
        completedTaskModel->loadCompletedTasks(QDate::currentDate().toString("yyyy-MM-dd"));
    });

    QObject::connect(taskModel, &TaskData::taskUpdated, uncompletedTaskModel, [uncompletedTaskModel](int taskId, const QString &date) {
        uncompletedTaskModel->loadUncompletedTasks(QDate::currentDate().toString("yyyy-MM-dd"));
    });

    QObject::connect(taskModel, &TaskData::taskUpdated, completedTaskModel, [completedTaskModel](int taskId, const QString &date) {
        completedTaskModel->loadCompletedTasks(QDate::currentDate().toString("yyyy-MM-dd"));
    });

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("ToDoList", "Main");

    return app.exec();
}
