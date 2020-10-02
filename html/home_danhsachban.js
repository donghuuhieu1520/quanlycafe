/*
	*Note: To ensure this script works fine in autoit, we recommend:
			- Only use quotes instead of parentheses
			- Use "/*" to comment
			- end each command with ;
*/
$(".btn-select-type-table").click(function(event){
	var btn_clicked = $(this);
	$(".btn-select-type-table").removeClass("btn-default");
	btn_clicked.addClass("btn-default");
	var typeTableWannaSee = btn_clicked.attr("data-type-table");
	$(".tableInShop").hide();
	if(typeTableWannaSee == "table-all")
	{
		$(".tableInShop").show();
	}else if(typeTableWannaSee == "table-ordered")
	{
		$(".tableInShop[data-type-table=\"ordered\"]").show();
	}else
	{
		$(".tableInShop[data-type-table=\"empty\"]").show();
	}
	
});
$(".btn-clean-table").click(function(){
	Snackbar.show({text: "Đã dọn bàn này!", pos: "bottom-right", actionText: "ẨN"}); 
});