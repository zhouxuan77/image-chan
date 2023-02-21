import configparser
import os.path


class ConfigUtils:
    """ Config 配置读取类

    用于读取 config/config.ini 内的具体配置
    """
    def __init__(self):
        # 判断配置文件是否存在
        if not os.path.exists:
            raise ConfigError

        self.config = configparser.ConfigParser()
        self.config.read("config/config.ini", encoding='utf-8')

    def get_value(self, sections, key):
        """ 获取具体的配置信息

        Args:
            sections: Sections 对象，在 ini 中为 [Sections]
            key: 键值对 key 值，在 ini 中为 key = value

        Returns:
            返回对应的 value

            for example:
                在 ini 中 为：
                    [upload]
                    path = hello
                返回：
                    hello
        """
        self._reload_config()

        try:
            return self.config[sections][key]
        except KeyError:
            return ''

    def get_items(self):
        """ 获取配置文件中所有的内容，返回字典类型

        Returns:
            配置文件中所有的内容 (dict)

            for example:
            {
                "upload_path": "./photo",
                "file": "hello"
            }
        """
        self._reload_config()
        result = {}

        for section in self.config.sections():
            for key in self.config.options(section):
                result[key] = self.config.get(section, key)

        return result

    def change_config(self, change_data):
        for section in self.config.sections():
            for key in self.config.options(section):
                try:
                    if change_data[key] != self.config.get(section, key):
                        self.config.set(section, key, change_data[key])
                except KeyError:
                    pass

        self.config.write(open("config/config.ini", 'w', encoding='utf-8'))

    def _reload_config(self):
        """ 重新读取 Config 配置文件的内容

        主要避免当配置文件发生修改时无法使用更改的内容
        """
        self.config.read("config/config.ini", encoding='utf-8')


class ConfigError(Exception):
    def __str__(self):
        return repr("Config.ini Configuration Error!")
