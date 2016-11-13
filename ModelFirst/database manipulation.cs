using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ModelFirst
{
	class Program
	{
		static void Main(string[] args)
		{
			
				// Create and save a new player 
				Console.Write("Enter a name for a new Player: ");
				string name = Console.ReadLine();
				Console.Write("Enter the winnings this players has: ");
				string winnings = Console.ReadLine();
				
				var player = new  Player { Name = name, Winnings=winnings };
				var db = new DbCreate();
			
				db.Database.CreateIfNotExists();

				List<Player> newPlayer = new List<Player>();
				newPlayer.Add(player);

				var newUserIDs = newPlayer.Select(u => u.Name.ToUpper()).Distinct().ToArray();
				var usersInDb = db.Players.Where(u => newUserIDs.Contains(u.Name.ToUpper()))
											   .Select(u => u.Name.ToUpper()).ToArray();
				var usersNotInDb = newPlayer.Where(u => !usersInDb.Contains(u.Name.ToUpper()));
				foreach (Player playa in usersNotInDb)
				{
					db.Players.Add(playa);
					
				}
				foreach (string playa in usersInDb)
				{
					if (player.Name.ToUpper().Contains(playa))
					{
						db.Players.Attach(player);
					player.Winnings = "1203k"; //Creating winnings calculation function
					var entry = db.Entry(player);
					entry.Property(e => e.Winnings).IsModified = true;

					}
					
				}
				
				

				db.SaveChanges();

				// Display all players from the database 
				var query = from b in db.Players
							orderby b.Name
							select b;

				Console.WriteLine("All Players in the database:");
				foreach (var item in query)
				{
					Console.WriteLine(item.Name + ": " + item.Winnings);
				}

				Console.WriteLine("Press any key to exit...");
				Console.ReadKey();
		
		} 
	}
}
