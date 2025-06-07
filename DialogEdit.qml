import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: darkBackground
    anchors.fill: parent
    color: "#80000000"
    visible: false
    z: 10

    property string taskName: ""
    property string taskDate: ""
    property int taskPriority: 1
    property string taskNote: ""
    property int taskId: -1

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
            text: "Редактирование дела"
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
            text: darkBackground.taskDate
            background: Rectangle {
                color: lightTheme ? "#FFFFFF" : "#333333"
                border.color: lightTheme ? "black" : "white"
                radius: 4
            }
            onTextChanged: {
                var text = dateField.text;
                var validPattern = /^[0-9.]*$/;
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
            text: darkBackground.taskName
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
            placeholderText: "Введите приоритет (1-9)"
            placeholderTextColor: lightTheme ? "gray" : "lightgray"
            color: lightTheme ? "black" : "white"
            font {
                pixelSize: priorityField.height / 2
            }
            maximumLength: 1
            text: darkBackground.taskPriority.toString()
            validator: IntValidator { bottom: 1; top: 9 }
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
            text: darkBackground.taskNote
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
                onClicked: {
                    dateField.text = "";
                    todoField.text = "";
                    priorityField.text = "";
                    noteField.text = "";
                    darkBackground.visible = false;
                }
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
                    text: "Сохранить"
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
                    var priority = parseInt(priorityField.text) || 1;
                    if (priority < 1 || priority > 9) {
                        errorPopup.showError("Приоритет должен быть от 1 до 9");
                        return;
                    }
                    if (typeof taskModel !== "undefined" && taskModel && typeof taskModel.updateTask === "function") {
                        console.log("Updating task:", darkBackground.taskId, todoField.text, noteField.text, priority, sqlDate);
                        taskModel.updateTask(
                            darkBackground.taskId,
                            todoField.text,
                            noteField.text,
                            priority,
                            sqlDate
                        );
                        dateField.text = "";
                        todoField.text = "";
                        priorityField.text = "";
                        noteField.text = "";
                        darkBackground.visible = false;
                    } else {
                        errorPopup.showError("Ошибка: модель задач не определена");
                    }
                }
            }
        }
    }

    function setTaskData(id, name, date, priority, note) {
        console.log("Setting task data:", id, name, date, priority, note);
        taskId = id;
        taskName = name;
        var conversionResult = convertToQmlDate(date);
        if (conversionResult.error !== "") {
            errorPopup.showError(conversionResult.error);
            taskDate = "";
            dateField.text = "";
            return;
        }
        taskDate = conversionResult.result;
        taskPriority = priority;
        taskNote = note;
        dateField.text = taskDate;
        todoField.text = name;
        priorityField.text = priority.toString();
        noteField.text = note;
        visible = true;
    }

    function convertToQmlDate(sqlDate) {
        if (!sqlDate) {
            return { result: "", error: "SQL date is empty or undefined" };
        }

        var dateRegex = /^(\d{4})-(\d{2})-(\d{2})$/;
        var match = dateRegex.exec(sqlDate);
        if (!match) {
            return { result: "", error: "Неверный формат SQL даты. Ожидается ГГГГ-ММ-ДД, получено: " + sqlDate };
        }

        var year = parseInt(match[1], 10);
        var month = parseInt(match[2], 10);
        var day = parseInt(match[3], 10);

        if (month < 1 || month > 12) {
            return { result: "", error: "Недопустимый месяц: " + sqlDate };
        }
        if (day < 1 || day > 31) {
            return { result: "", error: "Недопустимый день: " + sqlDate };
        }

        var date = new Date(year, month - 1, day);
        if (date.getFullYear() !== year || date.getMonth() + 1 !== month || date.getDate() !== day) {
            return { result: "", error: "Недопустимая дата: " + sqlDate };
        }

        if (month === 2) {
            var isLeap = (year % 4 === 0 && year % 100 !== 0) || (year % 400 === 0);
            if (day > (isLeap ? 29 : 28)) {
                return { result: "", error: "Недопустимый день для февраля: " + sqlDate };
            }
        } else if ([4, 6, 9, 11].includes(month) && day > 30) {
            return { result: "", error: "Недопустимый день для месяца с 30 днями: " + sqlDate };
        }

        return {
            result: day.toString().padStart(2, "0") + "." + month.toString().padStart(2, "0") + "." + year,
            error: ""
        };
    }

    function convertToSqlDate(qmlDate) {
        if (!qmlDate) {
            return { result: "", error: "QML date is empty or undefined" };
        }

        var dateRegex = /^(\d{2})\.(\d{2})\.(\d{4})$/;
        var match = dateRegex.exec(qmlDate);
        if (!match) {
            return { result: "", error: "Неверный формат QML даты. Ожидается ДД.ММ.ГГГГ, получено: " + qmlDate };
        }

        var day = parseInt(match[1], 10);
        var month = parseInt(match[2], 10);
        var year = parseInt(match[3], 10);

        if (month < 1 || month > 12) {
            return { result: "", error: "Недопустимый месяц: " + qmlDate };
        }
        if (day < 1 || day > 31) {
            return { result: "", error: "Недопустимый день: " + qmlDate };
        }

        var date = new Date(year, month - 1, day);
        if (date.getFullYear() !== year || date.getMonth() + 1 !== month || date.getDate() !== day) {
            return { result: "", error: "Недопустимая дата: " + qmlDate };
        }

        if (month === 2) {
            var isLeap = (year % 4 === 0 && year % 100 !== 0) || (year % 400 === 0);
            if (day > (isLeap ? 29 : 28)) {
                return { result: "", error: "Недопустимый день для февраля: " + qmlDate };
            }
        } else if ([4, 6, 9, 11].includes(month) && day > 30) {
            return { result: "", error: "Недопустимый день для месяца с 30 днями: " + qmlDate };
        }

        return {
            result: year + "-" + month.toString().padStart(2, "0") + "-" + day.toString().padStart(2, "0"),
            error: ""
        };
    }
}
