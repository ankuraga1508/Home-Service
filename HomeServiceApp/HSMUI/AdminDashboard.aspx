    <%@ Page Language="C#"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <script src="js/signinCheck.js"></script>
    <script>
        if (redirectHandler(sessionStorage && sessionStorage.getItem('idUser') && sessionStorage.getItem('UserRoleId') == 3, 'Default.aspx'));
    </script>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="Dashboard for administrator">
	<meta name="author" content="ArjunB">

	<title>Admin Dashboard</title>

	<link rel="icon" href="images/favicon.jpg">
	<link href='http://fonts.googleapis.com/css?family=Open+Sans:300,600,400' rel='stylesheet' type='text/css'>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link type="text/css" rel="stylesheet" href="css/jsgrid.min.css" />
	<link type="text/css" rel="stylesheet" href="css/jsgrid-theme.min.css" />
	<link type="text/css" href="css/adminStyle.css" rel="stylesheet">
	<link type="text/css" href="css/showRequests.css" rel="stylesheet">
    <link type="text/css" href="css/assignRequest.css" rel="stylesheet" />
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.11.2/themes/cupertino/jquery-ui.css">
    
    <script src="js/jquery-2.0.0.min.js"></script>
    <script src="http://code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js"></script>
	<script src="js/jsgrid.core.js"></script>
	<script src="js/jsgrid.load-indicator.js"></script>
	<script src="js/jsgrid.load-strategies.js"></script>
	<script src="js/jsgrid.sort-strategies.js"></script>
	<script src="js/jsgrid.field.js"></script>
	<script src="js/jsgrid.field.text.js"></script>
	<script src="js/jsgrid.field.number.js"></script>
	<script src="js/jsgrid.field.select.js"></script>
	<script src="js/jsgrid.field.checkbox.js"></script>
	<script src="js/jsgrid.field.control.js"></script>
	<script src="js/adminDashboardController.js"></script>
    <script src="js/logout.js"></script>
</head>

<body>
    <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="AdminDashboard.aspx">Home Service Manager</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <li><a href="#">Dashboard</a></li>
            <li><a href="javascript:void(0);" onclick="logout();">Logout</a></li>
          </ul>
        </div>
      </div>
    </nav>
	
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-3 col-md-2 sidebar" id="sidebar">
				<ul class="nav nav-sidebar">
					<li class="active"><a href="#">Active Requests <span class="sr-only">(current)</span></a></li>
					<li><a href="AdminCompletedRequests.aspx">Completed Requests</a></li>
					<li><a href="AdminRejectedRequests.aspx">Rejected Requests</a></li>
				</ul>
				<ul class="nav nav-sidebar">
					<li><a href="AddService.aspx">Add Service</a></li>
					<li><a href="ManageService.aspx">Manage Service</a></li>
				</ul>
				<ul class="nav nav-sidebar">
					<li><a href="AddCaregiver.aspx">Add Caregiver</a></li>
					<li><a href="ManageCaregiver.aspx">Manage Caregiver</a></li>
				</ul>
			</div>
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<h1 class="page-header" >Active Requests</h1>
			</div>
		</div>
	</div>
	
	<div id="jsGrid" name="jsGrid" class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 "></div>
    <div id="assignRequest">
        <form id="detailsForm">
            <div class="details-form-field">
                <label for="reqesterName">Requester Name:</label>
                <input id="reqesterName" name="reqesterName" type="text" disabled/>
            </div>
            <div id="hidden-fields">
                <input id="reqestId" name="reqestId" type="hidden"/>
                <input id="reqesterId" name="reqesterId" type="hidden"/>
                <input id="serviceId" name="serviceId" type="hidden"/>
                <input id="cgName" name="cgName" type="hidden"/>
            </div>
            <div class="details-form-field">
                <label for="reqLocation">Location:</label>
                <input id="reqLocation" name="reqLocation" type="text" disabled/>
            </div>
            <div class="details-form-field">
                <label for="reqDate">Date:</label>
                <input id="reqDate" name="reqDate" type="text" disabled />
            </div>
            <div class="details-form-field">
                <label for="reqTimeFrom">From:</label>
                <input id="reqTimeFrom" name="reqTimeFrom" type="text" disabled />
            </div>
            <div class="details-form-field">
                <label for="reqTimeTo">To:</label>
                <input id="reqTimeTo" name="reqTimeTo" type="text" disabled />
            </div>
            <div class="details-form-field">
                <label for="availableCG">Assign To:</label>
                <select id="availableCG" name="availableCG"></select>
            </div>
            <!-- <div id="success-message"></div> -->
            <div class="details-form-field">
                <button type="submit" id="assign">Assign</button>
            </div>
        </form>
    </div>
	<script>
        
		$(function() {
			$("#jsGrid").jsGrid({
				width: "53%",
				height: "80%",
				filtering: true,
				editing: false,
				sorting: true,
				paging: true,
				autoload: true,
				pageSize: 10,
				pageButtonCount: 5,
				deleteConfirm: "Do you really want to reject this request?",
				noDataContent: "No service requests matching your criteria",
				loadMessage: "Fetching Active Requests...",
				loadShading: true,
				controller: adminDashboardController,
				colNames: ['Status', 'Request Id', 'Requester Id', 'Service', 'Request Date', 'Start Time', 'End Time', 'Location'],
				rowClick: function(args) {
				    showAvailableCG(args.item);
				},
				fields: [
					{ title:"Status", name: "Status", type: "select", width: 15, items: adminDashboardController.status, valueField: "Value", textField: "Name" },
					{ title:"Request Id", name: "id", type: "number", width: 5, align: "center" },
					{ title:"Requester Id", name: "RequesterId", type: "text", css: "hide", width: 0 },
                    { title:"Requester", name: "RequesterName", type: "text", width: 18, align: "center" },
					{ title:"Service", name: "serviceName", type: "text", width: 25, align: "center" },
                    { title:"Srv Id", name: "ServiceId", type: "text", css: "hide", width: 0 },
					{ title:"Date", name: "ScheduleDate", type: "text", width: 15, align: "center" },
					{ title:"From", name: "StartTime", type: "text", width: 15, align: "center" },
					{ title:"To", name: "EndTime", type: "text", width: 15, align: "center" },
					{ title:"Location", name: "Address", type: "text", width: 20, align: "center" },
					{ title:"", type: "control", width: 10, editButton: false, modeSwitchButton: false }
				]
			});

			$("#assignRequest").dialog({
			    autoOpen: false,
			    width: 450,
			    close: function () {
			        $("#detailsForm").validate().resetForm();
			        $("#detailsForm").find(".error").removeClass("error");
			    }
			});

			$("#detailsForm").validate({
			    rules: {
			        availableCG: "required"
			    },
			    messages: {
			        availableCG: "Please assign the request to an available caregiver"
			    },
			    submitHandler: function () {
			        formSubmitHandler();
			    }
			});

			var formSubmitHandler = $.noop;

			var showAvailableCG = function (request) {
			    $('#reqestId').val(request.id);
			    $("#reqesterName").val(request.RequesterName);
			    $("#reqesterId").val(request.RequesterId);
			    $("#reqLocation").val(request.Address);
			    $("#reqDate").val(request.ScheduleDate);
			    $("#reqTimeFrom").val(request.StartTime);
			    $("#reqTimeTo").val(request.EndTime);
			    $('#serviceId').val(request.ServiceId);

			    $.ajax({
			        type: "GET",
			        url: "api/user/getalluser?roleId=2",
			        dataType: "json",
			        success: function (data) {
			            var jsonData = JSON.parse(data);
			            $('#availableCG').find('option').remove().end();
			            $.each(jsonData, function (i, obj) {
			                var divData = "<option value=" + obj.idUser + ">" + obj.FirstName + " " + obj.LastName + " (" + obj.UserName + ")</option>";
			                $(divData).appendTo('#availableCG');
			                var fullName = obj.FirstName + " " + obj.LastName;
			                $('#cgName').val(fullName);
			            });
			        }
			    });

			    formSubmitHandler = function () {
			        assignToAvailableCG(request);
			    };

			    $("#assignRequest").dialog("open");
			};

			var assignToAvailableCG = function (request) {
			    var postData = 'id=' + request.id + '&RequesterId=' + $("#reqesterId").val() + '&RoleId=' + sessionStorage.getItem('UserRoleId') + '&CaregiverId=' + $("#availableCG").val() + '&ServiceId=' + $('#serviceId').val() + '&Status=' + '2' + '&ScheduleDate=' + $("#reqDate").val() + '&StartTime=' + $("#reqTimeFrom").val() + '&EndTime=' + $("#reqTimeTo").val() + '&Comments=' + '' + '&ModifiedBy=' + sessionStorage.getItem('idUser');
			    $.ajax({
                    type: "POST",
                    url: "/api/request/postrequest",
			        data: postData,
			        success: function (data) {
			            /*
			            if (data == "true") {
			                var divData = '<div class="alert alert-success"><strong>Success! </strong>Request assigned to '+ $('#cgName').val() +'</strong></div>';
			                $(divData).appendTo('#success-message');
			            }
                        */
			            $("#jsGrid").jsGrid("refresh");
			        },
			        error: function () {
			            alert("Could not assign request");
			        }
			    });

			    $("#assignRequest").dialog("close");
			};
		});
        
	</script>
    
</body>
</html>


