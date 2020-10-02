


Func showHomeGUI($data)
   Const $widthFormHome = 978
   Const $heightFormHome = 600
   $hGuiHome = GUICreate($titleApplication, $widthFormHome + 2, $heightFormHome + 2, -1, -1, $WS_POPUP)
   GUISetBkColor("0x758488")
   HTML_Load(@scriptdir&'/html/home.html', $widthFormHome, $heightFormHome, 1, 1, 1)
   HTML_GUICtrlSetData('span-title-application', $titleApplication)
   HTML_EvalJS('document.addEventListener("contextmenu", function(e){ e.preventDefault();}, false);')
   Local $dataAppended = StringReplace(FileRead(@Scriptdir&"/html/home_danhsachban.html"), @CRLF, " ") ;
   HTML_EvalJS("$('#section-content').append('"&$dataAppended&"')")
   HTML_EvalJS(StringReplace(FileRead(@Scriptdir&"/html/home_danhsachban.js"), @CRLF, " "))
   HTML_GUICtrlSetData('span-user-fullname', Json_Get($data, '["fullname"]'))
   HTML_GUICtrlSetAttr('img-user-avatar', 'src', ( Number(Json_Get($data, '["gender"]')) == 1)?('../assets/img/male.png'):('../assets/img/female.png') )
   GUISetState()

   while 1
	  switch HTML_GUIGetMsg()
		 case $GUI_EVENT_CLOSE
			exit
		 case 'button-quit'
			exit
		 case 'button-minimize'
			GUISetState(@SW_MINIMIZE, $hFormLogin)
		 case 'a-user-profile'
			HTML_EvalJS('$(".sidebar-content li[class=\"active\"]").removeClass("active")')
			HTML_EvalJS(StringReplace(FileRead(@Scriptdir&"/html/home_profile.js"), @CRLF, " "))
			HTML_GUICtrlSetData('section-content', StringReplace(FileRead(@Scriptdir&"/html/home_profile.html"), @CRLF, " "))
			HTML_GUICtrlSetData('input-home-profile-fullname', Json_Get($data, '["fullname"]'));
			Local $strAccountBirthDate = Json_Get($data, '["birthdate"]')
			Local $aAccountBirthDate =  StringSplit($strAccountBirthDate, "-")
			HTML_GUICtrlSetData('input-home-profile-birthdate', $aAccountBirthDate[3]&"/"&$aAccountBirthDate[2]&"/"&$aAccountBirthDate[1])
			HTML_GUICtrlSetData('input-home-profile-gmail', Json_Get($data, '["email"]'));
			HTML_GUICtrlSetData('input-home-profile-numberphone', Json_Get($data, '["phonenumber"]'));
			HTML_GUICtrlSetData('input-home-profile-address', Json_Get($data, '["address"]'));
		 case 'a-user-logout'
			Local $data_request = 'flag=logout&account='&Json_Get($data, '["account"]')
			Local $request = _httpRequest($HTTP_REQUEST_URL, $METHOD_REQUEST, $data_request)
			Local $dataRequested = Json_Decode($request[2])
			If(Json_Get($dataRequested, '["requestInfo"]') == 'success') Then
			   RegDelete("HKEY_CURRENT_USER\Software\ICoffee\", "AccountLastLogin")
			   GUIDelete($hGuiHome)
			   return true;
			EndIf
		 case 'sidebar-danhsachban'
			HTML_EvalJS('$(".sidebar-content li").removeClass("active")')
			HTML_EvalJS('$("#sidebar-danhsachban").parent("li").addClass("active")')
			Local $dataAppended = StringReplace(FileRead(@Scriptdir&"/html/home_danhsachban.html"), @CRLF, " ") ;
			HTML_GUICtrlSetData('section-content', $dataAppended)
			HTML_EvalJS(StringReplace(FileRead(@Scriptdir&"/html/home_danhsachban.js"), @CRLF, " "))
		 case 'sidebar-danhmucdouong'
			HTML_EvalJS('$(".sidebar-content li").removeClass("active")')
			HTML_EvalJS('$("#sidebar-danhmucdouong").parent("li").addClass("active")')
			Local $dataAppended = StringReplace(FileRead(@Scriptdir&"/html/home_danhmucdouong.html"), @CRLF, " ") ;
			HTML_GUICtrlSetData('section-content', $dataAppended)
			HTML_EvalJS(StringReplace(FileRead(@Scriptdir&"/html/home_danhmucdouong.js"), @CRLF, " "))
	  endswitch
   wend
EndFunc

