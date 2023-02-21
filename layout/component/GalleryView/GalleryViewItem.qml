import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.2

Item {
    width: _root.width
    height: _root.height

    property alias icon: _image.source
    property alias text: _text.text

    Rectangle {
        id: _root
        width: 132
        height: 132

        Image {
            id: _image
            smooth: true
            width: 128
            height: 128
            x: 2
            y: 2
            asynchronous: true
            fillMode: Image.Stretch
        }

        Rectangle {
            width: 128
            height: 32
            color: Qt.rgba(0, 0, 0, 0.3)
            x: 2
            y: 98

            Text {
                id: _text
                x: 16
                width: 96
                color: "#FFFFFF"
                font.pixelSize: 12
                elide: Text.ElideRight
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}
