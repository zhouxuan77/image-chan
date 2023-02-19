import QtQuick 2.15
import QtQuick.Window
import QtQuick.Controls 2.15

Item {
    width: _root.width
    height: _root.height

    property alias title: _title.text
    property alias edit: _content

    Rectangle {
        id: _root
        width: 290
        height: 54

        Text {
            id: _title
            x: 16
            y: 8
            text: "设置项标题"
            font.pixelSize: 16
        }

        TextEdit {
            id: _content
            x: 16
            y: 29
            width: 274
            height: 17
            color: "#999999"
            text: "待设置内容"
            font.pixelSize: 13
            wrapMode: TextArea.Wrap
            selectByMouse: true
        }
    }
}
