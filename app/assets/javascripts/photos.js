$(function(){
    $('table.frame img').on('click',function(){
	var bgStyle = "url("+$(this).prop("src")+") no-repeat center center";
	$('div.big-frame').css("background",bgStyle)
			  .prop("title",$(this).prop("alt"));
    }).eq(0).trigger("click");
})
