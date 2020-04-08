using Database;
using System;
using System.Data;
using System.Web.Services;

namespace TabulatorWithAspdotnet
{
    public partial class CustomerDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        [WebMethod]
        public static object LoadCustomers()
        {
            // Return response object
            object Resp = new { status = 0, data = string.Empty };
            try
            {
                CustomerDB customerDB = new CustomerDB();
                DataTable CustomerTable = customerDB.Customers;

                if (CustomerTable != null && CustomerTable.Rows.Count > 0)
                {
                    Resp = new
                    {
                        status = 1,
                        data = Newtonsoft.Json.JsonConvert.SerializeObject(CustomerTable)
                    };
                    return Resp;
                }
            }
            catch (Exception ex)
            {
                return null;
            }
            return null;
        }
    }
}