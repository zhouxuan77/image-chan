import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.5

import "../sources/screen.js" as Screen
import "../sources/tips.js" as Tips

UploadScreenForm {
    id: _root

    // 点击上传按钮 信号
    signal uploadSignal()
    // 点击刷新按钮 信号
    signal refreshSignal()
    signal moveSignal(var input, var output, var name)
    // GalleryView 长按删除事件
    signal deleteSignal(var key, var name)

    property var adapter: []
    property string tips: ''

    button01.onHover: (type) => { Screen.setHelpText(type, "上传列表中所有的图片") }
    button02.onHover: (type) => { Screen.setHelpText(type, "重新加载未上传的图片") }

    button01.onClick: {
        uploadSignal()
        refreshSignal()
    }

    onAdapterChanged: {
        let tips =  Tips.UPLOAD_SCREEN_TIPS[-adapter.length]
        tipsText = tips ? tips : adapter.length + " 张图片待上传喵~"
    }

    galleryView.onItemClick:
        (index) => {
            _root.moveSignal('tmp_upload', 'tmp_convert', adapter[index]['imgName'])
            _root.refreshSignal()
        }

    galleryView.onItemLongClick:
        (index) => {
            _root.deleteSignal('tmp_upload', adapter[index]['imgName'])
            _root.refreshSignal()
        }

    galleryView.onItemHover:
        (type, index) => {
            if (type) {
                helpText = adapter[index]['imgName']
                timer.stop()
            } else {
                timer.restart()
            }
        }

    /* 延时函数 */
    Timer {id: timer}
    function initTimer() {
        timer.interval = 3000;
        timer.repeat = false;
        timer.triggered.connect(() => { helpText = "长按删除，单击跳过压缩" })
        timer.restart();
    }

    onTipsChanged: {
        tipsText = tips
    }

    // 信号传递
    Component.onCompleted: {
        initTimer()

        button02.click.connect(refreshSignal)
    }
}
