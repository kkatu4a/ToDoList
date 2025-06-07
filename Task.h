#ifndef TASK_H
#define TASK_H
#include <QObject>
#include <QString>

class Task : public QObject {
    Q_OBJECT

public:
    Task(int id, QString title, QString note, int priority, QString date, bool check, QObject* parent = nullptr)
        : QObject(parent), t_id(id), t_title(title), t_note(note), t_priority(priority), t_date(date), t_check(check) {}

    int id() const { return t_id; }
    QString title() const { return t_title; }
    QString note() const { return t_note; }
    int priority() const { return t_priority; }
    QString date() const { return t_date; }
    bool check() const { return t_check; }

private:
    int t_id;
    QString t_title;
    QString t_note;
    int t_priority;
    QString t_date;
    bool t_check;
};


#endif // TASK_H
