$(document).ready(function(){
			CameraTag.observe('jitest', 'record', function(){
				var t = new Date().toISOString().substr(0,19);
				console.log(t+"Z");
			});
		});