<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CustomerDetails.aspx.cs" Inherits="TabulatorWithAspdotnet.CustomerDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-12 text-center">
            <br />
            <h4>Selecting Tables Rows with Checkboxes</h4>
            <br />
        </div>
    </div>
    <div class="row">
        <div class="col-8">
            <span class="text-success font-weight-bold mb-10">Selected row(s) : <span id="select-stats" class="pull-left"></span></span>
            <div id="CustomerGrid"></div>
        </div>
        <div class="col-4">
            <div class="ContainerGrid">
                <ul class="list-group">
                </ul>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            var CustomerData = LoadData("CustomerDetails.aspx/LoadCustomers");
        })

        // Load the Customer grid Data from the server
        function LoadData(url) {
            try {
                var ajaxObj = $.ajax({
                    type: "POST",
                    url: url,
                    data: null,
                    dataType: "JSON",
                    contentType: "application/json; charset=utf-8",
                    async: false,
                    cache: false,
                    success: function (res) {
                        //  This will check if is any null or undefined data is there or not and also check the status of the request.
                        if (res && res.d.status == 1 && res.d.data) {

                            // Parsing the string data into Array of object
                            var CustGridData = JSON.parse(res.d.data);
                            ProcessTableStructure(CustGridData);
                        }
                    },
                    error: function (err, type, httpStatus) {
                        alert("Error! Please try later.");
                    }
                });
            } catch (e) {
                console.log("Page :CustomerDetails.aspx | Function:LoadData | Error:" + e);
            }
        }

        // Process the customer grid data into multi-select row table
        function ProcessTableStructure(gridData) {
            try {
                var table = new Tabulator("#CustomerGrid", {
                    height: "70vh",
                    layout: "fitDataStretch",
                    pagination: "local",
                    paginationSize: 10,
                    paginationSizeSelector: [10, 20, 30, 50, 100],
                    data: gridData,
                    columns: [
                        {
                            formatter: "rowSelection", titleFormatter: "rowSelection", hozAlign: "center", headerSort: false, cellClick: function (e, cell) {
                                cell.getRow().toggleSelect();
                            }
                        },
                        { title: "Id", field: "CUSTOMERID", width: 50 },
                        { title: "Customer Name", field: "CUSTOMERNAME", width: 150 },
                        { title: "Contact Person", field: "CONTACTNAME", width: 150 },
                        { title: "Address", field: "ADDRESS", width: 200 },
                        { title: "City", field: "CITY", width: 100 },
                        { title: "Postal Code", field: "POSTALCODE", width: 100 },
                        { title: "Country", field: "COUNTRY", width: 150 }
                    ],
                    rowSelectionChanged: function (data, rows) {
                        //update selected row counter on selection change
                        document.getElementById("select-stats").innerHTML = data.length;
                        DisplaySelectedJSON(data);
                    },
                });
            } catch (e) {
                console.log("Page :CustomerDetails.aspx | Function:ProcessTableStructure | Error:" + e);
            }
        }

        function DisplaySelectedJSON(JsonData) {
            try {
                $('.ContainerGrid ul.list-group').html("");
                if (JsonData.length > 0) {
                    for (i = 0; i <= JsonData.length-1; i++) {
                        $('.ContainerGrid ul.list-group').append('<li class="list-group-item bg-success">' + JSON.stringify(JsonData[i]) + '</li>');
                    }
                }
            } catch (e) {
                console.log("Page :CustomerDetails.aspx | Function:DisplaySelectedJSON | Error:" + e);
            }
        }
    </script>
</asp:Content>
