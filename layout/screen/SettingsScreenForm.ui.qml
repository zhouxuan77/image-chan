import QtQuick 2.15
import QtQuick.Controls 2.15

import "../component/CButton/"
import "../component/SettingsItem/"

Item {
    width: _root.width
    height: _root.height

    property alias editSecretId: _secretId
    property alias editSecretKey: _secretKey
    property alias editBucketRegion: _bucketRegion
    property alias editBucketName: _bucketName
    property alias editUploadPath: _uploadPath
    property alias editDomainName: _DomainName
    property alias editPhotoPath: _photoPath
    property alias editWebpPath: _webpPath
    property alias button01: _button01
    property alias button02: _button02

    Rectangle {
        id: _root
        x: 0
        y: 0
        width: 612
        height: 500
        color: "#FFFFFF"

        Rectangle {
            x: 16
            y: 27
            width: 290
            height: 381

            SettingsGroup {
                title: "Bucket 上传设置"
            }

            SettingsItem {
                id: _secretId
                y: 41
                width: 274
                title: "Secret_ID"
            }

            SettingsItem {
                id: _secretKey
                y: 101
                width: 274
                title: "Secret_key"
            }

            SettingsItem {
                id: _bucketRegion
                y: 161
                width: 274
                title: "Bucket 地域"
            }

            SettingsItem {
                id: _bucketName
                y: 221
                width: 274
                title: "Bucket 名"
            }

            SettingsItem {
                id: _uploadPath
                y: 281
                width: 274
                title: "上传路径"
            }

            SettingsItem {
                id: _DomainName
                y: 341
                width: 274
                title: "访问域名"
            }
        }

        Rectangle {
            x: 306
            y: 27
            width: 290
            height: 381

            SettingsGroup {
                title: "图片设置"
            }

            SettingsItem {
                id: _photoPath
                y: 41
                width: 274
                title: "图片存储路径"
            }

            SettingsGroup {
                y: 101
                title: "Webp 转换工具"
            }

            SettingsItem {
                id: _webpPath
                y: 136
                width: 274
                title: "工具路径"
            }
        }

        CButton {
            id: _button01
            theme: 2
            text: qsTr("取消")
            x: 388
            y: 438
        }

        CButton {
            id: _button02
            theme: 0
            text: qsTr("保存")
            x: 500
            y: 438
        }
    }
}
