import QtQuick 2.9
import QtQuick.Window 2.3

import "../component/CButton/"

Item {
    width: _root.width
    height: _root.height

    property alias imageClick: _mouseArea
    property int imageResult: 0
    property alias button01: _button01
    property alias button02: _button02
    property alias tipsText: _tipsText.text
    property alias helpText: _helpText.text

    Rectangle {
        id: _root
        width: 612
        height: 500
        color: "#FFFFFF"

        BorderImage {
            id: _image
            source: imageResult
                    === 0 ? "../image/svg/article_normal.png" : "../image/svg/article_success.png"
            width: 340
            height: 340
            x: 146
            y: 70
            border.left: 5
            border.top: 5
            border.right: 5
            border.bottom: 5
            MouseArea {
                id: _mouseArea
                anchors.fill: parent
            }
        }

        CButton {
            id: _button01
            theme: 0
            text: "保存"
            x: 500
            y: 438
        }

        CButton {
            id: _button02
            theme: 1
            text: "替换"
            x: 388
            y: 438
        }

        Text {
            id: _tipsText
            x: 24
            y: 453
            color: "#666666"
            text: "单击图片导入 Markdown 文章"
            font.pixelSize: 16
        }

        Text {
            id: _helpText
            x: 24
            y: 480
            color: "#999999"
            font.pixelSize: 10
        }
    }
}
