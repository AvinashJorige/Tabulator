using System;
using System.Data;
using System.Web.UI;
using Database;

namespace TabulatorWithAspdotnet
{
    public partial class _Default : Page
    {
        private Repository repository = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.repository = new Repository();
            }
        }

        /// <summary>
        /// This method will return the prepare html table body
        /// </summary>
        /// <returns>string html table body</returns>
        public string GetTableRow()
        {
            string result = string.Empty;
            string htmlTr = string.Empty;
            string htmlTd = string.Empty;

            DataTable dataTable = new DataTable();

            try
            {
                // Get the data from the database repository
                dataTable = this.repository.GetCustomers();
                if (dataTable != null && dataTable.Rows.Count > 0)
                {
                    foreach (DataRow row in dataTable.Rows)
                    {
                        foreach (var item in row.ItemArray)
                        {
                            // append the data to each cell of a row
                            htmlTd += "<td>" + item + "</td>";
                        }

                        // append the row data to table row
                        htmlTr += "<tr>" + htmlTd + "</tr>";

                        // clear for the next row cell data so that previous data will not append
                        htmlTd = string.Empty;
                    }
                }

                result = htmlTr;
            }
            catch (Exception)
            {
                result = string.Empty;
            }
            finally
            {
                dataTable = null;
            }
            return result;
        }

    }
}