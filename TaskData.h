#ifndef TASKDATA_H
#define TASKDATA_H
#include <QAbstractListModel>
#include <vector>
#include <QDate>
#include "GlobalVariables.h"
#include "Task.h"
#include "DataBase.h"

class TaskData : public QAbstractListModel {
    Q_OBJECT
private:
    std::vector<Task*> t_data;
    DataBase db;
public:
    enum Roles {
        taskTitle = Qt::UserRole + 1,
        taskNote,
        taskDate,
        taskPriority,
        taskCheck,
        taskID,
    };
    explicit TaskData(QObject* parent = nullptr) : QAbstractListModel(parent), db(Global::getDatabasePath()) {}
    int rowCount(const QModelIndex& parent = QModelIndex()) const override;
    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex& index, int role) const override;

    Q_INVOKABLE void loadTasks(const QString date = QDate::currentDate().toString("yyyy-MM-dd"));
    Q_INVOKABLE void loadUncompletedTasks(const QString date = QDate::currentDate().toString("yyyy-MM-dd"));
    Q_INVOKABLE void loadCompletedTasks(const QString date = QDate::currentDate().toString("yyyy-MM-dd"));
    Q_INVOKABLE void refreshModel(const QString date = QDate::currentDate().toString("yyyy-MM-dd"));
    Q_INVOKABLE bool updateTask(int taskId, QString title, QString note, int priority, QString date);
    Q_INVOKABLE void deleteTask(const int taskId);
    Q_INVOKABLE void addTask(const QString title, const QString note, const int priority, const QString date);
    Q_INVOKABLE void completeTask(const int taskId, const bool checked);
    Q_INVOKABLE int getCreatedCount(const QString date);
    Q_INVOKABLE int getCheckedCount(const QString date);

signals:
    void showError();
    void modelUpdate();
    void taskCompleted(int taskId, bool checked, const QString &date);
    void taskDeleted(int taskId, const QString &date);
    void taskAdded(const QString &date);
    void taskUpdated(int taskId, const QString &date);
};

#endif // TASKDATA_H
