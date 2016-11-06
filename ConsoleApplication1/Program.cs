using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

using HandHistories.Objects.GameDescription;
using HandHistories.Objects.Hand;
using HandHistories.Parser.Parsers.Factory;
using HandHistories.Parser.Parsers.Base;

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
		
			try
			{
				// The true causes hand-parse errors to get thrown. If this is false, hand-errors will
				// be silent and null will be returned.
				List<string> hands = new List<string>();
				hands = handHistoryParser.SplitUpMultipleHands(handText).ToList();
				foreach(string hand in hands )
				{
					try
					{
						HandHistory handHistory = handHistoryParser.ParseFullHandHistory(hand, true);
						Console.WriteLine(handHistory.HandId);
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
		}
	}
}
