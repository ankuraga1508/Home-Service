$(document).ready(function () {

    var select = document.getElementById("username");
    //Getting data from backend
    $.ajax({
        type: "GET",
        url: "api/user/getalluser?roleId=2",
        dataType: "json",
        success: function (data) {
            var jsonData = JSON.parse(data);
            cgNames = jsonData;
            $('#username').find('option').remove().end();
            $.each(jsonData, function (i, obj) {
                var divData = "<option value=" + obj.idUser + ">" + obj.FirstName + " " + obj.LastName + " (" + obj.UserName + ")</option>";
                $(divData).appendTo('#username');
            });
            var selValue = select.options[select.selectedIndex].value;
            $.each(jsonData, function (i, obj) {
                if (obj.idUser == selValue) {
                    $('#idUser').val(obj.id);
                    $('#UserName').val(obj.UserName);
                    $('#firstName').val(obj.FirstName);
                    $('#lastName').val(obj.LastName);
                    $('#password').val(obj.LoginPassword);
                    $('#UserName').val(obj.UserName);
                    $('#UserEmail').val(obj.UserEmail);
                    $('#UserMobile').val(obj.UserMobile);
                    $('#UserSSN').val(obj.UserSSN);
                    $('#CreatedBy').val(obj.CreatedBy);
                    $('#CreatedOn').val(obj.CreatedOn);
                    $('#LoginId').val(obj.LoginId);
                    $('#IsActive').val(obj.IsActive);
                    $('#Address').val(obj.Address);
                    $('#Sex').val(obj.Sex);
                }
            });

            select.addEventListener('change', function () {
                var selValue = select.options[select.selectedIndex].value;
                $.each(jsonData, function (i, obj) {
                    if (obj.idUser == selValue) {
                        $('#idUser').val(obj.id);
                        $('#UserName').val(obj.UserName);
                        $('#firstName').val(obj.FirstName);
                        $('#lastName').val(obj.LastName);
                        $('#password').val(obj.LoginPassword);
                        $('#UserName').val(obj.UserName);
                        $('#UserEmail').val(obj.UserEmail);
                        $('#UserMobile').val(obj.UserMobile);
                        $('#UserSSN').val(obj.UserSSN);
                        $('#CreatedBy').val(obj.CreatedBy);
                        $('#CreatedOn').val(obj.CreatedOn);
                        $('#LoginId').val(obj.LoginId);
                        $('#IsActive').val(obj.IsActive);
                        $('#Address').val(obj.Address);
                        $('#Sex').val(obj.Sex);
                    }
                });
            })
        }
    });



    $("#updateCaregiver").click(function () {

        var idUser = select.options[select.selectedIndex].value;
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

            var postData = "idUser=" + idUser + "&LoginId=" + $('#LoginId').val() + "&UserEmail=" + $('#UserEmail').val() + "&UserName=" + $('#UserName').val()
                + "&UserMobile=" + $('#UserMobile').val() + "&UserRoleId=2" + "&UserSSN=" + $('#UserSSN').val() + "&CreatedOn=" + $('#CreatedOn').val()
                + "&CreatedBy=" + $('#CreatedBy').val() + "&ModifiedBy=" + sessionStorage.getItem('idUser') + "&IsActive=" + $('#IsActive').val() + "&Address=" + $('#Address').val()
                + "&FirstName=" + firstName + "&LastName=" + lastName + "&Sex=" + $('#Sex').val() + "&LoginPassword=" + password;
            
            $.ajax({
                type: "POST",
                url: "/api/user/postadduser",
                data: postData,
                success: function (result) {
                },
                error: function (msg) { }
            });
        }
    });
});
