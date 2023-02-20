import os
import shutil
import subprocess
import time
import tkinter
from tkinter import filedialog

from config import root_path, config, ConfigError
from utils import HandleLog
from utils.oss_utils import OssUtils

log = HandleLog()


def show_file_dialog():
    """ 弹出文件选择对话框

    Returns:
        Markdown 文件绝对路径

        for example:
            C:\\Users\\Public\\Project\\image-chan\\slot.py

    Raises:
        FileNotFoundError - 选择非 Markdown 文件
    """
    tkinter.Tk().withdraw()

    file_path = filedialog.askopenfilename()

    log.info("选择: " + file_path)

    if '.md' in file_path:
        return file_path
    else:
        raise FileNotFoundError


class FileUtils:
    def __init__(self):
        # 判断是否存在临时文件夹
        for path in root_path.values():
            if not os.path.exists(path):
                os.makedirs(path)

    def save_article_photo(self, path_list):
        tmp_path = root_path['tmp_convert']
        success_num = 0

        for path in path_list:
            output_path = os.path.join(tmp_path, os.path.basename(path))
            try:
                shutil.copy(path, output_path)

                log.info("复制 {} 至 {}".format(path, output_path))
                if os.path.exists(output_path):
                    success_num += 1
            except IOError as e:
                log.error(e)

        return success_num

    def get_tmp_file_list(self, key, convert=False):
        if key not in root_path.keys():
            raise TempPathError

        file_list = {}
        for file in os.listdir(root_path[key]):
            file_list[file] = os.path.abspath(file)

            if convert:
                file_list[file] = "file:\\" + os.path.abspath(os.path.join(root_path[key], file))

        log.info("{} 获取得到: ".format(key))
        log.info(file_list)
        return file_list

    def remove_tmp_file(self, key, name):
        if key not in root_path.keys():
            raise TempPathError

        file_path = os.path.join(root_path.get(key), name)
        os.remove(file_path)

        log.info("删除: {}".format(file_path))
        return not os.path.exists(file_path)

    def move_tmp_file(self, input_key, output_key, name):
        if input_key not in root_path.keys() and output_key not in root_path.keys():
            raise TempPathError

        input_path = os.path.join(root_path.get(input_key), name)
        output_path = os.path.join(root_path.get(output_key), name)

        shutil.copy(input_path, output_path)
        log.info("从 {} 至 {}".format(input_path, output_path))

        if os.path.exists(output_path):
            os.remove(input_path)
            return True
        return False

    def convert_tmp_photo(self):
        webp_path = config.get_value('webp', 'webp_path')
        if not os.path.exists(webp_path):
            raise ConfigError

        convert_num = 0
        for photo in os.listdir(root_path.get('tmp_convert')):
            input_path = os.path.join(root_path.get('tmp_convert'), photo)
            convert_name = os.path.basename(os.path.splitext(input_path)[0]) + '.webp'
            output_path = os.path.join(os.path.abspath(root_path['tmp_upload']), convert_name)

            if os.path.exists(output_path):
                os.remove(input_path)
                log.info("执行: 已存在" + output_path)
            else:
                str_cmd = '{} -lossless "{}" -o "{}"'.format(webp_path, input_path, output_path)
                log.info("执行: " + str_cmd)
                # os.system(str_cmd)
                subp = subprocess.Popen(str_cmd)
                subp.wait(2)

            if os.path.exists(output_path):
                os.remove(input_path)
                convert_num += 1
        return convert_num

    def upload_tmp_photo(self):
        oss = OssUtils()
        upload_num = 0
        try:
            oss.load_cos()

            upload_key = config.get_value('upload', 'upload_path')
        except ConfigError and KeyError:
            return -2

        t = time.localtime()

        for photo in os.listdir(root_path.get('tmp_upload')):
            path_data = {
                'file_name': photo,
                'now_year': t.tm_year,
                'now_month': (t.tm_mon, "0{}".format(t.tm_mon))[t.tm_mon < 10],
                'now_day': t.tm_mday,
                'file_year': t.tm_year,
                'file_month': (t.tm_mon, "0{}".format(t.tm_mon))[t.tm_mon < 10],
                'file_day': t.tm_mday
            }

            if 'image-' in photo:
                path_data['file_year'] = photo[6:10]
                path_data['file_month'] = photo[10:12]
                path_data['file_day'] = photo[12:14]

            upload_key = config.get_value('upload', 'upload_path')
            upload_key = upload_key.format(**path_data)

            result = oss.cos_upload_file(os.path.join(root_path.get('tmp_upload'), photo), upload_key)

            if result == 'ok':
                upload_num += 1
                os.remove(os.path.join(root_path.get('tmp_upload'), photo))

        return upload_num


class TempPathError(Exception):
    def __str__(self):
        return repr("Temp Path Error!")
