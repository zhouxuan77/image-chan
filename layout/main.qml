import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.5

import "./component/GalleryView/"
import "./component/sidebar/"
import "./screen/"

import "./sources/screen.js" as Screen

Window {
    width: 800
    height: 500
    visible: true
    flags: Qt.Window | Qt.FramelessWindowHint | Qt.WindowSystemMenuHint | Qt.WindowMinimizeButtonHint | Qt.WindowMaximizeButtonHint
    title: "图床酱"

    Sidebar {
        id: sidebar
    }

    ArticleScreen {
        id: articleScreen
        visible: sidebarSelect === 0
        x: 188
    }

    ConvertScreen {
        id: convertScreen
        visible: sidebarSelect === 1
        x: 188
    }

    UploadScreen {
        id: uploadScreen
        visible: sidebarSelect === 2
        x: 188
    }

    SettingsScreen {
        id: settingsScreen
        visible: sidebarSelect === 3
        x: 188
    }

    Component.onCompleted: {
        Screen.initScreen(pythonSlot)
        sidebar.itemChange.connect(Screen.sidebarChange)

        articleScreen.serchSignal.connect(Screen.getArticle)
        articleScreen.saveSignal.connect(Screen.saveArticlePhoto)
        articleScreen.replaceSignal.connect(Screen.replaceArticle)

        convertScreen.refreshSignal.connect(refreshConvertScreen)
        convertScreen.convertSignal.connect(Screen.convertPhoto)
        convertScreen.moveSignal.connect(Screen.movePhoto)
        convertScreen.deleteSignal.connect(Screen.deletePhoto)

        uploadScreen.refreshSignal.connect(refreshUploadScreen)
        uploadScreen.uploadSignal.connect(Screen.uploadPhoto)
        uploadScreen.moveSignal.connect(Screen.movePhoto)
        uploadScreen.deleteSignal.connect(Screen.deletePhoto)

        settingsScreen.cancelSignal.connect(refreshSettingsScreen)
        settingsScreen.editSignal.connect(Screen.changeConfig)
    }

    property int sidebarSelect: 0

    Connections {
        target: pythonSlot
    }

    function refreshConvertScreen() { convertScreen.adapter = Screen.getPhotoList("tmp_convert") }
    function refreshUploadScreen() { uploadScreen.adapter = Screen.getPhotoList("tmp_upload") }
    function refreshSettingsScreen() { settingsScreen.config = Screen.getConfig() }
}
