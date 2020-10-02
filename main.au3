#include 'include/GuiHTML_UDF_2.0.au3'
#include 'include/BinaryCall.au3'
#include 'include/JSON.au3'
#include 'include/http.au3'
#include "au3gui/login.au3"
#include "au3gui/home.au3"

Global Const $titleApplication = 'ICoffee - Phần Mềm Quản Lý Quán Cafe'
Global Const $messageBoxTheme = 'supervan'
Global Const $HTTP_REQUEST_URL = "http://localhost:3000/HandleRequest.php";
Global Const $METHOD_REQUEST = "POST"

$loginInfo = showLoginGUI()
showHomeGUI($loginInfo)



