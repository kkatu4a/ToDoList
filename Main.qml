import QtQuick 2.15
import QtQuick.Controls 2.15


ApplicationWindow {
    id: win
    width: 640
    height: 480
    visible: true
    title: qsTr("ToDoListQML")
    property bool lightTheme: true
    property int titleTextSize: win.width/34
    property int buttonDateHeight: win.height/20

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: todoBoardPage
    }
    TodoListPage {
        id: todoListPage
    }
    TodoBoardPage {
        id: todoBoardPage
    }
    StatsPage {
        id: statsPage
    }
    HelpPage {
        id: helpPage
    }


}
