# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'rest-client'
Team.destroy_all
Player.destroy_all

response_teams = RestClient::Request.execute(
method: :get,
url: 'https://api-football-v1.p.rapidapi.com/v2/teams/league/2',
headers:{
   "x-rapidapi-key": ""
})

nested_hash_teams = JSON.parse(response_teams)

description_hash = {
    "Liverpool FC" => "Liverpool FC, in full Liverpool Football Club, English professional football (soccer) club based in Liverpool. It is the most successful English team in European football tournament history, having won six European Cup/Champions League trophies. The club has also won the English top-division league title 18 times. Everton FC was the first football team to play in the Anfield stadium that is famous today as Liverpool FC’s historic home. A dispute between Everton and the site’s owner, John Houlding, resulted in Everton moving to Goodison Park and Houlding forming a new team that was eventually named Liverpool FC. The new club played its first game in 1892 and won its first league title in the 1900–01 season. In 1906 Anfield’s newly constructed terrace grandstand was christened Spion Kop for its resemblance to a hill where a famous South African War battle had been fought, which led to the well-known “Kopites” nickname for Liverpool’s fans. Two managers, Bill Shankly (1959–74) and Bob Paisley (1974–83), were responsible for much of Liverpool’s success. Shankly took Liverpool from the English second division to win three English top-division league titles (1963–64, 1965–66, and 1972–73), as well as a Union of European Football Associations (UEFA) Cup victory in 1973. Paisley added a second UEFA Cup in 1976, six English league titles, and three European Cup wins (1977, 1978, and 1981). A fourth European Cup victory came in 1984, and Liverpool reached the final the following year against Juventus at the Heysel Stadium in Belgium. The match was marred by tragedy as 39 fans were killed, primarily by the collapse of a stadium wall that was caused by Liverpool fans charging Juventus supporters. Liverpool was banned from European competition for six years—and all English clubs were banned for five years—after the incident. Another tragedy struck the club in 1989 when, during a Football Association (FA) Cup semifinal match at the Hillsborough stadium in Sheffield, 96 Liverpool fans were crushed to death by overcrowding—England’s deadliest sporting disaster. Since that turbulent period, Liverpool won a third UEFA Cup competition (2001), as well as the 2005 and 2019 Champions League titles. The club has also captured a total of seven FA Cup and seven League Cup victories. Successful Liverpool teams were renowned for a solid defense that set the table for exciting forwards such as Roger Hunt, Kevin Keegan, Ian Rush, Kenny Dalglish (who managed the club from 1985 to 1991), and Michael Owen, as well as attacking midfielder Steven Gerrard."
}

nested_hash_teams['api']['teams'].each do |team|
    newTeam = Team.new
    newTeam.team_id = team["team_id"]
    if team["name"] == "Leicester"
        newTeam.name = "Leicester City FC"
    elsif team["name"] == "Bournemouth"
        newTeam.name = "AFC Bournemouth"
    elsif team["name"] == "Newcastle"
        newTeam.name = "Newcastle United FC"
    elsif team["name"] == "Brighton"
        newTeam.name = "Brighton & Hove Albion FC"
    elsif team["name"] == "Cardiff"
        newTeam.name = "Cardiff City FC"
    elsif team["name"] == "Huddersfield"
        newTeam.name = "Huddersfield Town AFC"
    elsif team["name"] == "Wolves"
        newTeam.name = "Wolverhampton Wanderers FC"
    elsif team["name"] == "West Ham"
        newTeam.name = "West Ham United FC"
    elsif team["name"] == "Tottenham"
        newTeam.name = "Tottenham Hotspur FC"
    else
        newTeam.name = team["name"] + " FC"
    end
    newTeam.description = description_hash[newTeam.name]
    newTeam.code = team["code"]
    newTeam.logo = team["logo"]
    newTeam.country = team["country"]
    newTeam.founded = team["founded"]
    newTeam.stadium_name = team["venue_name"]
    newTeam.venue_surface = team["venue_surface"]
    newTeam.venue_city = team["venue_city"]
    newTeam.venue_capacity = team["venue_capacity"]
    newTeam.save
    if newTeam["name"] == "Liverpool FC"
        alisson = Player.new
        alisson.position = "GK"
        alisson.name = "Alisson"
        alisson.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p116535.png"
        alisson.games_played = 17
        alisson.save_percentage = 87
        alisson.penalty_kick_save_percentage = 100
        alisson.accurate_long_balls_per_game = 4
        alisson.team_id = newTeam.id
        alisson.save

        adrian = Player.new
        adrian.position = "GK"
        adrian.name = "Adrián"
        adrian.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p60706.png"
        adrian.games_played = 10
        adrian.save_percentage = 62
        adrian.penalty_kick_save_percentage = 100
        adrian.accurate_long_balls_per_game = 5
        adrian.team_id = newTeam.id
        adrian.save

        virgil = Player.new
        virgil.position = "D"
        virgil.name = "Virgil Van Dijk"
        virgil.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p97032.png"
        virgil.games_played = 25
        virgil.conceded_per_game = 0.6
        virgil.tackles_per_game = 0.84
        virgil.tackle_accuracy = 57
        virgil.errors_leading_to_goals_per_game = 0
        virgil.team_id = newTeam.id
        virgil.save

        lovren = Player.new
        lovren.position = "D"
        lovren.name = "Dejan Lovren"
        lovren.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p38454.png"
        lovren.games_played = 8
        lovren.conceded_per_game = 1
        lovren.tackles_per_game = 1.25
        lovren.tackle_accuracy = 70
        lovren.errors_leading_to_goals_per_game = 0
        lovren.team_id = newTeam.id
        lovren.save

        jomez = Player.new
        jomez.position = "D"
        jomez.name = "Joe Gomez"
        jomez.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p171287.png"
        jomez.games_played = 16
        jomez.conceded_per_game = 0.125
        jomez.tackles_per_game = 0.875
        jomez.tackle_accuracy = 71
        jomez.errors_leading_to_goals_per_game = 0
        jomez.team_id = newTeam.id
        jomez.save

        robbo = Player.new
        robbo.position = "D"
        robbo.name = "Andy Robertson"
        robbo.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p122798.png"
        robbo.games_played = 25
        robbo.conceded_per_game = 0.6
        robbo.tackles_per_game = 1.6
        robbo.tackle_accuracy = 59
        robbo.errors_leading_to_goals_per_game = 0
        robbo.team_id = newTeam.id
        robbo.save

        trent = Player.new
        trent.position = "D"
        trent.name = "Trent Alexander-Arnold"
        trent.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p169187.png"
        trent.games_played = 25
        trent.conceded_per_game = 0.6
        trent.tackles_per_game = 1.5
        trent.tackle_accuracy = 63
        trent.errors_leading_to_goals_per_game = 0
        trent.team_id = newTeam.id
        trent.save

        matip = Player.new
        matip.position = "D"
        matip.name = "Joel Matip"
        matip.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p60914.png"
        matip.games_played = 7
        matip.conceded_per_game = 0.7
        matip.tackles_per_game = 1.7
        matip.tackle_accuracy = 75
        matip.errors_leading_to_goals_per_game = 0
        matip.team_id = newTeam.id
        matip.save

        fabinho = Player.new
        fabinho.position = "M"
        fabinho.name = "Fabinho"
        fabinho.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p116643.png"
        fabinho.games_played = 16
        fabinho.interceptions_per_game = 1.1
        fabinho.aerial_win_rate = 51
        fabinho.through_balls_per_game = 0.1
        fabinho.passes_per_game = 52.75
        fabinho.team_id = newTeam.id
        fabinho.save

        georginio = Player.new
        georginio.position = "M"
        georginio.name = "Georginio Wijnaldum"
        georginio.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p41733.png"
        georginio.games_played = 24
        georginio.interceptions_per_game = 1.6
        georginio.aerial_win_rate = 40
        georginio.through_balls_per_game = 0
        georginio.passes_per_game = 45.88
        georginio.team_id = newTeam.id
        georginio.save

        milner = Player.new
        milner.position = "M"
        milner.name = "James Milner"
        milner.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p15157.png"
        milner.games_played = 16
        milner.interceptions_per_game = 0.3
        milner.aerial_win_rate = 50
        milner.through_balls_per_game = 0.1
        milner.passes_per_game = 32.56
        milner.team_id = newTeam.id
        milner.save


        keita = Player.new
        keita.position = "M"
        keita.name = "Naby Keita"
        keita.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p175592.png"
        keita.games_played = 7
        keita.interceptions_per_game = 0.9
        keita.aerial_win_rate = 20
        keita.through_balls_per_game = 0.4
        keita.passes_per_game = 29.29
        keita.team_id = newTeam.id
        keita.save

        henderson = Player.new
        henderson.position = "M"
        henderson.name = "Jordan Henderson"
        henderson.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p56979.png"
        henderson.games_played = 24
        henderson.interceptions_per_game = 1
        henderson.aerial_win_rate = 70
        henderson.through_balls_per_game = 0.3
        henderson.passes_per_game = 61.83
        henderson.team_id = newTeam.id
        henderson.save

        ox = Player.new
        ox.position = "M"
        ox.name = "Alex Oxlade-Chamberlain"
        ox.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p81880.png"
        ox.games_played = 17
        ox.interceptions_per_game = 0.8
        ox.aerial_win_rate = 40
        ox.through_balls_per_game = 0.1
        ox.passes_per_game = 23.35
        ox.team_id = newTeam.id
        ox.save

        lallana = Player.new
        lallana.position = "M"
        lallana.name = "Adam Lallana"
        lallana.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p39155.png"
        lallana.games_played = 13
        lallana.interceptions_per_game = 0.4
        lallana.aerial_win_rate = 23
        lallana.through_balls_per_game = 0.1
        lallana.passes_per_game = 16.23
        lallana.team_id = newTeam.id
        lallana.save

        shaqiri = Player.new
        shaqiri.position = "M"
        shaqiri.name = "Xherdan Shaqiri"
        shaqiri.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p68312.png"
        shaqiri.games_played = 6
        shaqiri.interceptions_per_game = 0
        shaqiri.aerial_win_rate = 15
        shaqiri.through_balls_per_game = 0.5
        shaqiri.passes_per_game = 15.00
        shaqiri.team_id = newTeam.id
        shaqiri.save

        firmino = Player.new
        firmino.position = "F"
        firmino.name = "Roberto Firmino"
        firmino.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p92217.png"
        firmino.games_played = 25
        firmino.goals_per_game = 0.3
        firmino.assists_per_game = 0.3
        firmino.big_chances_created_per_game = 0.4
        firmino.shooting_accuracy = 43
        firmino.team_id = newTeam.id
        firmino.save

        mane = Player.new
        mane.position = "F"
        mane.name = "Sadio Mané"
        mane.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p110979.png"
        mane.games_played = 22
        mane.goals_per_game = 0.5
        mane.assists_per_game = 0.3
        mane.big_chances_created_per_game = 0.3
        mane.shooting_accuracy = 49
        mane.team_id = newTeam.id
        mane.save

        salah = Player.new
        salah.position = "F"
        salah.name = "Mohamed Salah"
        salah.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p118748.png"
        salah.games_played = 22
        salah.goals_per_game = 0.6
        salah.assists_per_game = 0.3
        salah.big_chances_created_per_game = 0.5
        salah.shooting_accuracy = 44
        salah.team_id = newTeam.id
        salah.save

        minamino = Player.new
        minamino.position = "F"
        minamino.name = "Takumi Minamino"
        minamino.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p157882.png"
        minamino.games_played = 2
        minamino.goals_per_game = 0
        minamino.assists_per_game = 0
        minamino.big_chances_created_per_game = 0
        minamino.shooting_accuracy = 0
        minamino.team_id = newTeam.id
        minamino.save

        origi = Player.new
        origi.position = "F"
        origi.name = "Divock Origi"
        origi.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p152760.png"
        origi.games_played = 20
        origi.goals_per_game = 0.1
        origi.assists_per_game = 0.1
        origi.big_chances_created_per_game = 0.1
        origi.shooting_accuracy = 45
        origi.team_id = newTeam.id
        origi.save
    end

    if newTeam["name"] == "Tottenham Hotspur FC"
        alisson = Player.new
        alisson.position = "GK"
        alisson.name = "Hugo Lloris"
        alisson.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p37915.png"
        alisson.games_played = 9
        alisson.save_percentage = 77.8
        alisson.penalty_kick_save_percentage = 50
        alisson.accurate_long_balls_per_game = 6
        alisson.team_id = newTeam.id
        alisson.save

        adrian = Player.new
        adrian.position = "GK"
        adrian.name = "Gazzaniga"
        adrian.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p102884.png"
        adrian.games_played = 17
        adrian.save_percentage = 70
        adrian.penalty_kick_save_percentage = 25
        adrian.accurate_long_balls_per_game = 4
        adrian.team_id = newTeam.id
        adrian.save

        virgil = Player.new
        virgil.position = "D"
        virgil.name = "Toby Alderweireld"
        virgil.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p55605.png"
        virgil.games_played = 24
        virgil.conceded_per_game = 1.3
        virgil.tackles_per_game = 1.1
        virgil.tackle_accuracy = 74
        virgil.errors_leading_to_goals_per_game = 0
        virgil.team_id = newTeam.id
        virgil.save

        lovren = Player.new
        lovren.position = "D"
        lovren.name = "Jan Vertonghen"
        lovren.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p39194.png"
        lovren.games_played = 16
        lovren.conceded_per_game = 1.3
        lovren.tackles_per_game = 2.2
        lovren.tackle_accuracy = 60
        lovren.errors_leading_to_goals_per_game = 0
        lovren.team_id = newTeam.id
        lovren.save

        jomez = Player.new
        jomez.position = "D"
        jomez.name = "Davinson Sánchez"
        jomez.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p173904.png"
        jomez.games_played = 18
        jomez.conceded_per_game = 1.2
        jomez.tackles_per_game = 1.8
        jomez.tackle_accuracy = 58
        jomez.errors_leading_to_goals_per_game = 0
        jomez.team_id = newTeam.id
        jomez.save

        robbo = Player.new
        robbo.position = "D"
        robbo.name = "Serge Aurier"
        robbo.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p80226.png"
        robbo.games_played = 20
        robbo.conceded_per_game = 0.9
        robbo.tackles_per_game = 3.3
        robbo.tackle_accuracy = 80
        robbo.errors_leading_to_goals_per_game = 0
        robbo.team_id = newTeam.id
        robbo.save

        trent = Player.new
        trent.position = "D"
        trent.name = "Ben Davies"
        trent.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p115556.png"
        trent.games_played = 6
        trent.conceded_per_game = 1
        trent.tackles_per_game = 0.8
        trent.tackle_accuracy = 20
        trent.errors_leading_to_goals_per_game = 0
        trent.team_id = newTeam.id
        trent.save

        matip = Player.new
        matip.position = "D"
        matip.name = "Juan Foyth"
        matip.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p234908.png"
        matip.games_played = 4
        matip.conceded_per_game = 0.7
        matip.tackles_per_game = 1.7
        matip.tackle_accuracy = 43
        matip.errors_leading_to_goals_per_game = 1
        matip.team_id = newTeam.id
        matip.save

        fabinho = Player.new
        fabinho.position = "M"
        fabinho.name = "Dele Alli"
        fabinho.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p108823.png"
        fabinho.games_played = 18
        fabinho.interceptions_per_game = 0.98
        fabinho.aerial_win_rate = 34
        fabinho.through_balls_per_game = 0.2
        fabinho.passes_per_game = 36.11
        fabinho.team_id = newTeam.id
        fabinho.save

        georginio = Player.new
        georginio.position = "M"
        georginio.name = "Giovani Lo Celso"
        georginio.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p200826.png"
        georginio.games_played = 15
        georginio.interceptions_per_game = 0.2
        georginio.aerial_win_rate = 25
        georginio.through_balls_per_game = 0.33
        georginio.passes_per_game = 23.07
        georginio.team_id = newTeam.id
        georginio.save

        milner = Player.new
        milner.position = "M"
        milner.name = "Tanguy Ndombele"
        milner.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p231372.png"
        milner.games_played = 16
        milner.interceptions_per_game = 0.8
        milner.aerial_win_rate = 42
        milner.through_balls_per_game = 0.13
        milner.passes_per_game = 30.69
        milner.team_id = newTeam.id
        milner.save


        keita = Player.new
        keita.position = "M"
        keita.name = "Erik Lamela"
        keita.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p62974.png"
        keita.games_played = 15
        keita.interceptions_per_game = 0.33
        keita.aerial_win_rate = 17
        keita.through_balls_per_game = 0
        keita.passes_per_game = 24.93
        keita.team_id = newTeam.id
        keita.save

        henderson = Player.new
        henderson.position = "M"
        henderson.name = "Eric Dier"
        henderson.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p93264.png"
        henderson.games_played = 11
        henderson.interceptions_per_game = 0.9
        henderson.aerial_win_rate = 64
        henderson.through_balls_per_game = 0.2
        henderson.passes_per_game = 36.18
        henderson.team_id = newTeam.id
        henderson.save

        ox = Player.new
        ox.position = "M"
        ox.name = "Victor Wanyama"
        ox.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p54756.png"
        ox.games_played = 2
        ox.interceptions_per_game = 0
        ox.aerial_win_rate = 100
        ox.through_balls_per_game = 0
        ox.passes_per_game = 9.50
        ox.team_id = newTeam.id
        ox.save

        lallana = Player.new
        lallana.position = "M"
        lallana.name = "Moussa Sissoko"
        lallana.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p45268.png"
        lallana.games_played = 20
        lallana.interceptions_per_game = 0.6
        lallana.aerial_win_rate = 57
        lallana.through_balls_per_game = 0.2
        lallana.passes_per_game = 45.50
        lallana.team_id = newTeam.id
        lallana.save

        shaqiri = Player.new
        shaqiri.position = "M"
        shaqiri.name = "Harry Winks"
        shaqiri.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p157668.png"
        shaqiri.games_played = 20
        shaqiri.interceptions_per_game = 1
        shaqiri.aerial_win_rate = 15
        shaqiri.through_balls_per_game = 0.1
        shaqiri.passes_per_game = 52.13
        shaqiri.team_id = newTeam.id
        shaqiri.save

        firmino = Player.new
        firmino.position = "F"
        firmino.name = "Heung-Min Son"
        firmino.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p85971.png"
        firmino.games_played = 20
        firmino.goals_per_game = 0.35
        firmino.assists_per_game = 0.35
        firmino.big_chances_created_per_game = 0.45
        firmino.shooting_accuracy = 40
        firmino.team_id = newTeam.id
        firmino.save

        mane = Player.new
        mane.position = "F"
        mane.name = "Harry Kane"
        mane.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p78830.png"
        mane.games_played = 20
        mane.goals_per_game = 0.55
        mane.assists_per_game = 0.1
        mane.big_chances_created_per_game = 0.1
        mane.shooting_accuracy = 43
        mane.team_id = newTeam.id
        mane.save

        salah = Player.new
        salah.position = "F"
        salah.name = "Lucas Moura"
        salah.image = "https://resources.premierleague.com/premierleague/photos/players/250x250/p95715.png"
        salah.games_played = 23
        salah.goals_per_game = 0.2
        salah.assists_per_game = 0.1
        salah.big_chances_created_per_game = 0.1
        salah.shooting_accuracy = 28
        salah.team_id = newTeam.id
        salah.save
    end
end

norwich = Team.new
norwich.team_id = 71
norwich.name = "Norwich City FC"
norwich.code = nil
norwich.logo = "https://media.api-football.com/teams/71.png"
norwich.country = "England"
norwich.founded = 1902
norwich.stadium_name = "Carrow Road"
norwich.venue_surface = "grass"
norwich.venue_city = "Norwich, Norfolk"
norwich.venue_capacity = 27244
norwich.save

west_brom = Team.new
west_brom.team_id = 60
west_brom.name = "West Bromwich Albion FC"
west_brom.code = nil
west_brom.logo = "https://media.api-football.com/teams/60.png"
west_brom.country = "England"
west_brom.founded = 1878
west_brom.stadium_name = "The Hawthorns"
west_brom.venue_surface = "grass"
west_brom.venue_city = "West Bromwich"
west_brom.venue_capacity = 28003
west_brom.save

shef_utd = Team.new
shef_utd.team_id = 62
shef_utd.name = "Sheffield United FC"
shef_utd.code = nil
shef_utd.logo = "https://media.api-football.com/teams/62.png"
shef_utd.country = "England"
shef_utd.founded = 1889
shef_utd.stadium_name = "Bramall Lane"
shef_utd.venue_surface = "grass"
shef_utd.venue_city = "Sheffield"
shef_utd.venue_capacity = 32702
shef_utd.save

swansea = Team.new
swansea.team_id = 76
swansea.name = "Swansea City AFC"
swansea.code = nil
swansea.logo = "https://media.api-football.com/teams/76.png"
swansea.country = "England"
swansea.founded = 1912
swansea.stadium_name = "Liberty Stadium"
swansea.venue_surface = "grass"
swansea.venue_city = "Swansea"
swansea.venue_capacity = 21028
swansea.save

stoke = Team.new
stoke.team_id = 75
stoke.name = "Stoke City FC"
stoke.code = nil
stoke.logo = "https://media.api-football.com/teams/75.png"
stoke.country = "England"
stoke.founded = 1868
stoke.stadium_name = "bet365 Stadium"
stoke.venue_surface = "grass"
stoke.venue_city = "Stoke-on-Trent, Staffordshire"
stoke.venue_capacity = 30089
stoke.save

aston_villa = Team.new
aston_villa.team_id = 66
aston_villa.name = "Aston Villa FC"
aston_villa.code = nil
aston_villa.logo = "https://media.api-football.com/teams/66.png"
aston_villa.country = "England"
aston_villa.founded = 1874
aston_villa.stadium_name = "Villa Park"
aston_villa.venue_surface = "grass"
aston_villa.venue_city = "Birmingham"
aston_villa.venue_capacity = 42788
aston_villa.save

puts "Hi"