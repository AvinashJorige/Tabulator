<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TabulatorWithAspdotnet._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <h3>Tabulator with C# basic(Converting the HTML Table into Tabulator table</h3>
    <br />
    <div class="row">
        <div class="col-12 tabulator-example">
            <table class="table table-condensed table-striped table-hover table-sm tabulator_table">
                <thead>
                    <tr class="table-primary">
                        <th scope="col">#</th>
                        <th scope="col">Customer Name</th>
                        <th scope="col">Email</th>
                        <th scope="col">Company</th>
                        <th scope="col">Street</th>
                        <th scope="col">City</th>
                        <th scope="col">Region</th>
                        <th scope="col">Country</th>
                    </tr>
                </thead>
                <tbody>
                    <%= GetTableRow() %>
                </tbody>
            </table>
        </div>
    </div>

    <script type="text/javascript">
        $(document).ready(function () {
            var table = new Tabulator(".tabulator_table", {
                height: "70vh",
                layout:"fitDataStretch",
                pagination: "local",
                paginationSize: 10,
                paginationSizeSelector: [10, 20, 30, 50, 100]
            });
        });
    </script>
</asp:Content>
