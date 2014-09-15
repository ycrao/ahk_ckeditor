/*
AutoHotkey标准库用户库扩展计划(AutoHotkey Standard Library and User Library Expanding Plan)
类库名称：	GREP
类库分类：	数据处理 - 正则扩展
计划发起者:	fysoft
网站:	http://raoyc.com/fysoft/aslulep
脚本编码：	ANSI
脚本说明：	扩展正则功能
脚本版本：	2.0
脚本作者：	polyethene
备注： 更多说明请参考说明文档
*/

/*
	Function: grep
		Sets the output variable to all the entire or specified subpattern matches and returns their offsets within the haystack.

	Parameters:
		h - haystack
		n - regex
		v - output variable (ByRef)
		s - (optional) starting position (default: 1)
		e - (optional) subpattern to save in the output variable, where 0 is the entire match (default: 0)
		d - (optional) delimiter - the character that seperates multiple values (default: EOT (0x04))

	Returns:
		The position (or offset) of each entire match.

	Remarks:
		Since multiple values are seperated with the delimiter any found within the haystack will be removed.

	License:
		- Version 2.0 <http://www.autohotkey.net/~polyethene/#grep>
		- Dedicated to the public domain (CC0 1.0) <http://creativecommons.org/publicdomain/zero/1.0/>
*/
grep(h, n, ByRef v, s = 1, e = 0, d = "") {
	v =
	StringReplace, h, h, %d%, , All
	Loop
		If s := RegExMatch(h, n, c, s)
			p .= d . s, s += StrLen(c), v .= d . (e ? c%e% : c)
		Else Return, SubStr(p, 2), v := SubStr(v, 2)
}
