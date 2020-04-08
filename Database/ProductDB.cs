using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Database
{
    public class ProductDB
    {
        public readonly SqlConnection Conn = null;
        public ProductDB()
        {
            this.Conn = new SqlConnection(ConfigurationManager.AppSettings["SQlConnectionString"].ToString());
        }

        public DataTable Products
        {
            get
            {
                string Query = string.Empty;
                DataTable dataTable = new DataTable();
                SqlDataAdapter sqlDataAdapter = null;

                try
                {
                    Query = "SELECT PRODUCTID,NAME,CATEGORY,MAINCATEGORY,SUPPLIERNAME,DESCRIPTION,QUANTITY,PRICE FROM PRACTICE.DBO.TBL_PRODUCT_DETAILS WITH(NOLOCK) ORDER BY PRODUCTID ASC";
                    SqlCommand sqlCommand = new SqlCommand(Query, Conn);
                    Conn.Open();

                    // create data adapter
                    sqlDataAdapter = new SqlDataAdapter(sqlCommand);

                    // this will query your database and return the result to your datatable
                    sqlDataAdapter.Fill(dataTable);
                }
                catch (Exception ex)
                {
                    dataTable = null;
                }
                finally
                {
                    Conn.Close();
                    sqlDataAdapter.Dispose();
                }

                return dataTable;
            }
        }
    }
}
