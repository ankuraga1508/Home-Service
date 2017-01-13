$(document).ready(function () {
    //Submit a request to login.
    $("#userLogin").click(function (e) {
        e.preventDefault();
		var username = $("#username").val().trim();
		var password = $("#password").val().trim();
		
		if ( username == '') {
			$('input[type="text"]').css("border","2px solid red");
			$('input[type="text"]').css("box-shadow","0 0 3px red");
		}
		if (password == '') {
			$('input[type="password"]').css("border","2px solid red");
			$('input[type="password"]').css("box-shadow","0 0 3px red");
		} 
		if (username != '' && password != '') {
		    var postData = "username="+ username + "&LoginPassword="+ password;
			$.ajax({
				type: "POST",
				url: "/api/user/userlogin",
				data: postData,
				success: function (result) {
				    if (result != 'null') {
				        var r = jQuery.parseJSON(result);
				        var UserRoleId = r.UserRoleId;
				        var idUser = r.idUser;
				        var Address = r.Address;
				        sessionStorage.setItem("idUser", idUser);
				        sessionStorage.setItem("Address", Address);
				        sessionStorage.setItem("UserRoleId", UserRoleId);
				        if (UserRoleId === 1) {
				            window.location = "SeniorDashboard.aspx";
				        } else if (UserRoleId === 2) {
				            window.location = "CaregiverDashboard.aspx";
				        } else if (UserRoleId === 3) {
				            window.location = "AdminDashboard.aspx";
				        };
					} else {
						$('input[type="text"]').css("border","2px solid red");
						$('input[type="text"]').css("box-shadow","0 0 3px red");
						$('input[type="password"]').css("border","2px solid red");
						$('input[type="password"]').css("box-shadow","0 0 3px red");
					}
				},
				error: function (msg) {  }
			}); 
		}
	});
	
    //Prompt registration.
    $("#userReg").click(function (e) {
        e.preventDefault();
		window.location = "Registration.aspx";
	});
});