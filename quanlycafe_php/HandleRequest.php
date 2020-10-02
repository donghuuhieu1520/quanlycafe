<?php
session_start();
date_default_timezone_set('Asia/Ho_Chi_Minh');
$conn = mysqli_connect('localhost:3306', 'root', '123456789', 'quanlycafe');
/* Kiểm tra kết nối */
if (mysqli_connect_errno()) {
    printf("Lỗi kết nối: %s\n", mysqli_connect_error());
    exit();
}
/* Set ký tự utf8*/
if (!mysqli_set_charset($conn, "UTF8")) {
    printf("Lỗi ký tự utf8: %s\n", mysqli_error($conn));
    exit();
}else{
}

function validateInput($conn, $text)
{
	$textValidated = mysqli_real_escape_string($conn, $text);
	return  htmlentities($textValidated);
}
if(isset($_POST['flag']))
{
	$flag = $_POST['flag'];
	switch ($flag) {
		case "login":
			if(isset($_POST['account'], $_POST['password']))
			{
				$account = validateInput($conn, $_POST['account']);
				$password = validateInput($conn, $_POST['password']);
				$query_string = mysqli_query($conn, "SELECT * FROM `staff` WHERE `account` = '$account'");
				if($query_string)
				{
					if(mysqli_num_rows($query_string) == 1)
					{
						$data = mysqli_fetch_array($query_string, MYSQLI_ASSOC);
						if($data['password'] === $password)
						{
							$_SESSION['isLogined'] = $account;
							$dateLogined = date('Y-m-d H-i-s');
							$query_insert_db_staffisonline = mysqli_query($conn, "INSERT INTO `staffisonline` (`account`, `timelogined`) VALUES ('".$account."', '".$dateLogined."')");
							$arrayResult = array(
								"logininfo" => "success",
								"id" => $data['id'],
								"account" => $data['account'],
								"password" => $data['password'],
								"fullname" => $data['fullname'],
								"email" => $data['email'],
								"phonenumber" => $data['phonenumber'],
								"address" => $data['address'],
								"birthdate" => $data['birthdate'],
								"datejoin" => $data['datejoin'],
								"status" => $data['status'],
								"accounttype" => $data['accounttype'],
								"gender" => $data['gender']
							);
							echo json_encode($arrayResult);
						}else
						{
							$arrayResult = array(
								"logininfo" => "fail",
								"errorDescribe" => "Tài khoản/Mật khẩu không chính xác.",
							);
							echo json_encode($arrayResult);
						}
					}else
					{
						$arrayResult = array(
							"logininfo" => "fail",
							"errorDescribe" => "Tài khoản không tồn tại.",
						);
						echo json_encode($arrayResult);
					}
				}else
				{
					$arrayResult = array(
								"logininfo" => "fail",
								"errorDescribe" => "Không thể thực hiện truy vấn",
							);
					echo json_encode($arrayResult);
				}
			}else
			{
				$arrayResult = array(
					"logininfo" => "fail",
					"errorDescribe" => "Không nhận được thông tin tài khoản và mật khẩu.",
				);
				echo json_encode($arrayResult);
			}
			break;
		case 'logout':
			$account = validateInput($conn, $_POST['account']);
			$query_remove_db_staffisonline = mysqli_query($conn, "DELETE FROM `staffisonline` WHERE `account` = '$account'");
			if($query_remove_db_staffisonline)
			{
				$arrayResult = array(
					"requestInfo" => "success"
				);
			}else
			{
				$arrayResult = array(
					"requestInfo" => "fail"
				);
			}
			echo json_encode($arrayResult);
			break;
		default:
			$arrayResult = array(
					"logininfo" => "fail",
					"errorDescribe" => "Request không hợp lệ.",
				);
			echo json_encode($arrayResult);
			break;
	}
}else
{
	$arrayResult = array(
					"logininfo" => "fail",
					"errorDescribe" => "Không nhận được request.",
				);
	echo json_encode($arrayResult);
}


?>