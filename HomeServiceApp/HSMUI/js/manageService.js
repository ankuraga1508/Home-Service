$(document).ready(function () {
    var select = document.getElementById("serviceName");
    //Getting current service data from backend and populating the values on the page.
    $.ajax({
        type: "GET",
        url: "api/service/services",
        dataType: "json",
        success: function (data) {
            var jsonData = JSON.parse(data);
            
            $.each(jsonData, function (i, obj) {
                var divData = "<option value=" + obj.id + ">" + obj.serviceName + "</option>";
                $(divData).appendTo('#serviceName');
            });
            var selValue = select.options[select.selectedIndex].value;
            $.each(jsonData, function (i, obj) {
                if (obj.id == selValue) {
                    $('#svcId').val(obj.id);
                    $('#serviceNameTxt').val(obj.serviceName);
                    $('#serviceDesc').val(obj.serviceDesc);
                    if (obj.serviceStatus==1) {
                        $('input:radio[name=serviceStatus]')[0].checked = true;
                    } else if (obj.serviceStatus == 0) {
                        $('input:radio[name=serviceStatus]')[1].checked = true;
                    }
                }
            });

            select.addEventListener('change', function () {
                var selValue = select.options[select.selectedIndex].value;
                $.each(jsonData, function (i, obj) {
                    if (obj.id == selValue) {
                        $('#svcId').val(obj.id);
                        $('#serviceNameTxt').val(obj.serviceName);
                        $('#serviceDesc').val(obj.serviceDesc);
                        if (obj.serviceStatus == 1) {
                            $('input:radio[name=serviceStatus]')[0].checked = true;
                        } else if (obj.serviceStatus == 0) {
                            $('input:radio[name=serviceStatus]')[1].checked = true;
                        }
                    }
                });
            })
        }
    });

    //Sending updated data to backend.
    $("#manageService").click(function (e) {
        var serviceId = $('#svcId').val();
        var serviceNameTxt = $("#serviceNameTxt").val().trim();
        var serviceDesc = $("#serviceDesc").val().trim();
        var serviceStatus = $("input:radio[name=serviceStatus]:checked").val();

        if (serviceNameTxt == '') {
            $("#serviceName").css("border", "2px solid red");
            $("#serviceName").css("box-shadow", "0 0 3px red");
        }
        if (serviceDesc == '') {
            $("#serviceDesc").css("border", "2px solid red");
            $("#serviceDesc").css("box-shadow", "0 0 3px red");
        }
        if (serviceNameTxt != '' && serviceDesc != '' && serviceStatus != '') {
            var postData = "id=" + serviceId + "&serviceName=" + serviceNameTxt + "&serviceDesc=" + serviceDesc + "&serviceStatus=" + serviceStatus;
            
            $.ajax({
                type: "POST",
                url: "/api/service/addservice",
                data: postData,
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                success: function (result) {
                    if (result) {
                    }
                },
                error: function (msg) { alert(msg); }
            });
        }
    });
});