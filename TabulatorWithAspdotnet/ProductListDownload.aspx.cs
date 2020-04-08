using Database;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TabulatorWithAspdotnet
{
    public partial class ProductListDownload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static object LoadProductList()
        {
            // Return response object
            object Resp = new { status = 0, data = string.Empty };
            try
            {
                ProductDB  productDB = new ProductDB();
                DataTable ProductTable = productDB.Products;

                if (ProductTable != null && ProductTable.Rows.Count > 0)
                {
                    Resp = new
                    {
                        status = 1,
                        data = Newtonsoft.Json.JsonConvert.SerializeObject(ProductTable)
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