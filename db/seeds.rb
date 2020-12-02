require_relative "../config/environment.rb"

User.destroy_all
Team.destroy_all
Favorite_team_joiner.destroy_all


andres = User.create(name: "Andres")
mary_ann = User.create(name: "Mary Ann")

boston = Team.create(name: "Boston Celtics", api_teamID: "2")
brooklyn = Team.create(name: "Brooklyn Nets", api_teamID: "4")
new_york = Team.create(name: "New York Knicks", api_teamID: "24")
philadelphia = Team.create(name: "Philadelphia 76ers", api_teamID: "27")
toronto = Team.create(name: "Toronto Raptors", api_teamID: "38")
chicago = Team.create(name: "Chicago Bulls", api_teamID: "6")
cleveland = Team.create(name: "Cleveland Cavaliers", api_teamID: "7")
detroit = Team.create(name: "Detroit Pistons", api_teamID: "10")
indiana = Team.create(name: "Indiana Pacers", api_teamID: "15")
milwaukee = Team.create(name: "Milwaukee Bucks", api_teamID: "21")
atlanta = Team.create(name: "Atlanta Hawks", api_teamID: "1")
charlotte = Team.create(name: "Charlotte Hornets", api_teamID: "5")
miami = Team.create(name: "Miami Heat", api_teamID: "20")
orlando = Team.create(name: "Orlando Magic", api_teamID: "26")
washington = Team.create(name: "Washington Wizards", api_teamID: "41")
denver = Team.create(name: "Denver Nuggets", api_teamID: "9")
minnesota = Team.create(name: "Minnesota Timberwolves", api_teamID: "22")
oklahoma = Team.create(name: "Oklahoma Thunder", api_teamID: "25")
portland = Team.create(name: "Portland Blazers", api_teamID: "29")
utah = Team.create(name: "Utah Jazz", api_teamID: "40")
golden = Team.create(name: "Golden State Warriors", api_teamID: "11")
clippers = Team.create(name: "Las Angeles Clippers", api_teamID: "16")
lakers = Team.create(name: "Las Angeles Lakers", api_teamID: "17")
phoenix = Team.create(name: "Phoenix Suns", api_teamID: "28")
sacremento = Team.create(name: "Sacremento Kings", api_teamID: "30")
dallas = Team.create(name: "Dallas Mavericks", api_teamID: "8")
houston = Team.create(name: "Houston Rockets", api_teamID: "14")
memphis = Team.create(name: "Memphis Grizzlies", api_teamID: "19")
new_orleans = Team.create(name: "New Orleans Pelicans", api_teamID: "23")
san_antonio = Team.create(name: "San Antonio Spurs", api_teamID: "31")

join1 = Favorite_team_joiner.create(user_id: andres.id, team_id: philadelphia.id)
join2 = Favorite_team_joiner.create(user_id: mary_ann.id, team_id: san_antonio.id)
