$(document).ready(function () {
    //Submit a new service request.
    $("#request").click(function (e) {
    e.preventDefault();
    var startDate = $("#startDate").val().trim();
    var endDate = $("#endDate").val().trim();
    var comments = $("#comments").val().trim();

    if (startDate == '') {
      $("#startDate").css("border","2px solid red");
      $("#startDate").css("box-shadow","0 0 3px red");
    }
    if (endDate == '') {
      $("#endDate").css("border","2px solid red");
      $("#endDate").css("box-shadow","0 0 3px red");
    }
    if(startDate != '' && endDate != '') {
      var startHour = parseInt($("#startHour").find(":selected").val());
      var startMinutes = $("#startMinutes").find(":selected").val();
      var startAMPM = $("#startAMPM").find(":selected").val();
      var endHour = parseInt($("#endHour").find(":selected").val());
      var endMinutes = $("#endMinutes").find(":selected").val();
      var endAMPM = $("#endAMPM").find(":selected").val();

      if(startAMPM === "PM") {
        startHour = 12 + startHour +"";
      }
      if(endAMPM === "PM") {
        endHour = 12 + endHour + "";
      }

      startHour = minTwoDigits(startHour);
      endHour = minTwoDigits(endHour);

      var startTime = startDate + " " + startHour + ":" + startMinutes + ":00";
      var endTime = endDate + " " + endHour + ":" + endMinutes + ":00";
      var ServiceId = 0;
      var UserId = window.sessionStorage.getItem("UserId");
      var currentDate = new Date();
      var ModifiedOn = currentDate.getFullYear() + "-" + minTwoDigits(currentDate.getMonth()) + "-" + minTwoDigits(currentDate.getDay()) + " " +
          minTwoDigits(currentDate.getHours()) + ":" + minTwoDigits(currentDate.getMinutes()) + ":" + minTwoDigits(currentDate.getSeconds());

      var postData = "RequesterId=" + UserId + "&RoleId= 1" + "&CaregiverId=" + "" +
          "&ServiceId=" + ServiceId + "&Status=1" + "&TimeOfServiceStart=" + startTime + "&TimeOfSericeEnd=" + endTime +
          "&Comments=" + comments + "&ModifiedBy=" + UserId + "&ModifiedOn=" + ModifiedOn;

      $.ajax({
        type: "POST",
        url: "/api/request/postrequest",
        data: postData,
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
		success: function (result) {
					if (result) {
						alert('success');
					}
					window.location = "SeniorDashboard.aspx";
				},
		error: function (msg) { alert(msg); }
      });
    }
    });

    //Cancel the request.
    $("#request-cancel").click(function () {
        window.location = "SeniorDashboard.aspx";
    });
});

//Convert a one digit number to a string with a leading 0.
function minTwoDigits(n) {
    if (n < 10 && n > -10) {
        return "0" + n;
    } else {
        return n;
    }
};
