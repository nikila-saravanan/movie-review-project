#critic_score
#
require 'nokogiri'
require 'open-uri'

# base_url = "http://www.rottentomatoes.com/m/"
# user_title = "minions"
# user_title = user_title.downcase.gsub(" ","_")
# complete_url = base_url + user_title

# html = open(complete_url)
# movie_data = Nokogiri::HTML(html)

html = open('http://www.metacritic.com/movie/kingsman-the-secret-service')
mc_scrape = Nokogiri::HTML(html)

# critic_score = movie_data.css("div#all-critics-numbers span.meter-value span[itemprop='ratingValue']").text


# movie_description = movie_data.css("div#all-critics-numbers p.critic_consensus").text
# puts movie_description

#mc_score = mc_scrape.css("span[itemprop='ratingValue']")

puts mc_scrape
