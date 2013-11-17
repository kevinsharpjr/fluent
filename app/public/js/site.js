$.fn.clickToggle = function (func1, func2) {
	var funcs = [func1, func2];
	this.data('toggleclicked', 0);
	this.click(function () {
		var data = $(this).data();
		var tc = data.toggleclicked;
		$.proxy(funcs[tc], this)();
		data.toggleclicked = (tc + 1) % 2;
	});
	return this;
};

$(document).ready(function() {
  // Position the areas panel
  $('#areas').show().delay(500).animate({left:'-48em'},250).animate({left:'-51em'},250);
  
  // Allow the areas panel to be opened and closed
	$(".open").clickToggle(
	function () {
		$(this).text('-');
		$("#areas").animate({
			left : 0
		}, 250);
	},
	function() {
		$(this).text('+');
		$("#areas").animate({
			left : '-51em'
		}, 250);
	});
});
