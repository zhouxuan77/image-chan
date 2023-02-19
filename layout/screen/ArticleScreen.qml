import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.5

import "../sources/screen.js" as Screen
import "../sources/tips.js" as Tips

ArticleScreenForm {

    // 点击图片选择对应文件 信号
    signal serchSignal()
    // 点击获取按钮保存图片 信号
    signal saveSignal()
    signal replaceSignal()

    property int photoNum: -2
    property string tips: ''

    button01.onHover: (type) => { Screen.setHelpText(type, "保存文章中的图片，以进行后续压缩或上传操作") }
    button02.onHover: (type) => { Screen.setHelpText(type, "将文章中的图片路径转为网络路径") }

    imageClick.onClicked: { serchSignal() }

    // 监听检索到的图片数量变化
    onPhotoNumChanged: {
        let tips = Tips.ARTICLE_PHOTO_SEARCH[-photoNum]
        tipsText = tips ? tips : "检索到 " + photoNum + " 张图片喵~"
    }

    onTipsChanged: {
        tipsText = tips
    }

    // 信号传递
    Component.onCompleted: {
        button01.click.connect(saveSignal)
        button02.click.connect(replaceSignal)
    }
}


