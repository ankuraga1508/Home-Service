<%@ Page Language="C#" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <script src="js/signinCheck.js"></script>
    <script>
        if (redirectHandler(sessionStorage && sessionStorage.getItem('idUser') && sessionStorage.getItem('UserRoleId') == 2, 'Default.aspx'));
    </script>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="Dashboard for caregiver">
    <meta name="author" content="ArjunB, IanP, Ankur">

    <title>Caregiver Dashboard</title>

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
                <a class="navbar-brand" href="CaregiverDashboard.aspx">Home Service Manager</a>
            </div>
            <div id="navbar" class="navbar-collapse collapse">
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="javascript:void(0);" onclick="logout();">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div id="jsGrid" name="jsGrid" class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 " style="margin-top: 50px"></div>
    <div id="assignedRequests">
        <form id="detailsForm">
            <div class="details-form-field">
                <input type="hidden" id="ServiceRequestId" />
                <input type="hidden" id="ServiceId" />
                <label for="reqName">Requester Name:</label>
                <input id="reqName" name="reqName" type="text" disabled />
                <input type="hidden" id="reqId" />
            </div>
            <div class="details-form-field">
                <label for="reqLocation">Location:</label>
                <input id="reqLocation" name="reqLocation" type="text" disabled />
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

            <div class="col-sm-offset-4">
                <button type="submit" id="accept">Accept</button>
                <button type="submit" id="complete">Complete</button>
            </div>
        </form>
    </div>

    <script>
        $(function () {
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
                deleteConfirm: "Do you really want to decline this request?",
                noDataContent: "No assigned service requests at the moment",
                loadMessage: "Fetching Assigned Requests...",
                loadShading: true,
                controller: {
                    loadData: function (filter) {
                        var caregiverid = window.sessionStorage.getItem("idUser");
                        var reqData = $.Deferred();
                        $.ajax({
                            type: "GET",
                            dataType: "json",
                            url: "/api/request/getrequestbyfilters?caregiverid=" + caregiverid + "&Status=2",
                        }).done(function (result) {

                            var resultJson = JSON.parse(result);

                            result = $.grep(resultJson, function (request) {
                                return (!filter.RequesterId || request.RequesterId.indexOf(filter.RequesterId) > -1)
                                    && (!filter.RequesterName || request.RequesterName.indexOf(filter.RequesterName) > -1)
                                    && (!filter.id || request.id.indexOf(filter.id) > -1)
                                    && (!filter.ServiceId || request.ServiceId.indexOf(filter.ServiceId) > -1)
                                    && (!filter.FirstName || request.FirstName.indexOf(filter.FirstName) > -1)
                                    && (!filter.serviceName || request.serviceName.indexOf(filter.serviceName) > -1)
                                    && (!filter.ScheduleDate || request.ScheduleDate.indexOf(filter.ScheduleDate) > -1)
                                    && (!filter.StartTime || request.StartTime.indexOf(filter.StartTime) > -1)
                                    && (!filter.EndTime || request.EndTime.indexOf(filter.EndTime) > -1)
                                    && (!filter.Address || request.Address.indexOf(filter.Address) > -1);
                            });
                            reqData.resolve(result);
                        })
                        return reqData.promise();
                    },

                    deleteItem: function (item) {
                        var postData = "id=" + item.id + "&RequesterId=" + item.RequesterId + "&RoleId=" + item.RoleId +
                            "&CaregiverId=" + item.CaregiverId + "&ServiceId=" + item.ServiceId + "&Status=4" + '&ScheduleDate=' + item.ScheduleDate +
				            "&StartTime=" + item.StartTime + "&EndTime=" + item.EndTime + "&Comments=" + item.Comments + "&ModifiedBy=" + item.CaregiverId;

                        return $.ajax({
                            type: "POST",
                            url: "/api/request/postrequest",
                            data: postData,
                            contentType: "application/x-www-form-urlencoded; charset=utf-8",
                        });
                    },
                },

                rowClick: function (args) {
                    showAssignedReq(args.item);
                },
                fields: [
                    { title: "Id", name: "id", type: "number", width: 3, align: "center" },
                    { title: "Service Id", name: "ServiceId", type: "number", width: 0, align: "center", css: "hide" },
					{ title: "Requester Id", name: "RequesterId", type: "number", width: 10, align: "center" },
					{ title: "Requester Name", name: "RequesterName", type: "text", width: 25, align: "center" },
					{ title: "Service Name", name: "serviceName", type: "text", width: 25, align: "center" },
					{ title: "Schedule Date", name: "ScheduleDate", type: "text", width: 20, align: "center" },
					{ title: "Start Time", name: "StartTime", type: "text", width: 15, align: "center" },
					{ title: "End Time", name: "EndTime", type: "text", width: 15, align: "center" },
					{ title: "Address", name: "Address", type: "text", width: 30, align: "center" },
					{ type: "control", width: 10, editButton: false, modeSwitchButton: false }
                ]
            });

            $("#assignedRequests").dialog({
                autoOpen: false,
                width: 450,
                close: function () {
                    $("#detailsForm").validate().resetForm();
                    $("#detailsForm").find(".error").removeClass("error");
                }
            });

            var showAssignedReq = function (request) {
                $("#reqId").val(request.RequesterId);
                $("#reqName").val(request.RequesterName);
                $("#reqLocation").val(request.Address);
                $("#reqDate").val(request.ScheduleDate);
                $("#reqTimeFrom").val(request.StartTime);
                $("#reqTimeTo").val(request.EndTime);
                $("#ServiceRequestId").val(request.id);
                $("#ServiceId").val(request.ServiceId);

                $("#assignedRequests").dialog("open");
            };

            var respondToRequest = function (request) {

                var postData = 'id=' + $("#ServiceRequestId").val() + '&RequesterId=' + $("#reqId").val() + '&RoleId=' + 2 +
'&CaregiverId=' + '1' + '&ServiceId=' + $("#ServiceId").val() + '&Status=' + '2' + '&ScheduleDate=' + $("#reqDate").val() +
'&StartTime=' + $("#reqTimeFrom").val() + '&EndTime=' + $("#reqTimeTo").val() + '&Comments=' + 'aabbcc' + '&ModifiedBy=' + 2;

                $.ajax({
                    type: "POST",
                    url: "/api/request/postrequest",
                    data: postData,
                    success: function (data) {
                        if (data != 'null') {
                            alert("Request accepted successfully");
                            $("#jsGrid").jsGrid("refresh");
                        } else {
                            alert("Could not accept request");
                        }
                    },
                    error: function () {
                        alert("Could not accept request");
                    }
                });

                $("#assignedRequests").dialog("close");
            };

            var closeRequest = function (request) {
                var postData = 'id=' + $("#ServiceRequestId").val() + '&RequesterId=' + $("#reqId").val() + '&RoleId=' + 2 +
'&CaregiverId=' + '1' + '&ServiceId=' + $("#ServiceId").val() + '&Status=' + '3' + '&ScheduleDate=' + $("#reqDate").val() +
'&StartTime=' + $("#reqTimeFrom").val() + '&EndTime=' + $("#reqTimeTo").val() + '&Comments=' + 'aabbcc' + '&ModifiedBy=' + 2;
                //alert(postData);
                $.ajax({
                    type: "POST",
                    url: "/api/request/postrequest",
                    data: postData,
                    success: function (data) {
                        alert("Request closed successfully");
                        $("#jsGrid").jsGrid("refresh");
                    },
                    error: function () {
                        alert("Could not close request");
                    }
                });

                $("#assignedRequests").dialog("close");
            };
            $('#accept').click(function (request) {
                respondToRequest(request);
            });
            $('#complete').click(function (request) {
                closeRequest(request);
            });
        });
    </script>
    <script>
        function logout() {
            if (sessionStorage && sessionStorage.getItem('name')) {
                sessionStorage.removeItem('UserId');
            }
            window.location = "Default.aspx";
        }
    </script>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="/js/caregiverDashboardController.js"></script>
    <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>
    <script src="/js/bootstrap.min.js"></script>
    <!-- Just to make our placeholder images work. Don't actually copy the next line! -->
    <script src="/assets/js/vendor/holder.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="/assets/js/ie10-viewport-bug-workaround.js"></script>
    <script src="js/logout.js"></script>
</body>
</html>
