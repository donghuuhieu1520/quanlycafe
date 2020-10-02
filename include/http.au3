#include-once

Func _httpRequest($url, $method = 'GET', $postData = '')
	$method = StringLower($method)
	Local $oHTTP = ObjCreate('WinHttp.WinHttpRequest.5.1')
	$oHTTP.Open($method, $url, False)
	$oHTTP.SetRequestHeader('User-Agent', 'Juno_okyo - AutoIt v' & @AutoItVersion)
	$oHTTP.SetRequestHeader('Referer', 'https:/junookyo.blogspot.com/')
	$oHTTP.SetRequestHeader('X-Requested-With', 'XMLHttpRequest')
	If $method = 'get' Then
		$oHTTP.Send()
	Else
		$oHTTP.SetRequestHeader('Content-Type', 'application/x-www-form-urlencoded')
		$oHTTP.SetRequestHeader('Content-Length', StringLen($postData))
		$oHTTP.Send($postData)
	EndIf
	$oHTTP.WaitForResponse
	Local $HeaderResponses = $oHTTP.GetAllResponseHeaders()
	Local $ret[4]
	If StringInStr($HeaderResponses, 'Location:') <> 0 Then
		$ret["0"] = $oHTTP.GetResponseHeader('Location')
		$ret["1"] = 1
	Else
		$ret["0"] = ''
		$ret["1"] = 0
	EndIf
	$ret["2"] = $oHTTP.Responsetext
	$ret["3"] = $oHTTP.GetAllResponseHeaders()
	Return $ret
EndFunc

Func urlEncode($vData)
    If IsBool($vData) Then Return $vData
	Local $aData = StringToASCIIArray($vData, Default, Default, 2)
	Local $sOut = '', $total = UBound($aData) - 1
	For $i = 0 To $total
		Switch $aData[$i]
			Case 45, 46, 48 To 57, 65 To 90, 95, 97 To 122, 126
				$sOut &= Chr($aData[$i])
			Case 32
				$sOut &= '+'
			Case Else
				$sOut &= '%' & Hex($aData[$i], 2)
		EndSwitch
	Next
	Return $sOut
EndFunc
