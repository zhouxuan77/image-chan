import os
import sys

from PySide6.QtCore import QObject, Slot


class EventHandler(QObject):
    """ 事项处理 Class """

    def __init__(self, application):
        super(EventHandler, self).__init__()
        self.app = application

    @Slot(str)
    def click_event(self, name):
        """
        Click 点击事项处理方法

        调用示例：
            eventHandler.click_event("btnWhat")

        :param name: 对象 ID
        """
        if name == 'imgExit':
            sys.exit(self.app.exec())
        elif name == 'imgHelp':
            os.system('start www.baidu.com')
