import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Component {
    id: todoListPage
    Page {

        Component.onCompleted: {
            console.log("Task count (rowCount) before load: " + taskModel.rowCount())
            taskModel.loadTasks()
            console.log("Task count (rowCount) after load: " + taskModel.rowCount())
            console.log("taskModel defined: " + (taskModel !== undefined))
        }
        background: Rectangle {
            color: lightTheme ? "#F0F0F0" : "#252427"
        }

        NewMenu {
            id: menu
        }

        Text {
            id: todo
            x: menu.width + 30
            y: 30
            text: "Список дел"
            color: lightTheme ? "black" : "white"
            font.pixelSize: win.width/34
            font.bold: true
        }

        Button {
            id: data_button
            x: menu.width + 30
            y: todo.y + todo.height + 15
            hoverEnabled: false
            width: parent.width - menu.width - 60
            height: parent.height/16

            background: Rectangle {
                id: bg
                anchors.fill: parent
                color: lightTheme ? "#FF8C6A" : "#42231A"
                border.color: lightTheme ? "black" : "white"
                border.width: 2
                radius: 5
                Text {
                    text: "Дата"
                    color: lightTheme ? "black" : "white"
                    font.bold: true
                    font.pixelSize: parent.height/2
                    anchors.centerIn: parent
                }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: bg.color = lightTheme ? "#E4714F" : "#67392B"
                onExited: bg.color = lightTheme ? "#FF8C6A" : "#42231A"
                onClicked: dialogd.visible = true
            }
        }

        DialogData {
            id: dialogd
        }

        DialogEdit {
            id: dialoge
        }
        Button {
            id: create
            x: menu.width + 30
            y: data_button.y + data_button.height + 10
            width: parent.width - menu.width - 60
            height: parent.height/16
            hoverEnabled: false

            background: Rectangle {
                id: bg1
                anchors.fill: parent
                color: lightTheme ? "#FF8C6A" : "#42231A"
                border.color: lightTheme ? "black" : "white"
                border.width: 2
                radius: 5
                Text {
                    text: "Создать"
                    color: lightTheme ? "black" : "white"
                    font.bold: true
                    font.pixelSize: parent.height/2
                    anchors.centerIn: parent
                }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: bg1.color = lightTheme ? "#E4714F" : "#67392B"
                onExited: bg1.color = lightTheme ? "#FF8C6A" : "#42231A"
                onClicked: dialogc.visible = true
            }
        }

        DialogCreate {
            id: dialogc
        }

        Rectangle {
            id: backlog
            x: menu.width + 30
            y: create.y + create.height + 10
            width: parent.width - menu.width - 60
            height: parent.height - y - 20
            color: "transparent"


            ScrollView {
                anchors.fill: parent
                clip: true
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

                ListView {
                    id: taskListView
                    anchors.fill: parent
                    model: taskModel
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
                    delegate: TaskDelegate {
                        taskName: model.title
                        taskPriority: model.priority
                        taskDate: model.date
                        taskId: model.id
                        taskNote: model.note
                        taskCompleted: model.check
                        width: parent.width - 20
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }
        }
    }
}
