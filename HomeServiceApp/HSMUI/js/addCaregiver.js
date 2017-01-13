$(document).ready(function () {
    //Submit a new caregiver profile.
    $("#addCaregiver").click(function (e) {
        e.preventDefault();
        var firstName = $("#firstName").val().trim();
        var lastName = $("#lastName").val().trim();
        var username = $("#username").val().trim();
        var password = $("#password").val().trim();

        if (firstName == '') {
            $("#firstName").css("border", "2px solid red");
            $("#firstName").css("box-shadow", "0 0 3px red");
        }
        if (lastName == '') {
            $("#lastName").css("border", "2px solid red");
            $("#lastName").css("box-shadow", "0 0 3px red");
        }
        if (username == '') {
            $("#username").css("border", "2px solid red");
            $("#username").css("box-shadow", "0 0 3px red");
        }
        if (password == '') {
            $("#password").css("border", "2px solid red");
            $("#password").css("box-shadow", "0 0 3px red");
        }
        if (firstName != '' && lastName != '' && username != '' && password != '') {
            var UserId = window.sessionStorage.getItem('UserId');

            var postData = new Object();

            postData.UserName = username;
            postData.FirstName = firstName;
            postData.LastName = lastName;
            postData.LoginPassword = password;
            postData.IsActive = 1;//Active by default
            postData.CreatedBy = UserId;
            postData.ModifiedBy = UserId;
            postData.UserRoleId = 2;//Role id of caregiver
       
            $.ajax({
                type: "POST",
                url: "/api/user/postadduser",
                data: postData,
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
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

