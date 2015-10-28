require 'nokogiri'
require 'open-uri'

class Movie < ActiveRecord::Base
  attr_accessor(:score)
  attr_reader(:title,:critic_score)

  def get_rt_data
    rt_title = self[:title].downcase.gsub(" ","_")
    base_url = "http://www.rottentomatoes.com/m/"
    complete_url = base_url + rt_title
    html = open(complete_url)
    Nokogiri::HTML(html)
  end

  # def get_mc_data
  #   mc_title = @title.downcase.gsub(" ","-")
  #   base_url = "http://www.metacritic.com/movie/"
  #   complete_url = base_url + mc_title
  #   html = open(complete_url)
  #   Nokogiri::HTML(html)
  # end

  def get_rt_score
    rt_data = get_rt_data
    rt_data.css("div#all-critics-numbers span.meter-value span[itemprop='ratingValue']").text
  end

  # def get_mc_score
  #   mc_data = get_mc_data
  #   mc_data.css("div#all-critics-numbers span.meter-value span[itemprop='ratingValue']").text
  # end

  def get_rt_consensus
    rt_data = get_rt_data
    critics_consensus = rt_data.css("div#all-critics-numbers p.critic_consensus").text
    critics_consensus = critics_consensus.gsub(" Critics Consensus:","Critics Consensus:")
  end
end
