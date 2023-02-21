import QtQuick 2.9
import QtQuick.Window 2.3

Item {
    width: _root.width
    height: _root.height

    property alias color: _root.color
    property alias text: _text.text

    Rectangle {
        id: _root
        width: 88
        height: 38
        radius: 7

        Text {
            id: _text
            text: "替换"
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 16
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#FFFFFF"
        }
    }
}
