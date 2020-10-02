
$("#checkbox-remember-account, #label-checkbox").click(function(){
	var isChecked = $("#checkbox-remember-account").prop("checked");
	if(isChecked)
	{
		$("#checkbox-remember-account").prop("checked", false);
	}else
	{
		$("#checkbox-remember-account").prop("checked", true);
	}
});

function showMessage(title, content, theme)
{
	$.alert({
		    title: title,
		    theme: theme,
		    content: content,
		    closeIcon: true,
		    dragable: true,
		    buttons: {
	
		    	Ok: {
		            text: "Ok", 
		            btnClass: "btn-blue",
		            keys: ['enter', 'a']
		        },
		    }
		});
};
function showSnackBar(messsage)
{
	Snackbar.show({text: messsage, pos: "bottom-right", actionTextColor: "#3498db"}); 
};
settime();
function settime(){
	setInterval(function(){
		var d = new Date();
		var hour = d.getHours();
		var timepostfix = "AM";
		if(hour > 12)
		{
			hour = d.getHours() - 12;
			timepostfix = "PM";
		}
		document.getElementById("date").innerHTML = getStringDay(d.getDay()) + ", " + getStringMonth(d.getMonth()) + " " + addZeroPostFix(d.getDate()) + ", " + d.getFullYear();
		document.getElementById("timer").innerHTML = addZeroPostFix(hour) + ":" + addZeroPostFix(d.getMinutes()) + " " + timepostfix;
	}, 1000);
};
function addZeroPostFix(number)
{
	if(number <= 9)
	{
		return "0"+number;
	}else
	{
		return number;
	}
};
function getStringDay(day)
{
	switch(day){
		case 0:
			return "Sun";
			break;
		case 1:
			return "Mon";
			break;
		case 2:
			return "Tue";
			break;
		case 3:
			return "Wed";
			break;
		case 4:
			return "Thu";
			break;
		case 5:
			return "Fri";
			break;
		case 6:
			return "Sat";
			break;
		default:
			return "Fail";
			break;
	}
};
function getStringMonth(month)
{
	switch(month){
		case 0:
			return "January";
			break;
		case 1:
			return "February";
			break;
		case 2:
			return "March";
			break;
		case 3:
			return "April";
			break;
		case 4:
			return "May";
			break;
		case 5:
			return "June";
			break;
		case 6:
			return "July";
			break;
		case 7:
			return "August";
			break;
		case 8:
			return "September";
			break;
		case 9:
			return "October";
			break;
		case 10:
			return "November";
			break;
		case 11:
			return "December";
			break;
		default:
			return "Fail";
			break;
	}
};