AHK CKEditor
----

>    注：本项目不再维护更新，如有需要请自行修改编译ahk_ckeditor源码。

### 简介

`AHK CKEditor` 是一款在线HTML编辑器，基于CKEditor 4构建。借助于 `Autohotkey`，可以很方便的使用它来生成静态网页。

### 使用说明

太简单了，在编辑器区域内可视化编辑HTML文档。编辑好后，到软件顶部一栏设置HTML文件名和文档标题等信息，最后点击“生成HTML文档”按钮就OK。生成的HTML文档保存在当前程序目录的html文件夹内。CKEditor更多使用技巧请查看CKEditor官网。注意，为了简洁需要，HTML文件名暂不支持中文，部分英文特殊字符（如 `\ / : * ? " < > | ` 等），请使用数字和英文大小写字母等组合。

### 快捷键

    撤消命令 按 CTRL+Z
    重做命令 按 SHIFT+CTRL+Z
    加粗命令 按 CTRL+B
    倾斜命令 按 CTRL+I
    下划线命令 按 CTRL+U
    链接命令 按 CTRL+L
    
更多快捷键命令请见官网说明，注：部分快捷键可能无法在本软件上使用。

### 更新日志

>    2013-01-07 AHK群内与官网同步首发AHK CKEditor，版本号定为2.0。注意，此版取代之前旧版"静态网页编辑器及生成器(SHEM)"小软件，旧版使用KindEditor作为编辑器内核，而新版使用CKEditor 4作为编辑器内核。

>    2013-01-16 发布AHK CKEditor 2.2版，主要变动如下：
①更新CKEditor到官网最新版：4.0.1  
②修改编辑器默认样式，并添加AHK帮助文档模板  
③添加Google Code镜像网站来源，以加速网页显示  
内嵌CKEditor编辑器的网页来源：  
(默认)本人网站：  
`http://raoyc.com/ckeditor/samples/editor.html`    
`Google Code`镜像网站： 
`http://fysoft.googlecode.com/svn/trunk/ckeditor/samples/editor.html`   
④取消软件加壳，并开放AHK CKEditor源代码  
~~⑤放出AutoHotkey标准库用户库扩展计划(已废止)~~   

>    2014-09-10  代码托管迁移至Github  

### 下载地址

请到飞扬小工具软件 [`Github`](https://github.com/ycrao/ahk_ckeditor) 页面下载本软件。

### 已知问题

由于使用Autohotkey内嵌网页，可能会弹出CKEditor的JS脚本运行出错的对话框，点击是，即可继续使用。

### 版权申明

本小工具软件由Autohotkey与CKEditor共同构建，软件绿色、免费且无毒，软件以“`飞扬网络工作室`”署名，作者保留核心代码版权。

### 备注

要反馈软件使用情况或意见和建议的，请通过以下方式联系作者：  

    QQ 873454876   
    Email 837454876#qq&com (请将#换成@，&换成.)  
    Github https://github.com/ycrao  
    官方QQ群： 260655062
