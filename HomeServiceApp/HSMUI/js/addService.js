$(document).ready(function () {
    //Submit addition of a new type of service.
    $("#addService").click(function (e) {
        e.preventDefault();
		var serviceName = $("#serviceName").val().trim();
		var serviceDesc = $("#serviceDesc").val().trim();
		var serviceStatus = $("input:radio[name=serviceStatus]:checked").val();
		
		if (serviceName != '' && serviceName.includes(",")) {
		    serviceName = serviceName.replace(",", "");
		}
		if (serviceName == '') {
			$("#serviceName").css("border","2px solid red");
			$("#serviceName").css("box-shadow","0 0 3px red");
		}
		if (serviceDesc == '') {
			$("#serviceDesc").css("border","2px solid red");
			$("#serviceDesc").css("box-shadow","0 0 3px red");
		} 
		if (serviceName != '' && serviceDesc != '' && serviceStatus!='') {

		    var postData = "serviceName=" + serviceName + "&serviceDesc=" + serviceDesc + "&serviceStatus=" + serviceStatus;
		    
			$.ajax({
				type: "POST",
				url: "/api/service/addservice",
				data: postData,
				success: function (result) {
				    
					if (result) {
					    location.reload();
					}
				},
				error: function (msg) { alert(msg); }
			}); 
		}
	});
});