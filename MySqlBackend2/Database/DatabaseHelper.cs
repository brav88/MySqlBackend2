using MySql.Data.MySqlClient;
using System.Data;

namespace MySqlBackend2.Database
{
	public class DatabaseHelper
	{
		const string database = "mydatabase";
		const string server = "localhost";
		MySqlConnection connection = new MySqlConnection($"server={server};database={database};uid=root;pwd=Admin$1234");

		public void TestConnection()
		{
			connection.Open();
			connection.Close();
		}

		public DataTable Fill(string storedProcedure, List<MySqlParameter>? param)
		{
			try
			{
				using (this.connection)
				{
					connection.Open();
					MySqlCommand cmd = connection.CreateCommand();
					cmd.CommandType = CommandType.StoredProcedure;
					cmd.CommandText = storedProcedure;

					if (param != null)
					{
						foreach (MySqlParameter p in param)
						{
							cmd.Parameters.Add(p);
						}
					}

					DataTable ds = new DataTable();
					MySqlDataAdapter adapter = new MySqlDataAdapter(cmd);
					adapter.Fill(ds);
					return ds;
				}
			}
			catch
			{
				throw;
			}
		}

		public void ExecuteQuery(string storedProcedure, List<MySqlParameter> param)
		{
			try
			{
				using (this.connection)
				{
					connection.Open();
					MySqlCommand cmd = connection.CreateCommand();
					cmd.CommandType = CommandType.StoredProcedure;
					cmd.CommandText = storedProcedure;

					if (param != null)
					{
						foreach (MySqlParameter p in param)
						{
							cmd.Parameters.Add(p);
						}
					}

					cmd.ExecuteNonQuery();
				}
			}
			catch
			{
				throw;
			}
		}
	}
}

