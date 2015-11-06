# TomatoSmack!

TomatoSmack! is an app that allows users to create a database of movies they choose, rate those movies, and compare their rating to critics.

# Features

The app sorts movies alphabetically and by ranking on the homepage (See below) 

![Alt text](/app/assets/images/Homescreen.png)

The app leverages the Ruby Nokogiri gem to scrape RottenTomatoes for data on individual movies (RT score and critics consensus), which appears on each individual movie's page. Each movie page also has a D3.js chart that compares the user's and critics' rating for that movie, as well as the user's average rating across all the movies in their database (see below)

![Alt text](/app/assets/images/Moviefile.png)

# Contributing

Fork it Create your feature branch (git checkout -b my-new-feature)
Commit your changes (git commit -am 'Add some feature')
Push to the branch (git push origin my-new-feature)
Create new Pull Request

# License

Goodli is MIT Licensed. See LICENSE for details.
