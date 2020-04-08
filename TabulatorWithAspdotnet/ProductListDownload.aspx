<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductListDownload.aspx.cs" Inherits="TabulatorWithAspdotnet.ProductListDownload" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-12 text-center mtb-10">
            <h3 class="text-underline">Product List(Downloading data into xlsx, json, csv, pdf, html)</h3>
        </div>
    </div>
    <div class="row">
        <div class="col-12">
            <div class="btn-group btn-group-md mb2-10 float-right">
                <button type="button" id="download-csv" class="btn btn-primary">Download CSV</button>
                <button type="button" id="download-json" class="btn btn-success">Download JSON</button>
                <button type="button" id="download-xlsx" class="btn btn-info">Download XLSX</button>
                <button type="button" id="download-pdf" class="btn btn-warning">Download PDF</button>
                <button type="button" id="download-html" class="btn btn-dark">Download HTML</button>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-12">
            <div id="GridExample"></div>
        </div>
    </div>
    <script type="text/javascript" src="https://oss.sheetjs.com/sheetjs/xlsx.full.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.5/jspdf.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.0.5/jspdf.plugin.autotable.js"></script>
    <script type="text/javascript">
        var table = "";
        $(document).ready(function () {

            var ProductData = LoadData("ProductListDownload.aspx/LoadProductList");

            //trigger download of data.csv file
            document.getElementById("download-csv").addEventListener("click", function () {
                table.download("csv", "data.csv");
            });

            //trigger download of data.json file
            document.getElementById("download-json").addEventListener("click", function () {
                table.download("json", "data.json");
            });

            //trigger download of data.xlsx file
            document.getElementById("download-xlsx").addEventListener("click", function () {
                table.download("xlsx", "data.xlsx", { sheetName: "My Data" });
            });

            //trigger download of data.pdf file
            document.getElementById("download-pdf").addEventListener("click", function () {
                table.download("pdf", "data.pdf", {
                    orientation: "portrait", //set page orientation to portrait
                    title: "Example Report", //add title to report
                });
            });

            //trigger download of data.html file
            document.getElementById("download-html").addEventListener("click", function () {
                table.download("html", "data.html", { style: true });
            });
        })

        // Load the Product grid Data from the server
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
                            var ProdtGridData = JSON.parse(res.d.data);
                            ProcessTableStructure(ProdtGridData);
                        }
                    },
                    error: function (err, type, httpStatus) {
                        alert("Error! Please try later.");
                    }
                });
            } catch (e) {
                console.log("Page :ProductListDownload.aspx | Function:LoadData | Error:" + e);
            }
        }

        // Process the customer grid data into multi-select row table
        function ProcessTableStructure(gridData) {
            try {
                table = new Tabulator("#GridExample", {
                    height: "50vh",
                    layout: "fitDataStretch",
                    pagination: "local",
                    paginationSize: 10,
                    paginationSizeSelector: [10, 20, 30, 50, 100],
                    data: gridData,
                    columns: [
                        { title: "Product Id", field: "PRODUCTID", width: 110 },
                        { title: "Name", field: "NAME", width: 160 },
                        { title: "Category", field: "CATEGORY", width: 150 },
                        { title: "Main Category", field: "MAINCATEGORY", width: 150 },
                        { title: "Supplier Name", field: "SUPPLIERNAME", width: 150 },
                        { title: "Description", field: "DESCRIPTION", width: 450 },
                        { title: "Quantity", field: "QUANTITY", width: 100 },
                        {
                            title: "Price", field: "PRICE", width: 80, formatter: "money", formatterParams: {
                                decimal: ".",
                                thousand: ",",
                                symbol: "₹",
                                symbolBefore: "p",
                                precision: false,
                            }
                        },
                    ]
                });
            } catch (e) {
                console.log("Page :CustomerDetails.aspx | Function:ProcessTableStructure | Error:" + e);
            }
        }
    </script>
</asp:Content>
