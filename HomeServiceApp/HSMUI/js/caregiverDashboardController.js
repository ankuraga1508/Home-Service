$(document).ready(function () {

})

$("#jsGrid").jsGrid({
    width: "100%",
    height: "75%",

    filtering: false,
    editing: false,
    sorting: true,
    paging: true,
    autoload: true,

    pageSize: 10,
    pageButtonCount: 5,

    deleteConfirm: "Do you really want to reject this request?",

    fields: [
        { name: "Service", type: "text", width: 70 },
        { name: "Date", type: "text", width: 70 },
        { name: "From", type: "text", width: 50 },
        { name: "To", type: "text", width: 50 },
        { name: "Location", type: "text", width: 120 },
        { type: "control", editButton: false }
    ]
});