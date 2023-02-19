const TMP_PATH = {
    "tmp_convert": '../../../tmp/convert/',
    "tmp_upload": '../../../tmp/upload/'
}

const logInfo = (logStr) => {
    let time = Qt.formatDateTime(new Date(), "yyyy-MM-dd hh:mm:ss,zzz")
    let header = "-root-utils.js-[line:3]-INFO-[日志信息]: "
    console.log(time + header + logStr)
}
