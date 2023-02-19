import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQml.Models 2.3

SettingsScreenForm {
    id: _root

    signal editSignal(var item)
    signal cancelSignal()

    button02.onClick: {
        editSignal({
                       'photo_path': editPhotoPath.edit.text,
                       'webp_path': editWebpPath.edit.text,
                       'secret_id': editSecretId.edit.text,
                       'secret_key': editSecretKey.edit.text,
                       'region': editBucketRegion.edit.text,
                       'bucket': editBucketName.edit.text,
                       'upload_path': editUploadPath.edit.text,
                       'domain_name': editDomainName.edit.text
                   })
    }

    onConfigChanged: {
        editSecretId.edit.text = config['secret_id'] ? config['secret_id'] : '待设置内容'
        editSecretKey.edit.text = config['secret_key'] ? config['secret_key'] : '待设置内容'
        editBucketRegion.edit.text = config['region'] ? config['region'] : '待设置内容'
        editBucketName.edit.text = config['bucket'] ? config['bucket'] : '待设置内容'
        editUploadPath.edit.text = config['upload_path'] ? config['upload_path'] : '待设置内容'
        editDomainName.edit.text = config['domain_name'] ? config['domain_name'] : '待设置内容'
        editPhotoPath.edit.text = config['photo_path'] ? config['photo_path'] : '待设置内容'
        editWebpPath.edit.text = config['webp_path'] ? config['webp_path'] : '待设置内容'
    }

    Component.onCompleted: {
        button01.click.connect(cancelSignal)
    }

    property var config: ({})
}
