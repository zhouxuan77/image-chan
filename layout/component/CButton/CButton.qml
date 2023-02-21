import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.5

CButtonForm {

    signal click()
    signal hover(var type)

    property int theme: 0

    MouseArea {
        hoverEnabled: true
        anchors.fill: parent
        onEntered: { hover(true) }
        onExited: { hover(false) }
        onClicked: { click() }
        onPressed: { parent.pressed = true }
        onReleased: { parent.pressed = false }
    }

    function onPressed() { color = _clickTheme[theme] }
    function onReleased() { color = _normlTheme[theme] }

    onPressedChanged: { pressed ? onPressed() : onReleased() }

    Component.onCompleted: {
        color = _normlTheme[theme]
    }

    property bool pressed: false
    property var _clickTheme: ["#0277BD", "#616161", "#F48FB1"]
    property var _normlTheme: ["#2196F3", "#ADADAD", "#EC407A"]
}
