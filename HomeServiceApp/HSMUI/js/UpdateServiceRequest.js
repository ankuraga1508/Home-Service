$(document).ready(function () {
  //Request an update to the time of a servie request.
  $("#request-time").click(function () {
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
      var startTime = startDate + " " + startHour + ":" + startMinutes;
      var endTime = endDate + " " + endHour + ":" + endMinutes;

      var postData = JSON.stringify({
        "startTime": startTime,
        "endTime": endTime,
        "comments": comments
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

  //Request the stop of a servie request.
  $("#request-stop").click(function () {
    $.ajax({
      type: "DELETE",
      url: "",
      success: function (result) {
        if (result.d) {
          alert('success');
        }
      },
      error: function (msg) { alert(msg); }
    });
  });

  //Request a comment request to a servie request.
  $("#request-other").click(function () {
    var comments = $("#comments").val().trim();
    if (comments == '') {
      $("#comments").css("border","2px solid red");
      $("#comments").css("box-shadow","0 0 3px red");
    }else{
      var postData = JSON.stringify({
        "comments": comments
      });
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
