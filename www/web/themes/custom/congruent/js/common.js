/* - Javascript- */

(function($, Drupal) {
	window.onscroll = function() {myFunction()};

function myFunction() {
  var winScroll = document.body.scrollTop || document.documentElement.scrollTop;
  var height = document.documentElement.scrollHeight - document.documentElement.clientHeight;
  var scrolled = (winScroll / height) * 100;
  document.getElementById("myBar").style.width = scrolled + "%";
} 

//$(document).ready(function(){
	//$('.eventslink').mouseover(function() {
		//alert("hi");
	//$('.usa_img').show();
//alert("hi"); 
	//});
// });
$('.usa_img').hide();
$('#eventslink').mouseover(function (e) {
	//alert("hit");
	//$('.usa_img').css('opacity','0');
	$('.usa_img').show();
});
$('#eventslink').mouseout(function (e) {
	//alert("no");
	//$('.usa_img').css('opacity','1');
	$('.usa_img').hide();
})

})(jQuery, Drupal);

