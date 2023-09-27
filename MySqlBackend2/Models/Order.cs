namespace MySqlBackend2.Models
{
    public class Orders
    {
        public string? OrderId { get; set; }
        public string? OrderDate { get; set; }
        public string? CustomerName { get; set; }
        public string? ContactPerson { get; set; }
        public string? Email { get; set; }
        public string? Quantity { get; set; }
        public string? ProductName { get; set; }
        public string? Price { get; set; }
    }
}
