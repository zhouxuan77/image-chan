import os.path
import re
import time

import pyperclip

from config import config, ConfigError, ConfigUtils
from utils import HandleLog

log = HandleLog()


class ArticleUtils:
    """ 文章管理类

    Args:
        path: 文章所在的路径

    Raises:
        FileExistsError: 无法读取文章时抛出

    """

    def __init__(self, path):
        # 文章路径
        self.article_path = path

        with open(path, 'r', encoding='utf-8') as file:
            self.article_content = file.read()

    def get_photo_number(self):
        """ 获取文章中图片数量

        获取文章中图片数量，实际是通过 re 提取符合 ![]() 格式的所有内容，并统计符合条件的个数

        Returns:
            (Integer) 图片数量
        """
        num = len(re.findall(re.compile(r'!\[.*].*'), self.article_content))

        log.info("获取文章图片信息共: {} 条".format(num))
        return num

    def get_photo_root_path(self):
        """ 获取文章中图片存放路径

        使用前需在 ini 文件中配置 photo_path，具体情况可分为以下几类
            1. 配置为绝对路径、路径为目录的，直接返回绝对路径
            2. 配置为绝对路径、路径为文件的，返回文件所在的路径
            3. 配置为相对路径的，根据文章路径逆推得到绝对路径

        Returns:
            (String) 图片存储的路径

            for example:
                C:\\Users\\xuan\\Documents\\Obsidian

        Raises:
            ConfigError: 未找到 photo_path 配置内容时抛出
        """
        # 判断是否配置正确 ini 文件
        config_path = config.get_value('photo', 'photo_path')
        if config_path == '':
            log.error("未找到 photo_path 配置内容")
            raise ConfigError

        # 当输入的为绝对路径且类型为文件夹时，则直接返回绝对路径
        if os.path.exists(config_path) and os.path.isdir(config_path):
            return config_path
        # 当输入的为绝对路径且类型为文件时，则返回上一级路径
        elif os.path.isfile(config_path):
            return os.path.dirname(config_path)

        article_root_path = os.path.dirname(self.article_path)

        # 根据相对路径，获取图片实际路径
        for tmp_str in config_path.split('/'):
            if '..' == tmp_str:
                article_root_path = os.path.dirname(article_root_path)
            elif '.' == tmp_str:
                article_root_path = article_root_path
            else:
                article_root_path = os.path.join(article_root_path, tmp_str)

        log.info("图片存储路径为: " + article_root_path)
        return article_root_path

    def get_photo_list(self):
        """ 获取文章中所有图片（名称）

        通过 re 获取文章所有的图片，实际通过 re 提取 ![]() 中 () 内部的部分作为图片名称

        Returns:
            (Array) 文章所有的图片

            for example:
                ['photo/123.png', 'C:\123.png']
        """
        photo_list = []

        for photo in re.findall(re.compile(r'!\[.*].*'), self.article_content):
            try:
                photo_list.append(re.findall(re.compile(r'[(](.*?)[)]'), photo)[0])
            except SyntaxError:
                pass

        log.info("文章中图片为: " + '\n'.join(photo_list))
        return photo_list

    def get_photo_path_list(self):
        """ 获取文章中所有图片（路径）

        使用 get_photo_list 获取具体图片信息，判断是否为绝对路径，如果是则直接加入、否则与 get_photo_root_path 进行拼接

        Returns:
            (Array) 文章所有的图片路径

            for example:
                ['C:\photo\123.png', 'C:\123.png']
        Raises:
            ConfigError: 没有配置正确 ini 文件时抛出
        """
        path_list = []
        root_path = self.get_photo_root_path()

        for photo in self.get_photo_list():
            if os.path.exists(photo) and os.path.isfile(photo):
                path_list.append(photo)
            else:
                path_list.append(os.path.join(root_path, os.path.basename(photo)))

        log.info("文章中图片路径为: " + '\n'.join(path_list))
        return path_list

    def replace_web_url(self):
        photo_list = self.get_photo_list()

        t = time.localtime()

        for photo in photo_list:
            path_data = {
                'file_name': os.path.basename(photo),
                'now_year': t.tm_year,
                'now_month': (t.tm_mon, "0{}".format(t.tm_mon))[t.tm_mon < 10],
                'now_day': t.tm_mday,
                'file_year': t.tm_year,
                'file_month': (t.tm_mon, "0{}".format(t.tm_mon))[t.tm_mon < 10],
                'file_day': t.tm_mday
            }

            if 'image-' in os.path.basename(photo) and len(os.path.basename(photo)) >= 27:
                path_data['file_year'] = os.path.basename(photo)[6:10]
                path_data['file_month'] = os.path.basename(photo)[10:12]
                path_data['file_day'] = os.path.basename(photo)[12:14]

            configs = ConfigUtils()
            upload_key = configs.get_value('upload', 'upload_path').format(**path_data)
            log.info(upload_key)
            url = configs.get_value('upload', 'domain_name') + upload_key
            log.info(url)
            log.info("{} 更换为 {}".format(photo, url))

            self.article_content = self.article_content.replace(photo, url)

        pyperclip.copy(self.article_content)
