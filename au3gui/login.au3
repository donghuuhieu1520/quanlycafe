Func showLoginGUI()
   Const $widthFormLogin = 800;500
   Const $heightFormLogin = 600;430
   $hFormLogin = GUICreate($titleApplication, $widthFormLogin + 2, $heightFormLogin + 2, -1, -1, $WS_POPUP)
   GUISetBkColor("0x758488")
   HTML_Load(@scriptdir & '/html/login.html', $widthFormLogin, $heightFormLogin, 1, 1, 1)
   HTML_GUICtrlSetData('span-title-application', $titleApplication)
   HTML_EvalJS(StringReplace(FileRead(@Scriptdir&"/html/login.js"), @CRLF, " "))
   HTML_EvalJS('document.addEventListener("contextmenu", function(e){ e.preventDefault();}, false);')
   GUISetState()
   while 1
	  switch HTML_GUIGetMsg()
		 case $GUI_EVENT_CLOSE
			exit
		 case 'button-quit'
			exit
		 case 'button-minimize'
			GUISetState(@SW_MINIMIZE, $hFormLogin)
		 case 'btn-login'
			$account = HTML_GUICtrlRead('inp-account')
			$password = HTML_GUICtrlRead('inp-password')
			If($account == "" OR $password == "") Then
			   ;HTML_EvalJS("showMessage('Thông báo!', 'Bạn vui lòng điền đủ thông tin tài khoản và mật khẩu.', '"&$messageBoxTheme&"')")
			   HTML_EvalJS("showSnackBar('Vui lòng điền đủ thông tin đăng nhập.')")
			Else
			   	HTML_GUICtrlSetAttr('btn-login', 'disabled', 'true')
			   	Sleep(400)
			   	Local $data = 'flag=login&account=' & $account & _
						     '&password=' & $password
				Local $request = _httpRequest($HTTP_REQUEST_URL, $METHOD_REQUEST, $data)
			   	Local $logininfo = Json_Decode($request[2])
				If(Json_Get($logininfo, '["logininfo"]') == "fail") Then
					HTML_EvalJS("showMessage('Thông báo!', '"& Json_Get($logininfo, '["errorDescribe"]') &"', '"&$messageBoxTheme&"')")
					HTML_GUICtrlRemoveAttr('btn-login', 'disabled')
				Else
					RegWrite("HKEY_CURRENT_USER\Software\ICoffee\", "AccountLastLogin", "REG_SZ", Json_Get($logininfo, '["account"]'))
					GUIDelete($hFormLogin)
					return $logininfo
				EndIf
			EndIf
	  endswitch
   wend
EndFunc

