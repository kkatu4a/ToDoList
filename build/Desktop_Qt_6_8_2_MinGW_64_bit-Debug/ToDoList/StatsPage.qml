import QtQuick 2.15
import QtQuick.Controls 2.15

Component {
    id: statsPage
    Page {
        background: Rectangle {
            color: lightTheme ? "#F0F0F0" : "#252427"
        }

        NewMenu {
            id: menu
        }

        Text {
            id: stat
            x: menu.width + 30
            y: 30
            text: "Статистика"
            color: lightTheme ? "black" : "white"
            font.pixelSize: titleTextSize
            font.bold: true
        }

        CurrentDate {
            id: data
            x: menu.width + 30
            y: stat.y + stat.height + 15
            font.pixelSize: win.width / 40
            format: "d.MM.yyyy, ddd"
            color: lightTheme ? "black" : "white"
            font.bold: true
        }

        Button {
            id: data_button
            x: win.width - width - 30
            y: stat.y + stat.height + 15
            hoverEnabled: false
            width: (parent.width - menu.width) / 3 - 60
            height: parent.height / 20

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
                    font.pixelSize: parent.width / 10
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

        // Диалог выбора даты
        Rectangle {
            id: dialogd
            anchors.fill: parent
            color: "#80000000"
            visible: false
            z: 10

            MouseArea {
                anchors.fill: parent
                onClicked: dialogd.visible = false
            }

            Rectangle {
                width: parent.width / 2
                height: parent.height / 2
                anchors.centerIn: parent
                color: lightTheme ? "#FFFFFF" : "#333333"
                radius: 5

                // Всплывающее окно для ошибок
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
                    // Функция для отображения ошибки
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
                    y: parent.height - height - 10

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
                        onClicked: dialogd.visible = false
                    }
                }

                Button {
                    id: choose
                    hoverEnabled: false
                    width: parent.width / 2 - 20
                    height: parent.height / 8
                    x: parent.width - width - 10
                    y: parent.height - height - 10

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
                            var conversionResult = dialogd.convertToSqlDate(dateField.text);
                            if (dateField.text === "" || conversionResult.error !== "") {
                                errorPopup.showError(conversionResult.error || "Дата не введена или введена некорректно. Используйте формат ДД.ММ.ГГГГ.");
                                return;
                            }
                            var sqlDate = conversionResult.result;
                            taskModel.refreshModel(sqlDate);
                            var createdCount = taskModel.getCreatedCount(sqlDate);
                            var checkedCount = taskModel.getCheckedCount(sqlDate);
                            createdCountText.text = "Создано задач: " + createdCount;
                            checkedCountText.text = "Завершено задач: " + checkedCount;
                            var percentage = createdCount > 0 ? Math.round((checkedCount / createdCount) * 100) : 0;
                            percentageText.text = "Процент выполненных: " + percentage + "%";
                            data.text = dateField.text;
                            dateField.text = "";
                            dialogd.visible = false;
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

        // Отображение количества созданных задач
        Text {
            id: createdCountText
            x: menu.width + 30
            y: data.y + data.height + 30
            text: "Создано задач: " + taskModel.getCreatedCount(Qt.formatDateTime(new Date(), "yyyy-MM-dd"))
            color: lightTheme ? "black" : "white"
            font.pixelSize: win.width / 45
        }

        // Отображение количества завершённых задач
        Text {
            id: checkedCountText
            x: menu.width + 30
            y: createdCountText.y + createdCountText.height + 15
            text: "Завершено задач: " + taskModel.getCheckedCount(Qt.formatDateTime(new Date(), "yyyy-MM-dd"))
            color: lightTheme ? "black" : "white"
            font.pixelSize: win.width / 45
        }

        // Отображение процента выполненных задач
        Text {
            id: percentageText
            x: menu.width + 30
            y: checkedCountText.y + checkedCountText.height + 15
            text: {
                var created = taskModel.getCreatedCount(Qt.formatDateTime(new Date(), "yyyy-MM-dd"));
                var checked = taskModel.getCheckedCount(Qt.formatDateTime(new Date(), "yyyy-MM-dd"));
                var percentage = created > 0 ? Math.round((checked / created) * 100) : 0;
                "Процент выполненных: " + percentage + "%"
            }
            color: lightTheme ? "black" : "white"
            font.pixelSize: win.width / 45
        }
    }
}
