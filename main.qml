import QtQuick
import QtQuick.Window
import QtQuick.Controls 6.4

Window {
    id:main
    width: 800
    height: 500
    visible: true
    flags: Qt.Window | Qt.FramelessWindowHint | Qt.WindowSystemMenuHint | Qt.WindowMinimizeButtonHint | Qt.WindowMaximizeButtonHint

    // 头像栏
    Rectangle {
        width: 188
        height: 500
        visible: true
        color: "#333333"

        Image {
            id: btnExit
            width: 24
            height: 24
            x: 12
            y: 12
            source: "image/icon/exit.png"
            MouseArea{
                anchors.fill: parent
                onExited: {
                    eventHandler.click_event("imgExit")
                }
            }
        }

        Image {
            id: btnHelp
            width: 24
            height: 24
            x: 152
            y: 12
            source: "image/icon/help.png"
            MouseArea{
                anchors.fill: parent
                onExited: {
                    eventHandler.click_event("imgHelp")
                }
            }
        }

        BorderImage {
            id: avatarImg
            x: 45
            y: 66
            width: 98
            height: 98
            source: "image/avatar.png"
        }

        Text {
            x: 70
            y: 170
            text: "图床酱"
            font.pixelSize: 16
            font.bold: true
            color: "#FFFFFF"
        }

        Text {
            x: 66
            y: 193
            text: "IMG CHAT"
            font.pixelSize: 12
            color: "#FFFFFF"
        }
    }

    // 侧边按钮栏
    Rectangle {
        Rectangle {
            id: home
            x: 0
            y: 222
            width: 188
            height: 48
            color: $sideBarNum === 0 ? "#666666" : "#333333"
            border.color: $sideBarNum === 0 ? "#666666" : "#333333"
            MouseArea{
                anchors.fill: parent
                onExited: {
                    $sideBarNum = 0
                }
            }

            Image {
                x: 24
                y: 12
                width: 24
                height: 24
                source: "image/icon/home.png"
                smooth: true
                mipmap: true
                fillMode: Image.PreserveAspectFit
            }

            Text {
                x: 72
                y: 14
                color: "#ffffff"
                text: qsTr("文章管理")
                font.pixelSize: 14
            }
        }

        Rectangle {
            x: 0
            y: 270
            width: 188
            height: 48
            color: $sideBarNum === 1 ? "#666666" : "#333333"
            border.color: $sideBarNum === 1 ? "#666666" : "#333333"
            MouseArea{
                anchors.fill: parent
                onExited: {
                    $sideBarNum = 1
                }
            }

            Image {
                x: 24
                y: 12
                width: 24
                height: 24
                source: "image/icon/convert.png"
                smooth: true
                mipmap: true
                fillMode: Image.PreserveAspectFit
            }

            Text {
                x: 72
                y: 14
                color: "#ffffff"
                text: qsTr("图片压缩")
                font.pixelSize: 14
            }
        }

        Rectangle {
            x: 0
            y: 318
            width: 188
            height: 48
            color: $sideBarNum === 2 ? "#666666" : "#333333"
            border.color: $sideBarNum === 2 ? "#666666" : "#333333"
            MouseArea{
                anchors.fill: parent
                onExited: {
                    $sideBarNum = 2
                }
            }

            Image {
                x: 24
                y: 12
                width: 24
                height: 24
                source: "image/icon/photo.png"
                smooth: true
                mipmap: true
                fillMode: Image.PreserveAspectFit
            }

            Text {
                x: 72
                y: 14
                color: "#ffffff"
                text: qsTr("图片管理")
                font.pixelSize: 14
            }
        }

        Rectangle {
            x: 0
            y: 366
            width: 188
            height: 48
            color: $sideBarNum === 3 ? "#666666" : "#333333"
            border.color: $sideBarNum === 3 ? "#666666" : "#333333"
            MouseArea{
                anchors.fill: parent
                onExited: {
                    $sideBarNum = 3
                }
            }

            Image {
                x: 24
                y: 12
                width: 24
                height: 24
                source: "image/icon/settings.png"
                smooth: true
                mipmap: true
                fillMode: Image.PreserveAspectFit
            }

            Text {
                x: 72
                y: 14
                color: "#ffffff"
                text: qsTr("系统设置")
                font.pixelSize: 14
            }
        }
    }



    Rectangle {
        width: 612
        height: 500
        x: 188
        y: 0

        BorderImage {
            source: "image/svg/article_normal.png"
            width: 340
            height: 340
            x: 146
            y: 70
        }

        Text {
            x: 24
            y: 453
            text: "已导入 0 篇文章，检索到 0 张图片"
            font.pixelSize: 16
            color: "#666666"
        }

        Rectangle {
            id: btn_get
            x: 388
            y: 438
            width: 88
            height: 38
            radius: 7
            color: "#2196F3"
            MouseArea{
                anchors.fill: parent
                onEntered: {
                   btn_get.color = "#0277BD"
                }
                onExited: {
                    btn_get.color = "#2196F3"
                }
            }

            Text {
                text: qsTr("获取")
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 16
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#FFFFFF"
            }
        }

        Rectangle {
            id: btn_generate
            x: 500
            y: 438
            width: 88
            height: 38
            radius: 7
            color: "#ADADAD"
            MouseArea{
                anchors.fill: parent
                onEntered: {
                   btn_generate.color = "#616161"
                }
                onExited: {
                    btn_generate.color = "#ADADAD"
                }
            }

            Text {
                text: qsTr("生成")
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 16
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#FFFFFF"
            }
        }
    }

    Connections {
        target: eventHandler
        ignoreUnknownSignals: true
    }

    // 侧边栏当前选中列
    property int $sideBarNum: 0
}

