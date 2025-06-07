import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: menu
    width: win.width/4
    height: win.height
    anchors.left: win.left
    color: lightTheme ? "#FFC4B3" : "#50372F"

    Text {
        id: name
        y: 20
        text: "ToDoList"
        color: "#FF8C6A"
        font.pixelSize: list.width/6
        font.bold: true
        anchors.horizontalCenter: parent.horizontalCenter
    }
    
    Button {
        id: list
        anchors.horizontalCenter: parent.horizontalCenter
        y: name.y + name.height + 15
        hoverEnabled: false
        width: menu.width
        height: win.height/12
        
        background: Rectangle {
            id: bg1
            anchors.fill: parent
            color: "transparent"
            Text {
                text: "Список дел"
                color: lightTheme ? "black" : "white"
                font.pixelSize: list.width/10
                anchors.centerIn: parent
            }
        }
        
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: bg1.color = lightTheme ? "#F6B09C" : "#734F45"
            onExited: bg1.color = "transparent"
            onClicked: stackView.replace(todoListPage)
        }

    }
    
    Button {
        id: board
        anchors.horizontalCenter: parent.horizontalCenter
        y: list.y + list.height
        hoverEnabled: false
        width: menu.width
        height: win.height/12
        
        background: Rectangle {
            id: bg2
            anchors.fill: parent
            color: "transparent"
            Text {
                text: "Доска дел"
                color: lightTheme ? "black" : "white"
                font.pixelSize: board.width/10
                anchors.centerIn: parent
            }
        }
        
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: bg2.color = lightTheme ? "#F6B09C" : "#734F45"
            onExited: bg2.color = "transparent"
            onClicked: stackView.replace(todoBoardPage)
        }

    }
    
    Button {
        id: progress
        anchors.horizontalCenter: parent.horizontalCenter
        y: board.y + board.height
        hoverEnabled: false
        width: menu.width
        height: win.height/12
        
        background: Rectangle {
            id: bg3
            anchors.fill: parent
            color: "transparent"
            Text {
                text: "Статистика"
                color: lightTheme ? "black" : "white"
                font.pixelSize: progress.width/10
                anchors.centerIn: parent
            }
        }
        
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: bg3.color = lightTheme ? "#F6B09C" : "#734F45"
            onExited: bg3.color = "transparent"
            onClicked: stackView.replace(statsPage)
        }

    }
    Button {
        id: info
        anchors.bottom: parent.bottom
        hoverEnabled: false
        width: menu.width
        height: win.height/6
        
        background: Rectangle {
            id: bg4
            anchors.fill: parent
            color: "transparent"
            Text {
                text: "Настройки"
                color: lightTheme ? "black" : "white"
                font.pixelSize: info.width/10
                anchors.centerIn: parent
            }
        }
        
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: bg4.color = lightTheme ? "#F6B09C" : "#734F45"
            onExited: bg4.color = "transparent"
            onClicked: stackView.replace(helpPage)
        }
    }
}
