import json

from PySide6.QtCore import QObject, Slot

import utils
from config import ConfigError, ConfigUtils
from utils.file_utils import TempPathError

log = utils.HandleLog()


class PythonSlot(QObject):
    def __init__(self):
        super(PythonSlot, self).__init__()

        self.article_utils = None
        self.file_utils = utils.FileUtils()
        self.config = ConfigUtils()

    @Slot(result=int)
    def get_article(self):
        # 获取对应文章地址
        try:
            path = utils.show_file_dialog()
            self.article_utils = utils.ArticleUtils(path)

            # 返回文章中具体图片数量
            return self.article_utils.get_photo_number()
        except FileExistsError and FileNotFoundError:
            return -1

    @Slot()
    def replace_article(self):
        self.article_utils.replace_web_url()

    @Slot(result=str)
    def save_photo(self):
        result = {'code': 0}

        try:
            photo_list = self.article_utils.get_photo_path_list()
            result['num'] = self.file_utils.save_article_photo(photo_list)
        except ConfigError:
            result['code'] = -1

        return json.dumps(result)

    @Slot(str, result=str)
    def get_photo_list(self, key):
        try:
            return json.dumps(self.file_utils.get_tmp_file_list(key, True))
        except TempPathError:
            return "{}"

    @Slot(str, result=int)
    def delete_photo(self, data):
        try:
            json_data = json.loads(data)
            return self.file_utils.remove_tmp_file(json_data['key'], json_data['name'])
        except TempPathError:
            return "{}"

    @Slot(str, result=int)
    def move_photo(self, data):
        try:
            json_data = json.loads(data)
            return self.file_utils.move_tmp_file(json_data['input'], json_data['output'], json_data['name'])
        except TempPathError:
            return "{}"

    @Slot(result=int)
    def convert_photo(self):
        try:
            return self.file_utils.convert_tmp_photo()
        except ConfigError:
            return -2

    @Slot(result=int)
    def upload_photo(self):
        return self.file_utils.upload_tmp_photo()

    @Slot(result=str)
    def get_config(self):
        return json.dumps(self.config.get_items())

    @Slot(str)
    def change_config(self, data):
        return self.config.change_config(json.loads(data))
