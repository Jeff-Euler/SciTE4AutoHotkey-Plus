; SciTE4AutoHotkey v3 user autorun script
;
; You are encouraged to edit this script!
;

#NoEnv
#NoTrayIcon

����:
	SetWorkingDir, %A_ScriptDir%
	oSciTE := ComObjActive("SciTE4AHK.Application")
	SciTE_Hwnd := oSciTE.SciTEHandle

	gosub, ���İ����Ѻ���ʾ
	gosub, ����Tab
	gosub, ���ܱ��

	;��SciTE�˳�
	WinWaitClose, ahk_id %SciTE_Hwnd%
	WinClose, ahk_class HH Parent ahk_exe keyhh.exe
	ExitApp
return

;�ڰ����ļ������ڣ���F1û��Ӧ������£��Ѻõ���ʾʹ���߸���ô����
���İ����Ѻ���ʾ:
	;�����޸��˰���F1��ʱ���ð����ļ������ƣ�������������һ���Ѻ���ʾ���ð�F1û��Ӧ����֪������ô���¡�
	;֮���Բ�ֱ��ʹ�á�#If (FileExist(abc))��������Ϊ�����ᱨ��
	keyhh·��:=oSciTE.SciTEDir . "\tools\keyhh.exe"
	���İ���·��:=oSciTE.SciTEDir . "\..\AutoHotkey_CN.chm"
	keyhh�Ƿ����:=FileExist(keyhh·��)
	���İ����Ƿ����:=FileExist(���İ���·��)
return

;2020.7.24������F1��ȫ��ӹ�F1���ܣ�����Ҫ���Ρ�SciTEUser.properties����platforms.properties���ļ��е��Դ�F1����
;���ơ�����F1�������÷�Χֻ��scite��
#If WinActive("ahk_id " . SciTE_Hwnd)
F1::
	;���İ��������ڣ������һ���Ѻõ���ʾ
	if (!���İ����Ƿ����)
		MsgBox, 262160, û���ҵ����İ����ļ����F1����ʧЧ, ��������GitHub��QQȺ����һ�ݰ����ļ�`n������Ϊ��AutoHotkey_CN.chm��`n����ڡ�AutoHotkey.exe��ͬĿ¼�¡�
	else if (!keyhh�Ƿ����)
		MsgBox, 262160, û���ҵ� keyhh.exe ���F1����ʧЧ, ���������� keyhh.exe `n����ڡ�SciTE.exe\tools��Ŀ¼�¡�
	else
	{
		Send, ^{Left}^+{Right}
		Sleep, 50			;��ʱ�Ǳ���ģ�����ż����ȡ������
		����µ���:=" " Trim(oSciTE.Selection(), " `t`r`n`v`f")			;������Ŀհ׷�ȥ������Ȼ��else���޷�����ȷ��������ڵ���ǰ���һ���ո���������������ʱ�����ٲ���
		;~ IfWinNotExist, ahk_class HH Parent ahk_exe keyhh.exe			;Ҫ������ȶ��ԣ���ֻ��ÿ�ζ��� keyhh �򿪰���
			Run, % keyhh·�� " -ahkhelp " ���İ���·��			;keyhh ����ͨ������ -#klink "IsCompiled" �����ַ��������У���Ҫ��ʽ�������棩
		WinWait, ahk_class HH Parent ahk_exe keyhh.exe			;���в����٣�����������޷���������ļ�
		WinActivate, ahk_class HH Parent ahk_exe keyhh.exe
		WinWaitActive, ahk_class HH Parent ahk_exe keyhh.exe
		SendInput, !n^a{BackSpace}			;�������������
		SendInput, {Ctrl Up}{Shift Up}{Alt Up}			;ǿ���ͷ����μ��������bug
		SendInput, {Blind}{Text}%����µ���%			;ԭ��ķ��ͻ�ȡ���ĵ��ʣ�����#if��֮��Ļᱻ���������text ģʽ�� raw ģʽ�������ǣ�text ���Ժ������뷨״̬
		SendInput, {Home}{Del}{End}{Enter}{Enter}			;��Ϊ����ǰ���������һ���ո������������룬�������������Ҫɾ���Ǹ�����Ŀո�
	}
return
#If

;�����Զ����ʱʹ��TAB�������Զ���ȫ��������ȣ�����ò�������ʱ��������TAB������ڲ�������Ծ����Ч�����������롣
;BUG��
;	������߲�����ת����������š�
;	��ʱ��Ī�����ļ��С�
;	�����к��������ַ�������Ӣ�����ţ���\����/���ȵȣ�ʱ�޷����Զ�ѡ�С�
;	��������ʱҲ����������tab�����絥��password����
����Tab:
	��� := 0
return

;�Զ����״̬��,ʹ��Tab��չ��������,��ѡ�е�һ������
#If (���=0) and WinExist("ahk_class ListBoxX") and WinActive("ahk_id " . SciTE_Hwnd)
~$Tab::
	;SendInput ���Ϳ�ݼ��ǲ�һ����Ч�ģ�����ȫ��ʹ�� Send ���档
	Send, ^b											;չ��������
	Send, ^+{Right}											;���������ļ����Ѿ����ù����λ��Ϊ����ǰ,��������ֱ��ѡ����һ���ʾ�����
	;�����������λ���ж�һ��ѡ�������Ƿ�Ϊ�վͿ�������bug����������ʱҲ����������tab�����絥��password������Ȼ��ȴ�����˻�ȡѡ������ʱ����Чʱ��ʧЧ�����⡭��
	Sleep, 50
	if (oSciTE.Selection="")
		return
	��� := 1
	ToolTip, ����Tab ������
return

;ʹ��Tab�ڲ�������Ծ
;����Tab�����ڼ䣬tab��ֻ���ڲ�������Ծ����һ������
#If  (���=1) and !WinExist("ahk_class SoPY_Comp") and WinActive("ahk_id " . SciTE_Hwnd)
$Tab::
	if (oSciTE.Selection<>"")									;��ǰ����ѡ������,�����Ҽ�ͷȡ��ѡ��״̬
		Send, {Right}
	Loop,25
	{
		Send, ^+{Right}										;ѡ�����浥��
		ѡ���ı� := oSciTE.Selection								;��ȡ��ѡ�е�����
		if (ѡ���ı�="")									;���һ��
		{
			Send, {Right}
			Send, {Enter}
			��� := 0
			ToolTip,
			return
		}
		else if (SubStr(ѡ���ı�, 1, 2)="`r`n" or SubStr(ѡ���ı�, -1, 2)="`r`n")		;��ĩ
		{
			Send, ^{Left}
			Send, {Enter}
			��� := 0
			ToolTip,
			return
		}
		else if (SubStr(ѡ���ı�, 0, 1)=")")							;�������ŵ���ĩ
		{
			Send, {Right}
			continue
		}
		else if (SubStr(RTrim(ѡ���ı�, " `t`r`n`v`f"), 0, 1)=",")				;���ź���Ĳ���
		{
			Send, {Right}
			Send, ^+{Right}
			return
		}
		else if (Trim(ѡ���ı�, " `t`r`n`v`f")="in")				;רΪ for ����
		{
			Send, {Left}
			Send, {Space}
			Send, ^{Right}
			Send, ^+{Right}
			return
		}
	}
	��� := 0
	ToolTip,
return

;���ڡ��Զ���ɿ��롰�ѹ����뷨�򡱲�����ʱ���س�������Ϊ���ر�����tab��
;���Զ���ɿ򡱴���ʱ���س�������Ϊ�����Զ���ɵ���
;���ѹ����뷨�򡱴���ʱ���س�������Ϊ���������Ӣ�ġ�������⣬���ѹ����뷨�����ʱ���س�������������Ӣ�ĵ�����
#If  (���=1) and !WinExist("ahk_class ListBoxX") and !WinExist("ahk_class SoPY_Comp") and WinActive("ahk_id " . SciTE_Hwnd)
$NumpadEnter::
$Enter::
	if (oSciTE.Selection<>"")									;��ǰ����ѡ������,�����Ҽ�ͷȡ��ѡ��״̬
		Send, {Right}
	;alt+end �� alt+shift+end����ѡ�е���ĩ�������Ǻ����������Զ�����ʱ����ѡ�е���������ĩ
	Send, +{End}											;ѡ�����ֵ���ĩ
	if (SubStr(RTrim(oSciTE.Selection, " `t`r`n`v`f"), 0, 1)=")")					;��������һ���ǿհ��ַ��Ƿ��Ǳ�����,����һ��������
		Send, {Asc 41}			;ʹ�á�{Asc 41}�����ǡ�)��������Ϊǰ�������뷨Ϊ���ı�������£���Ȼ���Է���Ӣ�ķ��š�
	Send, {Enter}
	��� := 0
	ToolTip,
return
#If

;�ڴ��������������Ӣ��
;��ע��������������뷨����
;�����и�Сbug����������ע�͵����״����������뷨״̬�£�����һ��Ӣ���֣����硰f����Ȼ���á�shift������Ӣ������
;��ʱ��ȡ���ĸ���״̬�ǲ���ȷ��
;������������ٶ�һ�¹������ܻ�ȡ����ȷ����״̬�ˣ��������bug����û�κ�Ӱ��
���ܱ��:
	ime:=new ���ܱ��()
	SetTimer, ��ȡ��ǰλ���﷨�������, 50
return

��ȡ��ǰλ���﷨�������:
	;���λ�÷����仯��ʱ���ȡһ�ε�ǰλ�õĸ������
	if (A_CaretX<>x or A_CaretY<>y)
	{
		x:=A_CaretX,y:=A_CaretY
		style:=ime.��ȡ��ǰλ���﷨�������()
	}
return

#If Style="����" and WinActive("ahk_id " . SciTE_Hwnd)
	;����������Ƿ���
	$`::����ԭ���ַ�("``")
	$[::����ԭ���ַ�("[")
	$]::����ԭ���ַ�("]")
	$;::����ԭ���ַ�(";")
	$'::����ԭ���ַ�("'")
	$\::����ԭ���ַ�("\")
	$,::����ԭ���ַ�(",")
	$.::����ԭ���ַ�(".")
	$/::����ԭ���ַ�("/")
	;shift�밴����ϵķ���
	$+1::����ԭ���ַ�("!")
	$+4::����ԭ���ַ�("$")
	$+6::����ԭ���ַ�("^")
	$+9::����ԭ���ַ�("(")
	$+0::����ԭ���ַ�(")")
	$+-::����ԭ���ַ�("_")
	$+;::����ԭ���ַ�(":")
	$+'::����ԭ���ַ�("""")
	$+,::����ԭ���ַ�("<")
	$+.::����ԭ���ַ�(">")
	$+/::����ԭ���ַ�("?")
return
#If

class ���ܱ��
{
	Static hSci

	;��ȡScintilla��hwnd
	__New()
	{
		oSciTE := ComObjActive("SciTE4AHK.Application")
		hEditor:=oSciTE.SciTEHandle
		;Com�õ��ľ��SciTE�ģ�����Ҫ����Scintilla��
		;Get handle to focused control
		ControlGetFocus, cSci, ahk_id %hEditor%
		;Check if it fits the class name
		if InStr(cSci, "Scintilla")
		{
			ControlGet, hSci, Hwnd,, %cSci%, ahk_id %hEditor%
			this.hSci:=hSci
			return,	this
		}
		else
			return, 0
	}

	;�������Ϊ1ʱ�������λ��Ϊ��ע��
	;�������Ϊ2ʱ�������λ��Ϊ��ע��
	;�������Ϊ6ʱ�������λ��Ϊ�ַ���
	;�������Ϊ20ʱ�������λ��Ϊ�﷨���󣨱����������ַ�����ֻ������һ��˫����ʱ��
	;�������Ķ��壬��lpp.style�ļ���
	;����һ�����⣬����һ����ݼ�*�ἤ���������
	;���赱ǰ������100��������*������Ӧ�ñ�Ϊ101
	;�������ʱͨ��SCI_GETCURRENTPOS�õ���������Ȼ��100���ٴ���SCI_GETSTYLEAT
	;����ֵ����Զ��0
	;ʹ�����ñ�����A_CaretX����A_CaretY�������SCI_GETCURRENTPOS����û�ٳ��ֹ��������
	;��Ȼ����Ҳ���ܸ�������50ms��ʱ�й�
	��ȡ��ǰλ���﷨�������()
	{
		;~ SCI_GETCURRENTPOS  2008
		;~ SCI_GETSTYLEAT  2010
		SendMessage, 2008, 0, 0, , % "ahk_id " this.hSci
		SendMessage, 2010, ErrorLevel, 0, , % "ahk_id " this.hSci
		if ErrorLevel in 1,2,6		;��Ȼ������6��20Ҳ�����ַ�������Ҳ�ǿ��������ı��ģ�����ʵ��������������һ��Ӣ��˫���ź󣬵ڶ���Ӣ��˫���žͺ��������
			return, "ע��"			;��ע��������������뷨���о���
		else
			return, "����"			;�ڴ����������ʼ��ΪӢ��
	}
}

;���ַ���ԭ���ַ��ķ�ʽ���Աܿ����뷨������
����ԭ���ַ�(�ַ�)
{
	ascii:=Asc(�ַ�)
	SendInput, {Asc %ascii%}
}