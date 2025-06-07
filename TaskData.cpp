#include "TaskData.h"

int TaskData::rowCount(const QModelIndex& parent) const {
    Q_UNUSED(parent);
    return t_data.size();
}

QHash<int, QByteArray> TaskData::roleNames() const {
    return {
        {taskTitle, "title"},
        {taskNote, "note"},
        {taskDate, "date"},
        {taskPriority, "priority"},
        {taskCheck, "check"},
        {taskID, "id"}
    };
}

QVariant TaskData::data(const QModelIndex& index, int role) const {
    if (!index.isValid() || index.row() >= t_data.size()) return QVariant();

    const auto& item = t_data[index.row()];
    switch (role) {
    case taskTitle:  return item->title();
    case taskNote: return item->note();
    case taskPriority: return item->priority();
    case taskDate: return item->date();
    case taskCheck: return item->check();
    case taskID: return item->id();
    default: return QVariant();
    }
}

void TaskData::loadTasks(const QString date) {
    beginResetModel();
    for (auto item : t_data) {
        delete item;
    }
    t_data.clear();

    SQLite::Statement tasks(db.db, "SELECT * FROM todo WHERE date = ? ORDER BY priority DESC");
    tasks.bind(1, date.toStdString());

    while (tasks.executeStep()) {
        Task* task = new Task(
            tasks.getColumn(0).getInt(),
            QString::fromStdString(tasks.getColumn(1).getString()),
            tasks.getColumn(2).getString().empty() ? "Описание отсутствует" : QString::fromStdString(tasks.getColumn(2).getString()),
            tasks.getColumn(3).getInt(),
            QString::fromStdString(tasks.getColumn(4).getString()),
            tasks.getColumn(5).getInt() != 0
            );
        t_data.emplace_back(task);
    }

    endResetModel();
}

void TaskData::loadUncompletedTasks(const QString date) {
    beginResetModel();
    for (auto item : t_data) {
        delete item;
    }
    t_data.clear();

    SQLite::Statement tasks(db.db, "SELECT * FROM todo WHERE date = ? AND checked = 0 ORDER BY priority DESC");
    tasks.bind(1, date.toStdString());

    while (tasks.executeStep()) {
        Task* task = new Task(
            tasks.getColumn(0).getInt(),
            QString::fromStdString(tasks.getColumn(1).getString()),
            tasks.getColumn(2).getString().empty() ? "Описание отсутствует" : QString::fromStdString(tasks.getColumn(2).getString()),
            tasks.getColumn(3).getInt(),
            QString::fromStdString(tasks.getColumn(4).getString()),
            tasks.getColumn(5).getInt() != 0
            );
        t_data.emplace_back(task);
    }

    endResetModel();
}

void TaskData::loadCompletedTasks(const QString date) {
    beginResetModel();
    for (auto item : t_data) {
        delete item;
    }
    t_data.clear();

    SQLite::Statement tasks(db.db, "SELECT * FROM todo WHERE date = ? AND checked = 1 ORDER BY priority DESC");
    tasks.bind(1, date.toStdString());

    while (tasks.executeStep()) {
        Task* task = new Task(
            tasks.getColumn(0).getInt(),
            QString::fromStdString(tasks.getColumn(1).getString()),
            tasks.getColumn(2).getString().empty() ? "Описание отсутствует" : QString::fromStdString(tasks.getColumn(2).getString()),
            tasks.getColumn(3).getInt(),
            QString::fromStdString(tasks.getColumn(4).getString()),
            tasks.getColumn(5).getInt() != 0
            );
        t_data.emplace_back(task);
    }

    endResetModel();
}

void TaskData::refreshModel(const QString date) {
    qDebug() << "Refreshing model for date:" << date;
    loadTasks(date);
    qDebug() << "Loaded tasks:" << t_data.size();
    emit modelUpdate();
}

bool TaskData::updateTask(int taskId, QString title, QString note, int priority, QString date) {
    if (title.isEmpty()) {
        emit showError();
        return false;
    }

    SQLite::Statement query(db.db, "UPDATE todo SET title = ?, note = ?, priority = ?, date = ? WHERE id = ?");
    query.bind(1, title.toStdString());
    query.bind(2, note.isEmpty() ? "" : note.toStdString());
    query.bind(3, priority);
    query.bind(4, date.toStdString());
    query.bind(5, taskId);

    query.exec();
    refreshModel(date);
    emit taskUpdated(taskId, date);
    return true;
}

void TaskData::deleteTask(const int taskId) {
    SQLite::Statement query(db.db, "DELETE FROM todo WHERE id = ?");
    query.bind(1, taskId);
    query.exec();
    QString date;
    for (const auto& task : t_data) {
        if (task->id() == taskId) {
            date = task->date();
            break;
        }
    }
    refreshModel(date.isEmpty() ? QDate::currentDate().toString("yyyy-MM-dd") : date);
    emit taskDeleted(taskId, date.isEmpty() ? QDate::currentDate().toString("yyyy-MM-dd") : date);
}

void TaskData::addTask(const QString title, const QString note, const int priority, const QString date) {
    int effectivePriority = (priority <= 0) ? 1 : priority;

    SQLite::Statement query(db.db, "INSERT INTO todo (title, note, priority, date, checked) VALUES (?, ?, ?, ?, ?)");
    query.bind(1, title.toStdString());
    query.bind(2, note.toStdString());
    query.bind(3, effectivePriority);
    query.bind(4, date.toStdString());
    query.bind(5, 0);
    query.exec();
    refreshModel(date);
    emit taskAdded(date);
}

void TaskData::completeTask(const int taskId, const bool checked) {
    SQLite::Statement query(db.db, "UPDATE todo SET checked = ? WHERE id = ?");
    query.bind(1, checked ? 1 : 0);
    query.bind(2, taskId);
    query.exec();
    QString date;
    for (const auto& task : t_data) {
        if (task->id() == taskId) {
            date = task->date();
            break;
        }
    }
    refreshModel(date.isEmpty() ? QDate::currentDate().toString("yyyy-MM-dd") : date);
    emit taskCompleted(taskId, checked, date);
}

int TaskData::getCreatedCount(const QString date) {
    SQLite::Statement query(db.db, "SELECT COUNT(*) FROM todo WHERE date = ?");
    query.bind(1, date.toStdString());
    if (query.executeStep()) {
        return query.getColumn(0).getInt();
    }
    return 0;
}

int TaskData::getCheckedCount(const QString date) {
    SQLite::Statement query(db.db, "SELECT COUNT(*) FROM todo WHERE date = ? AND checked = 1");
    query.bind(1, date.toStdString());
    if (query.executeStep()) {
        return query.getColumn(0).getInt();
    }
    return 0;
}
