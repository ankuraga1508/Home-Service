//Get the currenly rejected requests for the given senior.
$(document).ready(function () {
    var requesterid = sessionStorage.getItem("idUser");
    $.ajax({
        type: "GET",
        url: "api/request/getrequestbyfilters?status=6&requesterid="+requesterid,
        dataType: "json",
        success: function (data) {
            var jsonData = JSON.parse(data);
            for (var i = 0; i < jsonData.length; i++) {
                var obj = jsonData[i];
                var tableData = '<tr><td class="tg-yxcv">' + obj.serviceName + '</td><td class="tg-yxcv">' + obj.ScheduleDate + '</td><td class="tg-yxcv">' + obj.StartTime + '</td><td class="tg-yxcv">' + obj.EndTime + '</td></tr>';
                $(tableData).appendTo('#activeReqTable');
            }
            
        }
    });
});