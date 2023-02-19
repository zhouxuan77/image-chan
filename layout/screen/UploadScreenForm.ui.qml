import QtQuick 2.15
import QtQuick.Controls 2.15

import "../component/CButton/"
import "../component/GalleryView"

Item {
    width: _root.width
    height: _root.height

    property alias button01: _button01
    property alias button02: _button02
    property alias tipsText: _text.text
    property alias helpText: _helpText.text
    property alias galleryView: _galleryView

    Rectangle {
        id: _root
        width: 612
        height: 500
        color: "#ffffff"

        GalleryView {
            id: _galleryView
            y: 46
            anchors.horizontalCenter: parent.horizontalCenter
            listAdapter: adapter
        }

        Rectangle {
            color: "#D8D8D8"
            height: 0.5
            width: 564
            x: 25
            y: 422
        }

        CButton {
            id: _button01
            theme: 0
            text: "上传"
            x: 500
            y: 438
        }

        CButton {
            id: _button02
            theme: 1
            text: qsTr("刷新")
            x: 388
            y: 438
        }

        Text {
            id: _text
            x: 24
            y: 446
            color: "#666666"
            text: qsTr("这里什么都没有喵~")
            font.pixelSize: 16
        }

        Text {
            id: _helpText
            x: 24
            y: 473
            color: "#999999"
            font.pixelSize: 10
            text: "长按删除，单击返回压缩"
        }
    }
}
