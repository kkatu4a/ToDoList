import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: darkBackground
    anchors.fill: parent
    color: "#80000000"
    visible: false
    z: 10

    signal taskCreated(string taskDate)

    MouseArea {
        anchors.fill: parent
        onClicked: darkBackground.visible = false
    }

    Rectangle {
        width: parent.width - 200
        height: parent.height - 100
        anchors.centerIn: parent
        color: lightTheme ? "#FFFFFF" : "#333333"
        radius: 5

        Popup {
            id: errorPopup
            anchors.centerIn: parent
            width: parent.width / 1.5
            height: parent.height / 3
            modal: true
            focus: true
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

            function showError(message) {
                console.log("Showing error:", message);
                errorText.text = message;
                open();
            }
            onClosed: errorText.text = ""
            MouseArea {
                anchors.fill: parent
                onClicked: errorPopup.close()
            }
        }

        Text {
            id: name_do
            anchors.horizontalCenter: parent.horizontalCenter
            y: 10
            color: lightTheme ? "black" : "white"
            font.bold: true
            font.pixelSize: parent.height / 14
            text: "Создание дела"
        }

        Text {
            id: data
            x: 10
            y: name_do.y + name_do.height + 10
            color: lightTheme ? "black" : "white"
            font.pixelSize: parent.height / 24
            text: "Дата"
        }

        TextField {
            id: dateField
            width: parent.width - 20
            height: parent.height / 14
            anchors.horizontalCenter: parent.horizontalCenter
            y: data.y + data.height + 5
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
            onTextChanged: {
                var text = dateField.text;
                var validPattern = /^[0-3][0-9]\.[0-1][0-9]\.[0-9]{4}$/;
                if (!validPattern.test(text)) {
                    dateField.text = text.replace(/[^0-9.]/g, "");
                }
            }
        }

        Text {
            id: todo
            x: 10
            y: dateField.y + dateField.height + 10
            color: lightTheme ? "black" : "white"
            font.pixelSize: parent.height / 24
            text: "Дело"
        }

        TextField {
            id: todoField
            width: parent.width - 20
            height: parent.height / 14
            anchors.horizontalCenter: parent.horizontalCenter
            y: todo.y + todo.height + 5
            placeholderText: "Введите название"
            placeholderTextColor: lightTheme ? "gray" : "lightgray"
            font {
                pixelSize: todoField.height / 2
            }
            color: lightTheme ? "black" : "white"
            maximumLength: 46
            background: Rectangle {
                color: lightTheme ? "#FFFFFF" : "#333333"
                border.color: lightTheme ? "black" : "white"
                radius: 4
            }
        }

        Text {
            id: priority
            x: 10
            y: todoField.y + todoField.height + 10
            color: lightTheme ? "black" : "white"
            font.pixelSize: parent.height / 24
            text: "Приоритет"
        }

        TextField {
            id: priorityField
            width: parent.width - 20
            height: parent.height / 14
            anchors.horizontalCenter: parent.horizontalCenter
            y: priority.y + priority.height + 5
            placeholderText: "Введите приоритет (1-5)"
            placeholderTextColor: lightTheme ? "gray" : "lightgray"
            color: lightTheme ? "black" : "white"
            font {
                pixelSize: priorityField.height / 2
            }
            maximumLength: 1
            validator: IntValidator { bottom: 1; top: 5 }
            background: Rectangle {
                color: lightTheme ? "#FFFFFF" : "#333333"
                border.color: lightTheme ? "black" : "white"
                radius: 4
            }
        }

        Text {
            id: note
            x: 10
            y: priorityField.y + priorityField.height + 10
            color: lightTheme ? "black" : "white"
            font.pixelSize: parent.height / 24
            text: "Заметка"
        }

        TextField {
            id: noteField
            width: parent.width - 20
            height: parent.height / 14
            anchors.horizontalCenter: parent.horizontalCenter
            y: note.y + note.height + 5
            placeholderText: "Введите заметку"
            placeholderTextColor: lightTheme ? "gray" : "lightgray"
            color: lightTheme ? "black" : "white"
            font {
                pixelSize: noteField.height / 2
            }
            maximumLength: 108
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
            height: parent.height / 14
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
                    font.pixelSize: parent.width / 16
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
            height: parent.height / 14
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
                    text: "Создать"
                    color: lightTheme ? "black" : "white"
                    font.bold: true
                    font.pixelSize: parent.width / 16
                    anchors.centerIn: parent
                }
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: bg4.color = lightTheme ? "#E4714F" : "#67392B"
                onExited: bg4.color = lightTheme ? "#FF8C6A" : "#42231A"
                onClicked: {
                    // Проверка обязательных полей
                    if (todoField.text === "") {
                        errorPopup.showError("Название задачи обязательно");
                        return;
                    }
                    if (dateField.text === "") {
                        errorPopup.showError("Дата обязательна");
                        return;
                    }
                    var conversionResult = convertToSqlDate(dateField.text);
                    if (conversionResult.error !== "") {
                        errorPopup.showError(conversionResult.error);
                        return;
                    }
                    var sqlDate = conversionResult.result;
                    var priority = priorityField.text === "" ? 1 : parseInt(priorityField.text);
                    if (priority < 1 || priority > 5) {
                        errorPopup.showError("Приоритет должен быть от 1 до 5");
                        return;
                    }
                    // Проверка существования taskModel
                    if (typeof taskModel !== "undefined" && taskModel && typeof taskModel.addTask === "function") {
                        console.log("Adding task:", todoField.text, noteField.text, priority, sqlDate);
                        taskModel.addTask(
                            todoField.text,
                            noteField.text,
                            priority,
                            sqlDate
                        );
                        // Эмиссия сигнала
                        darkBackground.taskCreated(dateField.text);
                        // Очистка полей
                        dateField.text = "";
                        todoField.text = "";
                        priorityField.text = "";
                        noteField.text = "";
                        // Закрытие диалога
                        darkBackground.visible = false;
                    } else {
                        console.error("taskModel is undefined or does not have addTask method");
                        errorPopup.showError("Ошибка: модель задач не определена");
                    }
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
