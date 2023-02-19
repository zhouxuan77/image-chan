import QtQuick 2.9
import QtQuick.Window 2.3

Item {
    width: _root.width
    height: _root.height
    visible: true

    property alias item01Click: _item01.click
    property alias item02Click: _item02.click
    property alias item03Click: _item03.click
    property alias item04Click: _item04.click
    property alias exitClick: _exitClick
    property alias helpClick: _helpClick
    property int itemSelect: 0

    Rectangle {
        id: _root
        width: 188
        height: 500
        color: "#333333"

        Image {
            source: "../../image/icon/exit.png"
            width: 24
            height: 24
            x: 12
            y: 12
            MouseArea {
                id: _exitClick
                anchors.fill: parent
            }
        }

        Image {
            source: "../../image/icon/help.png"
            width: 24
            height: 24
            x: 152
            y: 12
            MouseArea {
                id: _helpClick
                anchors.fill: parent
            }
        }

        BorderImage {
            source: "../../image/avatar.png"
            width: 98
            height: 98
            x: 45
            y: 66
        }

        Text {
            text: qsTr("图床酱")
            font.pixelSize: 16
            font.weight: Font.Bold
            x: 70
            y: 170
            color: "#ffffff"
        }

        Text {
            text: qsTr("IMG CHAT")
            font.pixelSize: 12
            x: 66
            y: 193
            color: "#ffffff"
        }

        SidebarItem {
            id: _item01
            y: 222
            text: "文章管理"
            icon: "../../image/icon/home.png"
            select: itemSelect === 0
        }

        SidebarItem {
            id: _item02
            y: 270
            text: "图片压缩"
            icon: "../../image/icon/convert.png"
            select: itemSelect === 1
        }

        SidebarItem {
            id: _item03
            y: 318
            text: "图片管理"
            icon: "../../image/icon/photo.png"
            select: itemSelect === 2
        }

        SidebarItem {
            id: _item04
            y: 366
            text: "系统设置"
            icon: "../../image/icon/settings.png"
            select: itemSelect === 3
        }
    }
}
