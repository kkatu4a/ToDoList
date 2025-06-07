import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: darkBackground
    anchors.fill: parent
    color: "#80000000"
    visible: false
    z: 10

    MouseArea {
        anchors.fill: parent
        onClicked: darkBackground.visible = false
    }

    Rectangle {
        width: parent.width / 2
        height: parent.height / 2
        anchors.centerIn: parent
        color: lightTheme ? "#FFFFFF" : "#333333"
        radius: 5

        Popup {
            id: errorPopup
            anchors.centerIn: parent
            width: parent.width / 1.5
            height: parent.height / 2
            modal: true
            focus: true
            visible: false
            background: Rectangle {
                color: lightTheme ? "#FFFFFF" : "#333333"
                radius: 5
                border.color: lightTheme ? "black" : "white"
                border.width: 1
            }
            Text {
                id: errorText
                anchors.centerIn: parent
                width: parent.width - 20
                color: "red"
                font.pixelSize: parent.width / 14
                wrapMode: Text.Wrap
                text: ""
            }
            MouseArea {
                anchors.fill: parent
                onClicked: errorPopup.visible = false
            }

            function showError(message) {
                errorText.text = message;
                visible = true;
            }
        }

        Text {
            id: name_data
            anchors.horizontalCenter: parent.horizontalCenter
            y: 10
            color: lightTheme ? "black" : "white"
            font.bold: true
            font.pixelSize: parent.width / 14
            text: "Дата"
        }

        TextField {
            id: dateField
            width: parent.width - 20
            height: parent.height / 8
            anchors.horizontalCenter: parent.horizontalCenter
            y: name_data.y + name_data.height + 10
            placeholderText: "ДД.ММ.ГГГГ"
            placeholderTextColor: lightTheme ? "gray" : "lightgray"
            color: lightTheme ? "black" : "white"
            font {
                pixelSize: dateField.height / 2
            }
            maximumLength: 10
            inputMask: "99.99.9999"
            background: Rectangle {
                color: lightTheme ? "#FFFFFF" : "#333333"
                border.color: lightTheme ? "black" : "white"
                radius: 4
            }
        }

        Button {
            id: close
            hoverEnabled: false
            width: parent.width / 2 - 20
            height: parent.height / 8
            x: 10
            y: parent.height - close.height - 10

            background: Rectangle {
                id: bg3
                anchors.fill: parent
                color: lightTheme ? "#FF8C6A" : "#42231A"
                border.color: lightTheme ? "black" : "white"
                border.width: 2
                radius: 5
                Text {
                    text: "Закрыть"
                    color: lightTheme ? "black" : "white"
                    font.bold: true
                    font.pixelSize: parent.width / 10
                    anchors.centerIn: parent
                }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: bg3.color = lightTheme ? "#E4714F" : "#67392B"
                onExited: bg3.color = lightTheme ? "#FF8C6A" : "#42231A"
                onClicked: darkBackground.visible = false
            }
        }

        Button {
            id: choose
            hoverEnabled: false
            width: parent.width / 2 - 20
            height: parent.height / 8
            x: parent.width - choose.width - 10
            y: parent.height - close.height - 10

            background: Rectangle {
                id: bg4
                anchors.fill: parent
                color: lightTheme ? "#FF8C6A" : "#42231A"
                border.color: lightTheme ? "black" : "white"
                border.width: 2
                radius: 5
                Text {
                    text: "Выбрать"
                    color: lightTheme ? "black" : "white"
                    font.bold: true
                    font.pixelSize: parent.width / 10
                    anchors.centerIn: parent
                }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: bg4.color = lightTheme ? "#E4714F" : "#67392B"
                onExited: bg4.color = lightTheme ? "#FF8C6A" : "#42231A"
                onClicked: {
                    var conversionResult = convertToSqlDate(dateField.text);
                    if (dateField.text === "" || conversionResult.error !== "") {
                        errorPopup.showError(conversionResult.error || "Дата не введена или введена некорректно. Используйте формат ДД.ММ.ГГГГ.");
                        return;
                    }
                    var sqlDate = conversionResult.result;
                    taskModel.refreshModel(sqlDate);
                    dateField.text = "";
                    darkBackground.visible = false;
                }
            }
        }
    }

    function convertToSqlDate(dateString) {
        if (!dateString) {
            return { result: "", error: "QML date is empty or undefined" };
        }

        var dateRegex = /^(\d{2})\.(\d{2})\.(\d{4})$/;
        var match = dateRegex.exec(dateString);
        if (!match) {
            return { result: "", error: "Неверный формат QML даты. Ожидается ДД.ММ.ГГГГ, получено: " + dateString };
        }

        var day = parseInt(match[1], 10);
        var month = parseInt(match[2], 10);
        var year = parseInt(match[3], 10);

        if (month < 1 || month > 12) {
            return { result: "", error: "Недопустимый месяц: " + dateString };
        }
        if (day < 1 || day > 31) {
            return { result: "", error: "Недопустимый день: " + dateString };
        }

        var date = new Date(year, month - 1, day);
        if (date.getFullYear() !== year || date.getMonth() + 1 !== month || date.getDate() !== day) {
            return { result: "", error: "Недопустимая дата: " + dateString };
        }

        if (month === 2) {
            var isLeap = (year % 4 === 0 && year % 100 !== 0) || (year % 400 === 0);
            if (day > (isLeap ? 29 : 28)) {
                return { result: "", error: "Недопустимый день для февраля: " + dateString };
            }
        } else if ([4, 6, 9, 11].includes(month) && day > 30) {
            return { result: "", error: "Недопустимый день для месяца с 30 днями: " + dateString };
        }

        return {
            result: year + "-" + month.toString().padStart(2, "0") + "-" + day.toString().padStart(2, "0"),
            error: ""
        };
    }
}
