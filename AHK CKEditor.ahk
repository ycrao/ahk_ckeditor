Menu, Tray, NoStandard
Menu, Tray, Add, 官方网站, OpenOfficalWebsite
Menu, Tray, Add, 关于,ShowInfo
Menu, Tray, Add, 帮助, GetHelp
Menu,Tray, Add, 退出, Exit
/*
WB := ComObjCreate("InternetExplorer.Application") ; 创建 IE 对象
WB.Visible := true ; 由于 IE 对象默认是隐藏的 (后台), 这里让它显示出来, 这样我们可以看到操作的效果
WB.Navigate("http://127.0.0.1/examples/min.html") ; 导航到网页
*/
#Persistent
#SingleInstance ignore
SetTitleMatchMode, 2
WM_KEYDOWN = 0x100
OnMessage(WM_KEYDOWN, "WM_KeyDown")
htmlpath = %A_ScriptDir%\html
csspath = %htmlpath%\css
filename := A_Now
htmltitle := "Untitled"
HomeURL = http://raoyc.com/ckeditor/samples/editor.html
;HomeURL = http://fysoft.googlecode.com/svn/trunk/ckeditor/samples/editor.html
;Gui Add, Button, xm ym w150 -default gGetEditorContent, 获取编辑框内HTML代码
Gui, Add, Text, xm ym+5 w160 h20, HTML文件名(不含.html后缀):
Gui, Add, Edit, xm+170 ym w100 h20 vHTMLFileName, %filename%
Gui, Add, Text, xm+280 ym+5 w80 h20,  HTML文档标题:
Gui, Add, Edit, xm+370 ym w150 h20 vHTMLTitle, %htmltitle%
Gui Add, Button, xm+530 ym w100 h20 -default gGetEditorContent, 生成HTML文档
Gui, Add, DropDownList, xm+640 ym w200 h50 vSite  Choose1, Official Site(Default)|Google Code Mirror Site
Gui, Add, Button, xm+850 ym w50 h20 -default gFresh, 刷新
Gui Add, ActiveX, xm ym+30 w1000 h670 vwb, Shell.Explorer
;Gui, Add, Text, xm y170 w300 h45, 本软件由KindEditor和AutoHotkey共同构建`n获取最新版或反馈意见和建议请进官方QQ群260655062`n飞扬网络工作室 ©2013 版权所有
Gui, Show, w990 h680, AHK CKEditor
;Gui,+AlwaysOnTop +LastFound +Border
;winset,transparent,210
Gui,+Border
wb.Silent := true
wb.Navigate(HomeURL)

while, wb.ReadyState != 4
    Sleep, 10
return

/*
;禁用网页内右键菜单start
ComObjConnect(wb,"ie_")
ie_DocumentComplete()
{
        global wb
        js = javascript:document.oncontextmenu=function(){return false;};
        wb.Document.parentWindow.execScript(js)
}
*/
/*
;响应网页内快捷键
OnMessage(0x100, "gui_KeyDown", 2)
gui_KeyDown(wParam, lParam, nMsg, hWnd) {
        global wb
        pipa := ComObjQuery(wb, "{00000117-0000-0000-C000-000000000046}")
        VarSetCapacity(kMsg, 48)
        NumPut(A_GuiY, NumPut(A_GuiX, NumPut(A_EventInfo, NumPut(lParam, NumPut(wParam, NumPut(nMsg, NumPut(hWnd, kMsg)))), "uint"), "int"), "int")
        Loop 2
                r := DllCall(NumGet(NumGet(1*pipa)+5*A_PtrSize), "ptr", pipa, "ptr", &kMsg)
        until wParam != 9 || wb.document.activeElement != ""
        ObjRelease(pipa)
        if r = 0 
                return 0
}
*/

WM_KEYDOWN(wParam, lParam, nMsg, hWnd) {
	global wb
	static fields := "hWnd,nMsg,wParam,lParam,A_EventInfo,A_GuiX,A_GuiY"
	WinGetClass, ClassName, ahk_id %hWnd%
	if (ClassName = "Internet Explorer_Server") {	
		; http://www.autohotkey.com/community/viewtopic.php?p=562260#p562260
		pipa := ComObjQuery(wb, "{00000117-0000-0000-C000-000000000046}")
		VarSetCapacity(kMsg, 48)
		Loop Parse, fields, `,
			NumPut(%A_LoopField%, kMsg, (A_Index-1)*A_PtrSize)
		; Loop 2 ; only necessary for Shell.Explorer Object
			r := DllCall(NumGet(NumGet(1*pipa)+5*A_PtrSize), "ptr",pipa, "ptr",&kMsg)
		ObjRelease(pipa)
		if r = 0 ; S_OK: the message was translated to an accelerator.
			return 0
	}
}
/*
WB := ComObjCreate("InternetExplorer.Application") ; 创建 IE 对象
WB.Visible := true ; 由于 IE 对象默认是隐藏的 (后台), 这里让它显示出来, 这样我们可以看到操作的效果
WB.menubar := 0 ;不显示IE对象菜单栏
WB.AddressBar := 0 ;不显示IE对象地址栏
WB.ToolBar := 0 ;不显示IE对象工具栏
WB.StatusBar := 0 ;不显示IE对象状态栏
WB.FullScreen := 1 ;全屏化IE对象
WB.Width := 800 ;设置IE对象宽度
WB.Height := 600 ;设置IE对象高度
WB.Resizable := 0 ;设置IE对象大小是否可以被改动
*/
;text := WB.document.documentElement.innerText  ;获取HTML文档文本
;text := WB.document.body.innerHTML
;text := WB.document.getElementsByTagName("iframe")[0].contentWindow.document.body.innerHTML ;获取到了iframe元素
;WB.document.getElementsByTagName("input")[0].click()    ;点击第一个input
;WB.Navigate("javascript:dosth()")
;Msgbox %text%
;gethtmlcontent = javascript:var htmlcontent = CKEDITOR.instances.ckeditor.getData(); 
;WB.Document.parentWindow.execScript(gethtmlcontent)
;content := WB.Document.Script.htmlcontent ;AHK实现取得JS数据对象
;MsgBox, %content%


GuiClose:
Gui, Destroy
ObjRelease(pipa)
ExitApp

EXIT:
Gui, Destroy
ObjRelease(pipa)
ExitApp

ShowInfo:
MsgBox, 32, 欢迎使用AHK CKEditor, 您当前正在使用的版本为 v2.2, 此版取代之前旧版“静态网页编辑器及生成器(SHEM)”,旧版使用KindEditor作为编辑器内核，而新版使用CKEditor 4作为编辑器内核。`n获取最新版或反馈意见和建议请进官方QQ群260655062`n飞扬网络工作室 ©2013 版权所有
return

GetHelp:
run http://raoyc.com/fysoft/ahk_ckeditor_help.html
return

OpenOfficalWebsite:
run http://raoyc.com/fysoft/ahk_ckeditor.html
return

GetEditorContent:
Gui,Submit,nohide
if(HTMLFileName = "" AND HTMLTitle = "")
	MsgBox, HTML文件名和文档标题不为空
else
{
	RegExMatch(HTMLFileName, "[^\w_\\\:\s``~#@\$%\^&\(\);,=\+-\[\]\{\}]+", _ExistChinese)
	if _ExistChinese
	{
		MsgBox, HTML文件名包含中文或英文特殊字符，请重新输入后再试
	}
	else
	{
		gethtmlcontent = javascript:var htmlcontent = CKEDITOR.instances.ckeditor.getData(); 
		WB.Document.parentWindow.execScript(gethtmlcontent)
		content := WB.Document.Script.htmlcontent ;AHK实现取得JS数据对象
		html =
		(
<!DOCTYPE html>
<html>
	<head>
		<title>%HTMLTitle%</title>
		<meta charset="utf-8" />
		<link href="css/contents.css" rel="stylesheet" />
	</head>
	<body>
		%content%
	</body>
</html>
		)
		ifNotExist, %csspath%
			FileCreateDir, %csspath%
		ifNotexist, %csspath%\contents.css
		{
			css =
			(
.cke_editable
{
	font-size:13px;
	line-height:1.6em;
}
blockquote
{
	font-style:italic;
	font-family:Georgia, Times, "Times New Roman", serif;
	padding:2px 0;
	border:0 solid #ccc;
}
.cke_contents_ltr blockquote
{
	padding-left:20px;
	padding-right:8px;
	border-left-width:5px;
}
.cke_contents_rtl blockquote
{
	padding-left:8px;
	padding-right:20px;
	border-right-width:5px;
}
ol,ul,dl
{
	*margin-right:0;/* IE7: reset rtl list margin. (#7334) */
	padding:0 40px;/* preserved spaces for list items with text direction other than the list. (#6249,#8049)*/
}
h1,h2,h3,h4,h5,h6
{
	line-height:1.2em;
}
hr
{
	border:0;
	border-top:1px solid #ccc;
}
img.right
{
	border:1px solid #ccc;
	float:right;
	margin-left:15px;
	padding:5px;
}
img.left
{
	border:1px solid #ccc;
	float:left;
	margin-right:15px;
	padding:5px;
}
img:hover
{
	opacity:.9;
	filter:alpha(opacity = 90);
}
body
{
	color:#333;
	margin:20px;
	font-family:Verdana, Arial, Helvetica, sans-serif, "MS sans serif";
	font-size:75`%;
	border:0;
	background-color:#FFF;
	line-height:145`%;
}
h1
{
	font-size:150`%;
	font-weight:normal;
	margin:0;
	padding:0 0 .5em 4px;
	border-bottom:2px ridge #FFF;
}
h2
{
	font-size:135`%;
	font-weight:bold;
	font-family:Arial, Helvetica, sans-serif, "MS sans serif";
	background-color:#405871;
	color:#FFF;
	margin:1.5em 0 .5em;
	padding:.1em 0 .1em .2em;
}
h3
{
	font-size:115`%;
	font-weight:bold;
	background-color:#E6E6E6;
	margin:1.0 0 .5em;
	padding:.1em 0 .1em .2em;
	border-top:1px solid silver;
	border-bottom:1px solid silver;
}
h4
{
	font-size:100`%;
	margin:.7em 0;
	border-bottom:1px solid lightgrey;
}
ul,ol,p
{
	margin-top:.7em;
	margin-bottom:.7em;
}
li
{
	margin-top:.2em;
	margin-bottom:.2em;
	margin-left:-.75em;
}
a
{
	color:#0782C1;
	text-decoration:none;
}
a:link,a:active
{
	color:#00A;
}
a:visited
{
	color:#A0A;
}
a:hover
{
	text-decoration:underline;
	color:#66C;
}
.Indent
{
	margin-left:2em;
}
.NoIndent
{
	margin-left:0;
	margin-right:0;
}
pre,code,.Syntax
{
	font-family:Consolas, Courier New, monospace;
}
pre,code
{
	background-color:#F3F3FF;
	border:solid 1px #E3E3EF;
}
.Syntax
{
	background-color:#FFA;
	border:solid 1px #E8E89A;
}
code,span.Syntax
{
	padding:0 1px;
}
pre
{
	margin:.7em 1.5em;
	padding:.7em 0 .7em .7em;
	white-space:pre-wrap;/* CSS 2.1, works in IE8 but apparently not CHM viewer*/
	word-wrap:break-word;/* IE7(-) CSS Hack, works in CHM viewer */
}
pre.Syntax
{
	margin:0 0 1.0;
	padding:12px 0 12px 4px;
	line-height:150`%;
}
pre,pre.Short
{
	line-height:120`%;
}
pre em,code em
{
	color:green;
	font-style:normal;
}
table
{
	border:1px solid #000;
	border-collapse:collapse;
}
table td,table th
{
	border:1px solid #000;
	padding:.3em;
}
table.info
{
	border:solid 2px #C0C0C0;
	border-collapse:collapse;
	width:100`%;
}
table.info td
{
	border:solid 2px #C0C0C0;
	padding:.3em;
}
table.info th
{
	background-color:#F6F6F6;
	padding:.3em;
}
h1 .ver,h2 .ver,h3 .ver
{
	font-size:65`%;
	font-weight:400;
	margin-left:1em;
	vertical-align:top;
}
h2 .ver
{
	color:lightgray;
	font-size:80`%;
}
.ver,.dull
{
	color:gray;
}
.red
{
	color:red;
}
.blue
{
	color:blue;
}
.note
{
	border:1px solid #9B9;
	background-color:#E6FFE6;
	color:#050;
	padding:0 3px;
}
.methodShort
{
	border:solid thin #C0C0C0;
	padding:.5em;
	margin-bottom:1em;
}
.methodShort h2
{
	margin-top:0;
}
.methodShort table.info
{
	border:none;
}
.methodShort table.info td
{
	border:none;
	vertical-align:text-top;
}
.methodShort:target
{
	border-color:black;
}
pre.prettyprint
{
	background-color:#F8F8F8;
	border:1px solid #DDD;
	padding:10px;
}
			)
			FileAppend, %css%, %csspath%\contents.css, UTF-8
		}
		outputfile = %htmlpath%\%HTMLFileName%.html
		IfNotExist, %outputfile%
		{
			ifNotExist, %htmlpath%
				FileCreateDir, %htmlpath%
			ifNotExist, %csspath%
				FileCreateDir, %csspath%
			FileAppend, %html%, %outputfile%, UTF-8
			Run, %outputfile%
		}
		else
		{
			MsgBox, 4, html目录下已经存在同名文件，是否覆盖, 点击是，以新文件覆盖；否，保留旧文件
			IfMsgBox Yes
			{
				FileDelete, %outputfile%
				FileAppend, %html%, %outputfile%, UTF-8
				Run, %outputfile%
			}
		}
	}
}
return

Fresh:
Gui,Submit,nohide
if(site = "Official Site(Default)")
{
	WB.Silent := true
	WB.Navigate("http://raoyc.com/ckeditor/samples/editor.html")
}
else 
{	
	WB.Silent := true
	WB.Navigate("http://fysoft.googlecode.com/svn/trunk/ckeditor/samples/editor.html")
}
return