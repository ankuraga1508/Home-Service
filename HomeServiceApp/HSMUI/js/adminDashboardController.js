(function() {
  
    var adminDashboardController = {
        
        loadData: function (filter) {
            var reqData = $.Deferred();
            $.ajax({
                type: "GET",
                dataType: "json",
                url: "api/request/getrequestbyfilters?status=1,4",
            }).done(function (result) {
                var resultJson = JSON.parse(result);
                result = $.grep(resultJson, function (request) {
                    return (!filter.Status || request.Status === filter.Status)
					&& (!filter.id || request.id.indexOf(filter.id) > -1)
					&& (!filter.RequesterId || request.RequesterId.indexOf(filter.RequesterId) > -1)
                    && (!filter.RequesterName || request.RequesterName.indexOf(filter.RequesterName) > -1)
					&& (!filter.serviceName || request.serviceName.indexOf(filter.serviceName) > -1)
                    && (!filter.ServiceId || request.ServiceId.indexOf(filter.ServiceId) > -1)
					&& (!filter.ScheduleDate || request.ScheduleDate.indexOf(filter.ScheduleDate) > -1)
					&& (!filter.StartTime || request.StartTime.indexOf(filter.StartTime) > -1)
					&& (!filter.EndTime || request.EndTime.indexOf(filter.EndTime) > -1)
					&& (!filter.Address || request.Address.indexOf(filter.Address) > -1);
                });

                reqData.resolve(result);
            })
            return reqData.promise();
        },

        deleteItem: function(deletingReq) {
            $('#reqestId').val(deletingReq.id);
            $("#reqesterName").val(deletingReq.RequesterName);
            $("#reqesterId").val(deletingReq.RequesterId);
            $("#reqLocation").val(deletingReq.Address);
            $("#reqDate").val(deletingReq.ScheduleDate);
            $("#reqTimeFrom").val(deletingReq.StartTime);
            $("#reqTimeTo").val(deletingReq.EndTime);
            $('#serviceId').val(deletingReq.ServiceId);

            var postData = 'id=' + $('#reqestId').val() + '&RequesterId=' + $("#reqesterId").val() + '&RoleId=' + sessionStorage.getItem('UserRoleId') + '&CaregiverId=' + $("#availableCG").val() + '&ServiceId=' + $('#serviceId').val() + '&Status=' + '6' + '&ScheduleDate=' + $("#reqDate").val() + '&StartTime=' + $("#reqTimeFrom").val() + '&EndTime=' + $("#reqTimeTo").val() + '&Comments=' + '' + '&ModifiedBy=' + sessionStorage.getItem('idUser');
            $.ajax({
                type: "POST",
                url: "/api/request/postrequest",
                data: postData,
                success: function (data) {
                    $("#jsGrid").jsGrid("refresh");
                },
                error: function () {
                    alert("Could not assign request");
                }
            });


        }

    };

    window.adminDashboardController = adminDashboardController;

    adminDashboardController.status = [
		{ Name: "Requested", Value: "1" },
		{ Name: "Declined", Value: "4" }
    ];
	
}());