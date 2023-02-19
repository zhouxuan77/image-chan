import ctypes
import sys
from pathlib import Path

from PySide6.QtGui import QGuiApplication, QIcon
from PySide6.QtQml import QQmlApplicationEngine

import slot

# 设置窗口 ICON
ctypes.windll.shell32.SetCurrentProcessExplicitAppUserModelID("image-chan")


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    # 设置应用程序 ICON
    app.setWindowIcon(QIcon("favicon.ico"))

    engine = QQmlApplicationEngine()
    qml_file = Path(__file__).resolve().parent / "layout/main.qml"

    # 绑定信号
    python_slot = slot.PythonSlot()
    engine.rootContext().setContextProperty('pythonSlot', python_slot)

    engine.load(qml_file)
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
