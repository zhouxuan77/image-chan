import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.5

Item {
    width: _root.width
    height: _root.height

    signal itemClick(int index)
    signal itemLongClick(int index)
    signal itemHover(int type, int index)

    property var listAdapter: []

    GridView {
        id: _root
        width: 528
        height: 360
        focus: true
        clip: true
        boundsBehavior: Flickable.StopAtBounds
        model: _listModel
        delegate: GalleryViewItem {
            id: _galleryItem
            icon: imgPath
            text: imgName
            MouseArea {
                id: _mouseArea
                anchors.fill: parent
                hoverEnabled: true
                onEntered: { itemHover(1, index) }
                onExited: { itemHover(0, index) }
                onClicked: { itemClick(index) }
                onPressAndHold: { itemLongClick(index) }
            }
        }
        cellHeight: 132
        cellWidth: 132
    }

    ListModel {
        id: _listModel
    }

    onListAdapterChanged: {
        _listModel.clear()
        if (listAdapter.length > 0) {
            listAdapter.forEach((item, index) => { _listModel.append(item) })
        }
    }
}
