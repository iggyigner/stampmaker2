window.onload = function() {

	var fileField = document.getElementById('assetImage'),
		urlField = document.getElementById('assetURL');

	urlField.addEventListener('focus', function() {
		fileField.value ='';
	});

};