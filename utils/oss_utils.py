from qcloud_cos import CosConfig
from qcloud_cos import CosS3Client
from qcloud_cos.cos_exception import CosException, CosClientError

from config import ConfigUtils, ConfigError
from utils import HandleLog

log = HandleLog()


class OssUtils:
    def __init__(self):
        self.client = None
        self.bucket = ''

    def load_cos(self):
        try:
            ini_config = ConfigUtils()
            config = CosConfig(Region=ini_config.get_value('upload', 'region'),
                               SecretId=ini_config.get_value('upload', 'secret_id'),
                               SecretKey=ini_config.get_value('upload', 'secret_key'),
                               Token='', Scheme='https')
            self.bucket = ini_config.get_value('upload', 'bucket')
            self.client = CosS3Client(config)
        except KeyError:
            raise ConfigError

    def cos_upload_file(self, path, key):
        try:
            response = self.client.upload_file(
                Bucket=self.bucket,
                Key=key,
                LocalFilePath=path)
            log.info(key)
            log.info(response)
            if response['ETag'] != '':
                log.error("上传成功: {}".format(path))
                return "ok"
            return 'COS Client Error'
        except CosException as e:
            log.error(e)
            return eval(e.__str__())['message']
