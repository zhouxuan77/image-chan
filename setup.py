import os.path
import shutil

if __name__ == '__main__':
    if not os.path.exists("main.spec"):
        os.system("pyi-makespec main.py")
        print(".spec 文件未找到, 已创建")
        exit(-1)

    with open('main.spec', 'r', encoding='utf-8') as file:
        spec_content = file.read()

    if "icon=['image-chan" in spec_content:
        print("ICON 路径未配置")
        exit(-1)

    if '("image-chan' in spec_content:
        print("资源文件路径 未配置")
        exit(-1)

    print("配置检验成功, 开始打包 EXE 文件")
    os.system("pyinstaller main.spec")

    # 移动图标文件到 dist\main 路径
    if not os.path.exists("dist/main/layout/image/favicon.ico"):
        shutil.copy("layout/image/favicon.ico", "dist/main/layout/image/favicon.ico")
        print("加载图标资源")

    if os.path.exists("dist/main/main.exe"):
        shutil.copy("dist/main/main.exe", "dist/main/图床酱.exe")

    print("EXE 文件存放于 dist\\main 路径下")
