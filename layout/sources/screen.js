.import "utils.js" as Utils

/* 公共部分 */

/**
 * 更改 HelpText 中的文字内容
 *
 * @param {int} type MouseArea 事项
 * @param {string} text 显示的内容
 */
const setHelpText = (type, text) => {
    if (type) {
        helpText = text
    } else {
        helpText = ''
    }
}

/* main.qml 专属 */

var _target = null

const initScreen = (target) => {
    _target = target
}

// 获取 Markdown 文章地址
const getArticle = () => {
    articleScreen.photoNum = -3
    let result = _target.get_article()

    Utils.logInfo("getArticle 获取到: " + result)
    articleScreen.photoNum = result
}

const replaceArticle = () => {
    if (articleScreen.photoNum <= 0) {
        articleScreen.tips = "没有可以替换的内容喵~"
        return
    }

    articleScreen.photoNum = -5
    _target.replace_article()
    Utils.logInfo("执行 replaceArticle")
    articleScreen.photoNum = -4
}

// 将 Markdown 文章中的图片保存至临时文件夹
const saveArticlePhoto = () => {
    // 判断是否存在可以移动的图片
    if (articleScreen.photoNum <= 0) {
        articleScreen.tips = "没有图片可以搬运喵~"
        return
    }

    articleScreen.tips = "正在努力搬运图片喵..."
    let jsonStr = _target.save_photo()
    let jsonData = JSON.parse(jsonStr)

    let photoNum = articleScreen.photoNum
    let saveNum = jsonData['num']

    Utils.logInfo("saveArticlePhoto 获取到: " + jsonStr)

    if (jsonData['code'] === -1) articleScreen.tips = "配置文件没有配置喵！"
    if (jsonData['code'] === 0) {
        if (photoNum === saveNum) {
            articleScreen.tips = "导入成功了喵~"
        } else {
            articleScreen.tips = "导入了 " + saveNum + " 张图片, 导入失败 " + (photoNum - saveNum) +" 张喵~"
        }
    }
}

const getPhotoList = (key) => {
    let jsonStr = _target.get_photo_list(key)
    let jsonData = JSON.parse(jsonStr)

    Utils.logInfo("getPhotoList Key: " + key)
    Utils.logInfo("getPhotoList 获取: " + jsonStr)

    let listAdapter = []

    for (let photoName in jsonData) {
        listAdapter.push({'imgName': photoName, 'imgPath': jsonData[photoName]})
    }

    return listAdapter
}

const deletePhoto = (key, name) => {
    let jsonStr =
    JSON.stringify({
                       'key': key,
                       'name': name
                   })

    Utils.logInfo("deletePhoto Data: " + jsonStr)
    return _target.delete_photo(jsonStr)
}

const movePhoto = (inputKey, outputKey, name) => {
    let jsonStr = JSON.stringify({
                                     'input': inputKey,
                                     'output':outputKey,
                                     'name': name
                                 })

    Utils.logInfo("movePhoto Data: " + jsonStr)
    return _target.move_photo(jsonStr)
}

const convertPhoto = () => {
    convertScreen.tips = "正在努力压缩图片喵~"
    Utils.logInfo("执行 convertPhoto")

    let convertNum = _target.convert_photo()
    Utils.logInfo("convertPhoto 压缩数量为: " + convertNum)

    if (convertNum === -2) { convertScreen.tips = "配置文件没有配置喵！" }
    if (convertNum === 0) { convertScreen.tips = "啥都没有干喵~" }
    if (convertNum > 0) { convertScreen.tips = "压缩完成了喵！" }
}

const uploadPhoto = () => {
    uploadScreen.tips = "正在努力上传图片喵~"
    Utils.logInfo("执行 uploadPhoto")

    let uploadNum = _target.upload_photo()
    Utils.logInfo("uploadPhoto 上传数量为: " + uploadNum)

    if (uploadNum === -2) { uploadScreen.tips = "配置文件没有配置喵！" }
    if (uploadNum === 0) { uploadScreen.tips = "啥都没有干喵~" }
    if (uploadNum > 0) { uploadScreen.tips = "上传完成了喵！" }
}

const getConfig = () => {
    let configStr = _target.get_config()
    Utils.logInfo("getConfig 获取为: " + configStr)

    return JSON.parse(configStr)
}

const changeConfig = (changeData) => {
    console.log(changeData)
    let jsonStr = JSON.stringify(changeData)
    Utils.logInfo("changeConfig 数据为: " + jsonStr)
    _target.change_config(jsonStr)
}

// Sidebar 选择 Item
const sidebarChange = (itemId) => {
    sidebarSelect = itemId

    switch (itemId) {
        case 1:
        convertScreen.adapter = getPhotoList("tmp_convert")
        break
        case 2:
        uploadScreen.adapter = getPhotoList("tmp_upload")
        break
        case 3:
        settingsScreen.config = getConfig()
        break
    }
}
