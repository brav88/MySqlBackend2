using Microsoft.AspNetCore.Mvc;
using MySqlBackend2.Models;
using System.Data;
using System.Diagnostics;

namespace MySqlBackend2.Controllers
{
	public class HomeController : Controller
	{
		private readonly ILogger<HomeController> _logger;

		public HomeController(ILogger<HomeController> logger)
		{
			_logger = logger;
		}

		public IActionResult Index()
		{
			Database.DatabaseHelper db = new Database.DatabaseHelper();
			List<Orders> orderList = new List<Orders>();

			DataTable ds = db.Fill("GetAllOrders", null);

			foreach (DataRow dr in ds.Rows) 
			{
				orderList.Add(new Orders
				{
					OrderId = dr["OrderId"].ToString(),
					OrderDate = dr["OrderDate"].ToString(),
					CustomerName = dr["CustomerName"].ToString(),
					ContactPerson = dr["ContactPerson"].ToString(),
					Email = dr["Email"].ToString(),
					Quantity = dr["Quantity"].ToString(),
					ProductName = dr["ProductName"].ToString(),
					Price = dr["Price"].ToString()
				});
            }
			
			ViewBag.OrderList = orderList;

			return View();
		}

		public IActionResult Privacy()
		{
			return View();
		}

		[ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
		public IActionResult Error()
		{
			return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
		}
	}
}