import os

# 0: 无黑框模式
# 1：黑框调试模式
build_type = 0

if __name__ == '__main__':
    if build_type == 0:
        str_cmd = "pyinstaller -F -w -i favicon.ico main.spec"

    if build_type == 1:
        str_cmd = "pyinstaller main.spec"

    os.system(str_cmd)
