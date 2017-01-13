$(document).ready(function () {
    //Get the list of available services and update the page.
	$.ajax({
		type: "GET",
		url: "api/service/services",
		dataType: "json",
		success: function (data) {
		    var jsonData = JSON.parse(data);
		    for (var i = 0; i < jsonData.length; i++) {
		        var obj = jsonData[i];
		        var class1 = "panel panel-primary col-sm-offset-1";
		        var style1 = "width:75%; margin-bottom:50px;";
		        var class2 = "panel-heading";
		        var class3 = "panel-title";
		        var style2 = "font-size:200%;";
		        var class4 = "panel-body";
		        var divData = '<div class=' + class1 + ' style=' + style1 + '><div class=' + class2
                    + '><h3 class=' + class3 + ' style=' + style2 + '>' + obj.serviceName
                    + '<button type="button" class="btn btn-success pull-right" data-toggle="modal" data-target="#schSrvModal" data-whatever="' + obj.serviceName + ',' + obj.id +'">Click Here to Schedule Service</button></h3></div><div class='
					+ class4 + '>' + obj.serviceDesc + '</div></div>';
		        
		        if (obj.serviceStatus && obj.serviceStatus == 1) {
		            $(divData).appendTo('#servicesDiv');
		        }
		    }
		}
	});
	
	$('#schSrvModal').on('show.bs.modal', function (event) {
	    var button = $(event.relatedTarget);
	    var whatever = button.data('whatever');
	    var arr = whatever.split(",");
	    var modal = $(this);
	    modal.find('.modal-title').text('New Request: ' + arr[0]);
	    modal.find('.modal-body input').val(arr[0]);
	    $(".modal-body #serviceId").val(arr[1]);
	})

    //Submit a request for a service.
	$('#submitSchedule').click(function () {
	    var serviceId = $("#serviceId").val().trim();
	    var serviceName = $("#serviceName").val().trim();
	    var reqDate = $("#reqDate").val().trim();
	    var reqTimeFrom = $("#reqTimeFrom").val().trim();
	    var reqTimeTo = $("#reqTimeTo").val().trim();
	    if (Date.parse('01/01/2011 ' + reqTimeFrom) > Date.parse('01/01/2011 ' + reqTimeTo)) {
	        alert("Service Start Time must be smaller than Service End Time");
	        $('input[type="time"]').css("border", "2px solid red");
	        return false;
	    }
	    
	    if (serviceId != '' && serviceName != '' && reqDate != '' && reqTimeFrom != '' && reqTimeTo != '') {
	        var postData = 'RequesterId=' + sessionStorage.getItem('idUser') + '&RoleId=' + sessionStorage.getItem('UserRoleId') + '&CaregiverId=' + '0' + '&ServiceId=' + serviceId + '&Status=' + '1' + '&ScheduleDate=' + reqDate + '&StartTime=' + reqTimeFrom + '&EndTime=' + reqTimeTo + '&Comments=' + '' + '&ModifiedBy=' + sessionStorage.getItem('idUser');
            
	        $.ajax({
	            type: "POST",
	            url: "/api/request/postrequest",
	            data: postData,
	            success: function (result) {
	            },
	            error: function (msg) {
	            }
	        });
	    }
	});
});