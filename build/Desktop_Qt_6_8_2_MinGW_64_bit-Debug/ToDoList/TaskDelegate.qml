import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: root
    property string taskName: ""
    property int taskPriority: 1
    property string taskDate: ""
    property string taskNote: ""
    property int taskId: -1
    property bool taskCompleted: false
    color: taskCompleted ?
           (lightTheme ? "#F0F0F0" : "#555555") :
           (lightTheme ? "#FFFFFF" : "#333333")
    border.color: lightTheme ? "#CCCCCC" : "#555555"
    border.width: 1
    radius: 5
    width: parent.width
    height: Math.max(column.implicitHeight, buttonColumn.implicitHeight) + 20

    Row {
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            margins: 10
        }
        spacing: 10

        Column {
            id: column
            width: parent.width - buttonColumn.implicitWidth - 20
            spacing: 8

            Text {
                id: name_t
                text: "Название: " + root.taskName
                font.pixelSize: 14
                color: taskCompleted ?
                   (lightTheme ? "#888888" : "#AAAAAA") :
                   (lightTheme ? "black" : "white")
                width: parent.width
                wrapMode: Text.Wrap
                elide: Text.ElideRight
                maximumLineCount: 3
            }

            Text {
                id: date_t
                text: "Дата: " + Qt.formatDate(root.taskDate, "dd.MM.yyyy")
                font.pixelSize: 12
                color: taskCompleted ?
                   (lightTheme ? "#888888" : "#AAAAAA") :
                   (lightTheme ? "black" : "white")
                width: parent.width
                wrapMode: Text.Wrap
                maximumLineCount: 1
            }

            Text {
                id: priority_t
                text: "Приоритет: " + root.taskPriority
                font.pixelSize: 12
                color: taskCompleted ?
                   (lightTheme ? "#888888" : "#AAAAAA") :
                   (lightTheme ? "black" : "white")
                width: parent.width
                wrapMode: Text.Wrap
                maximumLineCount: 1
            }

            Text {
                id: note_t
                text: "Заметка: " + root.taskNote
                font.pixelSize: 12
                color: taskCompleted ?
                   (lightTheme ? "#888888" : "#AAAAAA") :
                   (lightTheme ? "black" : "white")
                width: parent.width
                wrapMode: Text.Wrap
                elide: Text.ElideRight
                maximumLineCount: 3
            }
        }

        Column {
            id: buttonColumn
            spacing: 10
            width: 120

            Button {
                id: edit
                width: parent.width
                height: 30
                hoverEnabled: false
                background: Rectangle {
                    id: bg
                    anchors.fill: parent
                    color: lightTheme ? "#FF8C6A" : "#42231A"
                    border.color: lightTheme ? "black" : "white"
                    border.width: 2
                    radius: 5
                    Text {
                        text: "Редактировать"
                        color: lightTheme ? "black" : "white"
                        font.bold: true
                        font.pixelSize: 12
                        anchors.centerIn: parent
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: bg.color = lightTheme ? "#E4714F" : "#67392B"
                    onExited: bg.color = lightTheme ? "#FF8C6A" : "#42231A"
                    onClicked: {
                        dialoge.setTaskData(
                            root.taskId,
                            root.taskName,
                            root.taskDate,
                            root.taskPriority,
                            root.taskNote
                        );
                    }
                }
            }

            Button {
                id: complete
                width: parent.width
                height: 30
                hoverEnabled: false
                background: Rectangle {
                    id: bg2
                    anchors.fill: parent
                    color: lightTheme ? "#FF8C6A" : "#42231A"
                    border.color: lightTheme ? "black" : "white"
                    border.width: 2
                    radius: 5
                    Text {
                        text: taskCompleted ? "Возобновить" : "Выполнить"
                        color: lightTheme ? "black" : "white"
                        font.bold: true
                        font.pixelSize: 12
                        anchors.centerIn: parent
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: bg2.color = lightTheme ? "#E4714F" : "#67392B"
                    onExited: bg2.color = lightTheme ? "#FF8C6A" : "#42231A"
                    onClicked: {
                        taskModel.completeTask(taskId, !taskCompleted)
                    }
                }
            }

            Button {
                id: del
                width: parent.width
                height: 30
                hoverEnabled: false
                background: Rectangle {
                    id: bg1
                    anchors.fill: parent
                    color: lightTheme ? "#FF8C6A" : "#42231A"
                    border.color: lightTheme ? "black" : "white"
                    border.width: 2
                    radius: 5
                    Text {
                        text: "Удалить"
                        color: lightTheme ? "black" : "white"
                        font.bold: true
                        font.pixelSize: 12
                        anchors.centerIn: parent
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: bg1.color = lightTheme ? "#E4714F" : "#67392B"
                    onExited: bg1.color = lightTheme ? "#FF8C6A" : "#42231A"
                    onClicked: taskModel.deleteTask(taskId)
                }
            }
        }
    }
}
