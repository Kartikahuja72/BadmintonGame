🏸 Badminton League Manager

A simple Ruby on Rails web application to manage a badminton league.
Users can manage players, record matches, and track rankings based on performance.

http://localhost:3000

Features--------------->
Authentication#######################
User Signup
User Login
JWT-based authentication

Player Management#####################
Add new players
Edit players
Delete players
View all players

Each player has:============
Name
Phone (unique)
Wins (auto-updated)
Losses (auto-updated)

Match Management####################
Record match between two players
Store:
Player A
Player B
Winner
Loser (auto-calculated)
Automatically updates player stats

Leaderboard / Stats##############
Rankings based on:
Wins (descending)
Losses (ascending)
Displays:
Rank
Name
Wins
Losses
Win Percentage


Tech Stack----------------------->
Backend: Ruby on Rails
Frontend: ERB (HTML, CSS, JS)
Database: MySQL / PostgreSQL
Authentication: JWT


Routes========================================>
Frontend Pages
/ → Login page
/signup → Signup page
/dashboard → Main dashboard
/players-page → Players list
/players/new → Create player
/players/:id/edit → Edit player
/matches-page → Create match
/match-results-page → Match history
/leaderboard-page → Leaderboard




API Endpoints----------------------------------------->
Auth
POST /signup
POST /login
Players
GET /players
POST /players
PUT /players/:id
DELETE /players/:id
Matches
POST /matches
Stats
GET /stats/leaderboard
GET /match_results

Setup Instructions-------------------------->
git clone 
cd badminton-league

bundle install
rails db:create
rails db:migrate

Open in browser:
rails server
http://localhost:3000
