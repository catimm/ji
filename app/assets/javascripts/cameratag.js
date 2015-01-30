$(document).ready(function(){
		CameraTag.observe('jitest', 'record', function(){
			var t = new Date().toISOString().substr(0,19);
			console.log(t+"Z");
		});
		CameraTag.observe('jitest', "initialized", function(){
			myCamera = CameraTag.cameras['jitest'];
		});
		myCamera.addVideoData(js_object){
			camera:"jitest", 
			user:"12"
		});
});