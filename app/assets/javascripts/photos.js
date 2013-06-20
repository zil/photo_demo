$(function(){
    $('table.frame img').on('click',function(){
	var bgStyle = "url("+$(this).prop("src")+") no-repeat center center";
	$('div.big-frame').css("background",bgStyle);
	$.get("/photos/"+$(this).prop('id') + '/edit').done(function(d){
	    $('div.des').html(d);
	});
    }).eq(0).trigger("click");
})