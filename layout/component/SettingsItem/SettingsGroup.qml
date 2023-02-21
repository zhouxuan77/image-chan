import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    width: _root.width
    height: _root.height

    property alias title: _text.text

    Rectangle {
        id: _root
        width: 284
        height: 41

        Text {
            id: _text
            x: 16
            y: 16
            color: "#999999"
            text: "设置组标题"
            font.pixelSize: 12
            font.weight: Font.DemiBold
        }
    }
}
