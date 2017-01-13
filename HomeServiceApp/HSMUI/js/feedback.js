//This feature has not been implemented yet.
$(document).ready(function () {
    //Submit feedback from a senior about a service.
	$("#submitFeedback").click(function () {
		var serviceReceived = $("#serviceReceived").val().trim();
		var comments = $("#comments").val().trim();
		var howToImprove = $("#howToImprove").val().trim();
		var anonymous = $("input:radio[name=anonymous]:checked").val();

		if (serviceReceived == '') {
			$("#serviceReceived").css("border","2px solid red");
			$("#serviceReceived").css("box-shadow","0 0 3px red");
		}
		if (comments == '') {
			$("#comments").css("border","2px solid red");
			$("#comments").css("box-shadow","0 0 3px red");
		}
		if (submitFeedback != '' && comments != '') {
			var postData = JSON.stringify({
				"serviceReceived": serviceReceived,
				"comments": comments,
				"howToImprove": howToImprove,
				"anonymous": anonymous
			});
			alert(postData);
			$.ajax({
				type: "POST",
				url: "", //TODO add url
				data: postData,
				contentType: "application/json; charset=utf-8",
				success: function (result) {
					if (result.d) {
						alert('success');
					}
				},
				error: function (msg) { alert(msg); }
			});
		}
	});
});
