import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.5
import QtQml 2.3

SidebarForm {

    signal itemChange(int itemId)

    item01Click.onClicked: {
        itemSelect = 0
        itemChange(0)
    }

    item02Click.onClicked: {
        itemSelect = 1
        itemChange(1)
    }

    item03Click.onClicked: {
        itemSelect = 2
        itemChange(2)
    }

    item04Click.onClicked: {
        itemSelect = 3
        itemChange(3)
    }

    // 退出 点击事项
    exitClick.onClicked: {
        Qt.exit(0)
    }

    // 帮助 点击事项
    helpClick.onClicked: {
        Qt.openUrlExternally("https://github.com/zhouxuan77/image-chan")
    }
}
