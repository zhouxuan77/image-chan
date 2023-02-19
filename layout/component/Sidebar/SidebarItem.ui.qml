import QtQuick 2.9
import QtQuick.Window 2.3

Item {
    width: _root.width
    height: _root.height

    property int select: 0
    property alias icon: _image.source
    property alias text: _text.text
    property alias click: _mouseArea

    Rectangle {
        id: _root
        width: 188
        height: 48
        color: select ? "#666666" : "#333333"
        border.color: select ? "#666666" : "#333333"
        MouseArea {
            id: _mouseArea
            anchors.fill: parent
        }

        Image {
            id: _image
            source: "../../image/icon/home.png"
            anchors.verticalCenter: parent.verticalCenter
            width: 24
            height: 24
            x: 24
        }

        Text {
            id: _text
            text: qsTr("文章管理")
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 14
            color: "#ffffff"
            x: 72
        }
    }
}
