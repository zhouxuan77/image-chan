<div align="center"><img src="https://image.zhouxuan77.top/README/image-chan/logo.webp" width="25%" height="25%" /></div>

![maven](https://img.shields.io/badge/python-3.8%2B-blue) ![maven](https://img.shields.io/badge/qt-6.4%2B-yellow)

# 图床酱

---

本项目使用 Qt Quick 6.4 + Python 构建，可实现提取 Markdown 文章中的图片进行压缩与上传操作

~~一只可爱的图床酱~~

## 简单使用

启动 `图床酱.exe` 后，只需要对配置进行修改即可使用，具体配置项目如下

![image-20230221143431919](https://image.zhouxuan77.top/README/image-chan/image-20230221143431919.webp)

- Bucket 上传设置
  
  该部分只需要依照 **腾讯COS** 相关参数进行配置即可
  
  上传路径格式需符合以下要求，例如: {file_year}/{file_month}/{file_name}
  
  - {file_year}：依据图片名获取图片创建年份。图片名示例：image-20230221143431919.png
  - {file_month}：依据图片名获取图片创建月份。图片名示例：image-20230221143431919.png
  - {file_day}：依据图片名获取图片创建日期。图片名示例：image-20230221143431919.png
  - {now_year}：当前年份
  - {now_month}：当前月份
  - {now_day}：当前日期
  - {file_name}：**必填**，文件名
- 图片设置
  
  - 图片路径支持相对路径（以 './' 或 '../' 开头）或绝对路径。例如：./photo 或 C:\Users\Documents\
- 压缩设置
  
  - 需指定 **Webp 压缩工具** 存放的路径，[下载地址](https://developers.google.com/speed/webp/download?hl=zh-cn) 。例如：C:\libwebp-0.4.1-rc1-windows-x64-no-wic\bin\cwebp.exe

## 编译使用

1. 克隆工程
   
   ```shell
   git clone https://github.com/zhouxuan77/image-chan.git
   ```
2. 安装依赖
   
   ```shell
   cd image-chan
   # 更新 pip 工具
   python -m pip install --upgrade pip
   # 更新 pip 工具，国内源
   # python -m pip install --upgrade pip -i https://pypi.tuna.tsinghua.edu.cn/simple
   
   # 安装简略版依赖
   pip install -r requirements.txt
   # 安装完整版依赖（简略版报错 No Model Found 时，务必使用完整版依赖）
   # pip install -r requirements-all.txt
   ```
3. 安装Qt 6.4.2
   
   需安装 `MSVC2019 64bit`
4. 打包 EXE 文件
   
   - 需配置 `main.spec `文件
     
     将文件中 **datas** 和 **icon** 部分的路径修改为对应的绝对路径 (需使用 `\\`) 即可，示例：
     
     ```python
     a = Analysis(
     	....
         datas=[("C:\\image-chan\\layout", "layout"), ("C:\\img_chan\\config", "config")],
         ....
     )
     
     exe = EXE(
         ....
         # 是否开启调试模式，调试模式下会弹出黑框
         console=False,
         ....
         icon=['C:\\image-chan\\layout\\image\\favicon.ico']
     )
     ```
   - 运行 `setup.py`
     
     ```shell
     cd image-chan
     python setup.py
     ```

## Todo

~~不定期更新~~

- 添加其他图床、OSS 支持（阿里云，七牛云，SM.MS....）
- 添加上传记录查看，历史图片查询功能
- 添加多种图片链接支持（~~Markdown~~、HTML、URL、UBB）
- 支持单文件命令行上传（可作为上传服务嵌入 Typora）
- 支持多种图片上传路径支持

## 更新

### 2023/02/21

1. 添加腾讯 COS 支持
2. 修复了大量 BUG

## 贡献与帮助

任何使用上的 BUG 和问题都可提交至 `Issues`

代码贡献请使用 **pull request**

## 关于

项目不定期更新，鄙人能力有限，不足之处望各位大佬手下留情！

项目依据 [MIT License](https://opensource.org/licenses/MIT) 开源，当您下载和使用本项目时，将默认您认同开源协议 [MIT License](https://opensource.org/licenses/MIT)

## 声明

此项目仅用于学习交流，请勿用于非法用途


