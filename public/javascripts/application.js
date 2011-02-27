$(function() {
	console.log('foobar');
	$('a.power').live('click', function() {
		$('iframe#power').attr('src', this.href);
		return false;
	});
})