import QtQuick 2.15
import QtQuick.Controls 2.15


Component {
    id: helpPage
    Page {
        background: Rectangle {
            color: lightTheme ? "#F0F0F0" : "#252427"
        }
        NewMenu {
            id: menu
        }
        Text {
            id: setting
            x: menu.width + 30
            y: 30
            text: "Настройки"
            color: lightTheme ? "black" : "white"
            font.pixelSize: titleTextSize
            font.bold: true
        }

        Button {
            id: theme
            x: menu.width + 20
            y: setting.y + setting.height + 20
            hoverEnabled: false
            width: win.width - menu.width - 40
            height: win.height/12

            background: Rectangle {
                id: bg
                anchors.fill: parent
                color: lightTheme ? "#FF8C6A" : "#42231A"
                border.color: lightTheme ? "black" : "white"
                border.width: 2
                radius: 5
                Text {
                    text: "Изменить тему"
                    color: lightTheme ? "black" : "white"
                    font.bold: true
                    font.pixelSize: parent.width/36
                    anchors.centerIn: parent
                }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: bg.color = lightTheme ? "#E4714F" : "#67392B"
                onExited: bg.color = lightTheme ? "#FF8C6A" : "#42231A"
                onClicked: lightTheme = !lightTheme
            }
        }
        Button {
            id: information
            x: menu.width + 20
            y: theme.y + theme.height + 10
            hoverEnabled: false
            width: win.width - menu.width - 40
            height: win.height/12

            background: Rectangle {
                id: bg2
                anchors.fill: parent
                color: lightTheme ? "#FF8C6A" : "#42231A"
                border.color: lightTheme ? "black" : "white"
                border.width: 2
                radius: 5
                Text {
                    text: "Информация о приложении"
                    color: lightTheme ? "black" : "white"
                    font.bold: true
                    font.pixelSize: parent.width/36
                    anchors.centerIn: parent
                }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: bg2.color = lightTheme ? "#E4714F" : "#67392B"
                onExited: bg2.color = lightTheme ? "#FF8C6A" : "#42231A"
                onClicked: {
                    Qt.openUrlExternally("https://docs.google.com/document/d/12VnPoI9sjp1FzyQoizf1UeXrwLr-X1k_eGNldydC2DQ/edit?usp=drive_link")
                }
            }
        }
    }
}
