$(function() {
	console.log('foobar');
	$('a.power').live('click', function() {
		var li = $(this).parent();
		li.siblings().removeClass('selected');
		li.addClass('selected');
		$('iframe#power').attr('src', this.href);
		return false;
	});
})