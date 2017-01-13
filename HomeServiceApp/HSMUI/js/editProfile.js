$(document).ready(function () {
  //Upadate the profile of a senior.
  $("#update").click(function () {
    var firstName = $("#firstName").val().trim();
    var lastName = $("#lastName").val().trim();
    var username = $("#username").val().trim();
    var password = $("#password").val().trim();
    var contactNum = $("#contactNum").val().trim();
    var altContactNum = $("#altContactNum").val().trim();
    var addressLine1 = $("#addressLine1").val().trim();
    var addressLine2 = $("#addressLine2").val().trim();
    var city = $("#city").val().trim();
    var state = $("#state").val().trim();
    var zipCode = $("#zipCode").val().trim();
    var sex = $("#sex").val().trim();
    var dateOfBirth = $("#dateOfBirth").val().trim();

    function Field(value, id) {
      this.value = value;
      this.id = id;
    }

    var required = [];
    required.push(new Field(firstName, "firstName"));
    required.push(new Field(lastName, "lastName"));
    required.push(new Field(username, "username"));
    required.push(new Field(password, "password"));
    required.push(new Field(contactNum, "contactNum"));
    required.push(new Field(addressLine1, "addressLine1"));
    required.push(new Field(city, "city"));
    required.push(new Field(state, "state"));
    required.push(new Field(zipCode, "zipCode"));
    required.push(new Field(sex, "sex"));
    required.push(new Field(dateOfBirth, "dateOfBirth"));

    var completeForm = 1;

    for (field of required) {
      if (field.value === '') {
        $("#" + field.id).css("border","2px solid red");
        $("#" + field.id).css("box-shadow","0 0 3px red");
        completeForm = 0;
      }
    }

    if(completeForm === 1) {
      var postData = JSON.stringify({
        "firstName": firstName,
        "lastName": lastName,
        "username": username,
        "password": password,
        "contactNum": contactNum,
        "altContactNum": altContactNum,
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "city": city,
        "state": state,
        "zipCode": zipCode,
        "sex": sex,
        "dateOfBirth": dateOfBirth
      });
      alert(postData);
			$.ajax({
				type: "POST",
				url: "",
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
