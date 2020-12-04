# Stats in the Paint

## Check stats for your favorite NBA teams and players


**Flatiron School:** Module 1 Final Project - Software Engineering

**Project Team:** Andres Hernandez and Mary Ann Navarrete



## Stats in the Paint FAQ

### Summary
Stats in the Paint provides up-to-date NBA stats of your favorite NBA teams, NBA players, along with analytics. You can create a new user account to customize your homescreen with your favorite team or browse as a guest and view any team and player stats and schedules.


### Account Member Benefits
Account holders have additional features, such as customized home page with selected favorite team's stats already selected each time you log in. You won't need to go through the menu to select your team every time you log in! You have the option to change your favorite team or view another team at any time. Simply go to the main menu for the ***"Change your favorite team"*** option.  


### User Story
- User can have favorite team/team(s) populate on their Home Screen
- User can access any NBA team's stats
- User can access specific NBA player's stats
- User can compare interesting NBA stats


### Bonus Features
- Music feature upon entering home page (option to play or turn off)!
- LeBron James Player Stats have a special treat! (1. Select Los Angeles Lakers in Teams, 2. Find Lebron in Players)


### About the Developers
Mary Ann & Andres, both NBA fans (Sixers and Spurs fans respectively) with a love for NBA stats and analytics, were the perfectly paired, just 3 weeks before the start of the 2020-2021 NBA season. Their goal was to provide both analytics and data hungry NBA fans with a resource that both customizes the user's home page specific to their favorite team, or any selected team, along with viewing key stats for all 30 teams and players.

Enjoy this app & let's go Sixers! 🏀


### Installation Instructions

1. Fork and clone this repository. (https://github.com/MaryAnnN28/ruby-project-guidelines)
2. Run **bundle install** from your terminal to install all necessary gems.
3. Run **rake db:migrate** to create database on your computer.
4. Run **rake db:seed** to seed the database with some users and the NBA teams!
5. Once the app is set up, simply load up the **run.db** file in your terminal and enjoy the experience!


### Project Resources
1. API integration: We utilized [RapidAPI](https://rapidapi.com/marketplace)
2. Review of analytics & stats: [NBA.com](https://www.nba.com)
3. Review of analytics & stats: [Basketball-reference](https://www.basketball-reference.com)
4. Multiple Ruby Gems were utilized from RubyGems.org: [RubyGems](https://rubygems.org/)


### Project Requirements
1. Access a Sqlite3 Database using ActiveRecord.
2. Minimum of three models
    - Must include one join model
    - Must have a many-to-many relationship
3. Must seed database using data collected either from a CSV, a website by scraping, or an API.
4. Must have a minimum of four(4) ***user stories*** to help explain how a user will interact with app.
5. Models should have methods that answer interesting questions about the data. For example, if you've collected info about movie reviews, what is the most popular movie? What movie has the most reviews?
6. Project should provide a CLI to display the return values of interesting methods.  
7. Use good OO design patterns. Project should have separate classes for the models and CLI interface.
