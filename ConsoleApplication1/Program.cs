using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;

using HandHistories.Objects.GameDescription;
using HandHistories.Objects.Hand;
using HandHistories.Parser.Parsers.Factory;
using HandHistories.Parser.Parsers.Base;
using ModelFirst;

namespace ConsoleApplication1
{
	public class Parse
	{
		public static void Main()
		{
			
			ParserExample parser= new ParserExample();
			try
			{
				int parsedHands = 0;
				int thrownOutHands = 0;
				// Open the text file using a stream reader.
				//using (StreamReader sr = new StreamReader("C:\\Users\\rcotter\\Downloads\\PS-2009-07-01_2009-07-23_1000NLH_OBFU\\10\\ps NLH handhq_1-OBFUSCATED.txt"))
				{
					SiteName site = SiteName.PokerStars;
					string folderPath = " C:\\Users\\rcotter\\Downloads\\PS-2009-07-01_2009-07-23_1000NLH_OBFU\\10\\";
					foreach (string file in Directory.EnumerateFiles(folderPath, "*.txt"))
				{
					string contents = File.ReadAllText(file);
					
						HandHistory hand=parser.ParseHand(site, contents, ref parsedHands, ref thrownOutHands);
				}
					// Read the stream to a string, and write the string to the console.
					//String line = sr.ReadToEnd();
					Console.WriteLine("Number of parsed hands:" + parsedHands);
					Console.WriteLine("Number of thrown hands:" + thrownOutHands);
					Console.Read();
				}
			}
			catch (Exception e)
			{
				Console.WriteLine("The file could not be read:");
				Console.WriteLine(e.Message);
			}
		}
	}
	public class ParserExample
	{
		public HandHistory ParseHand(SiteName site, string handText,ref int parsedHands,ref int thrownOutHands)
		{
			
			
	
			// Each poker site has its own parser so we use a factory to get the right parser.
			IHandHistoryParserFactory handHistoryParserFactory = new HandHistoryParserFactoryImpl();

			// Get the correct parser from the factory.
			IHandHistoryParser handHistoryParser = handHistoryParserFactory.GetFullHandHistoryParser(site);
			var db = new DbCreate();
			Console.WriteLine("Parsing Players in the file:");
			try
			{
				// The true causes hand-parse errors to get thrown. If this is false, hand-errors will
				// be silent and null will be returned.
				List<string> hands = new List<string>();
				hands = handHistoryParser.SplitUpMultipleHands(handText).ToList();
				foreach(string hand in hands )
				{
					Console.Write(".");
					try
					{
						HandHistory handHistory = handHistoryParser.ParseFullHandHistory(hand, true);

						//handhistory can now be broken down to be put into the database

						// Create and save a new Blog 

						List<Player> newPlayer = new List<Player>();
						foreach (var item in handHistory.Players)
						{
							var player = new ModelFirst.Player { Name = item.PlayerName, Winnings = "Nothing" };


							
							newPlayer.Add(player);
							//creating plays
							addPlaytoDb(db, handHistory, item, player);
						
						}
						//Creating Hand
						addHandToDb(db, handHistory);

						//creating Table
						var tableToAdd = new ModelFirst.Table
						{
							TableID = handHistory.TableName,
							MaxPlayers = handHistory.GameDescription.SeatType.MaxPlayers,
							Stakes = handHistory.GameDescription.Limit.BigBlind.ToString(), //what's the difference between stakes and limit?
							Site = handHistory.GameDescription.Site.ToString(),
							
							
						}; 
						db.Tables.Add(tableToAdd);

						//creating plays on
						var PlayedOnToAdd = new ModelFirst.PlayedOn
						{
							TableID = handHistory.TableName,
							HandId = handHistory.HandId,
							
							
						}; 
						db.PlayedOns.Add(PlayedOnToAdd);


						//creating HandAction

						//Creating Furthers

						//creating Performs


						
						//validating we can add this PK
						var newUserIDs = newPlayer.Select(u => u.Name.ToUpper()).Distinct().ToArray();
						var usersInDb = db.Players.Where(u => newUserIDs.Contains(u.Name.ToUpper()))
													   .Select(u => u.Name.ToUpper()).ToArray();
						var usersNotInDb = newPlayer.Where(u => !usersInDb.Contains(u.Name.ToUpper()));
						foreach (Player playa in usersNotInDb)
						{
							db.Players.Add(playa);
						 
						}

						
						


						db.SaveChanges();
						
						
					//	Console.WriteLine(handHistory.HandId);
						parsedHands++;
					}
					catch (Exception ex)
					{
						Console.WriteLine("Parsing Error: {0}", ex.Message); // Example logging.
						thrownOutHands++;
					}
				
				}
				return null;
			}
			catch (Exception ex) // Catch hand-parsing exceptions
			{
				Console.WriteLine("Parsing Error: {0}", ex.Message); // Example logging.
				return null;
			}

			
			// Display all Players from the database 
			var query = from b in db.Players
						orderby b.Name
						select b;

			Console.WriteLine("All Players in the database:");
			foreach (var item in query)
			{
				Console.WriteLine(item.Name);
			}

			Console.WriteLine("Press any key to exit...");
			Console.ReadKey();
	}

		private static void addHandToDb(DbCreate db, HandHistory handHistory)
		{
			decimal tmpvalue;
			decimal result = decimal.TryParse(handHistory.TotalPot.ToString(), out tmpvalue) ?
							  tmpvalue : 0;
			var handToAdd = new ModelFirst.Hand
			{
				HandId = handHistory.HandId,
				PotSize = result,
				ButtonPosition = handHistory.DealerButtonPosition,
				Time = handHistory.DateOfHandUtc,
				NumberOfPlayers = handHistory.NumPlayersActive
			}; //creating hand
			db.Hands.Add(handToAdd);
		}

		private static void addPlaytoDb(DbCreate db, HandHistory handHistory, HandHistories.Objects.Players.Player item, Player player)
		{
			var playsToAdd = new ModelFirst.Plays
			{
				HandId = handHistory.HandId,
				Name = player.Name,
				StartingStack = item.StartingStack,
				SeatPosition = item.SeatNumber


			};
			db.Plays.Add(playsToAdd);
		}
	}
}
