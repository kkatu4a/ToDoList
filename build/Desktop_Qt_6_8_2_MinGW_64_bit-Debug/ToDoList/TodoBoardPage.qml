import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import TasksModel 1.0

Component {
    id: todoBoardPage
    Page {
        property bool taskCompleted: false
        background: Rectangle {
            color: lightTheme ? "#F0F0F0" : "#252427"
        }

        NewMenu {
            id: menu
        }

        Text {
            id: board_text
            x: menu.width + 30
            y: 30
            text: "Доска дел"
            color: lightTheme ? "black" : "white"
            font.pixelSize: titleTextSize
            font.bold: true
        }

        CurrentDate {
            id: data
            x: menu.width + 30
            y: board_text.y + board_text.height + 15
            font.pixelSize: win.width / 40
            format: "d.MM.yyyy, ddd"
            color: lightTheme ? "black" : "white"
            font.bold: true
        }





        Rectangle {
            id: backlog
            x: menu.width + 30
            y: data.y + data.height + 20
            width: (win.width - menu.width) / 2 - 40
            height: win.height - backlog.y - 20
            color: lightTheme ? "#FFFFFF" : "#333333"
            radius: 5
            border.width: 2
            border.color: lightTheme ? "black" : "white"
            Text {
                id: waiting
                font.pixelSize: backlog.width / 14
                anchors.horizontalCenter: parent.horizontalCenter
                y: 15
                font.bold: true
                color: lightTheme ? "black" : "white"
                text: "В ожидании"
            }
            ScrollView {
                anchors.top: waiting.bottom
                anchors.topMargin: 10
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                clip: true
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                ListView {
                    id: waitingListView
                    anchors.fill: parent
                    model: uncompletedTaskModel
                    spacing: 10
                    clip: true
                    cacheBuffer: 0
                    header: Item {
                        width: parent.width
                        height: 10
                    }
                    footer: Item {
                        width: parent.width
                        height: 10
                    }
                    delegate: Component {
                        Rectangle {
                            border.color: lightTheme ? "#CCCCCC" : "#555555"
                            border.width: 1
                            color: lightTheme ? "#FFFFFF" : "#333333"
                            radius: 5
                            width: parent.width - 20
                            height: column.implicitHeight + 20
                            anchors.horizontalCenter: parent.horizontalCenter

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
                                    width: parent.width - 20
                                    spacing: 8

                                    Text {
                                        id: name_t
                                        text: "Название: " + model.title
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
                                        text: "Дата: " + Qt.formatDate(model.date, "dd.MM.yyyy")
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
                                        text: "Приоритет: " + model.priority
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
                                        text: "Заметка: " + model.note
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
                            }
                        }
                    }
                }
            }
        }

        Rectangle {
            id: backlog2
            x: backlog.x + backlog.width + 20
            y: data.y + data.height + 20
            width: (win.width - menu.width) / 2 - 40
            height: win.height - backlog2.y - 20
            color: lightTheme ? "#FFFFFF" : "#333333"
            radius: 5
            border.width: 2
            border.color: lightTheme ? "black" : "white"
            Text {
                id: completed
                font.pixelSize: backlog.width / 14
                anchors.horizontalCenter: parent.horizontalCenter
                y: 15
                font.bold: true
                color: lightTheme ? "black" : "white"
                text: "Завершенные"
            }
            ScrollView {
                anchors.top: completed.bottom
                anchors.topMargin: 10
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                clip: true
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                ListView {
                    id: completedListView
                    anchors.fill: parent
                    model: completedTaskModel
                    spacing: 10
                    clip: true
                    cacheBuffer: 0
                    header: Item {
                        width: parent.width
                        height: 10
                    }
                    footer: Item {
                        width: parent.width
                        height: 10
                    }
                    delegate: Component {
                        Rectangle {
                            color: lightTheme ? "#FFFFFF" : "#333333"
                            border.color: lightTheme ? "#CCCCCC" : "#555555"
                            border.width: 1
                            radius: 5
                            width: parent.width - 20
                            height: column.implicitHeight + 20
                            anchors.horizontalCenter: parent.horizontalCenter

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
                                    width: parent.width - 20
                                    spacing: 8

                                    Text {
                                        id: name_t
                                        text: "Название: " + model.title
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
                                        text: "Дата: " + Qt.formatDate(model.date, "dd.MM.yyyy")
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
                                        text: "Приоритет: " + model.priority
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
                                        text: "Заметка: " + model.note
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
                            }
                        }
                    }
                }
            }
        }
    }
}
