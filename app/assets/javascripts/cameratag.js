$(document).ready(function(){
		CameraTag.observe('jitest', 'record', function(){
			var t = new Date().toISOString().substr(0,19);
			console.log(t+"Z");
		});
		CameraTag.observe('jitest', "initialized", function(){
			myCamera = CameraTag.cameras['jitest'];
			
			var js_object = {
			    camera: "jitest", 
			    user: "12"
			};
			myCamera.addVideoData(js_object);
		});
		
});