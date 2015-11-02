require 'nokogiri'
require 'open-uri'

class Movie < ActiveRecord::Base
  attr_accessor(:score)
  attr_reader(:critic_score)
  validates :title, presence: true
  validates :rating, presence: true
  validates :rating, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }

  def get_rt_data
    begin
      rt_title = self[:title].downcase.gsub(" ","_")
      base_url = "http://www.rottentomatoes.com/m/"
      complete_url = base_url + rt_title
      html = open(complete_url)
      Nokogiri::HTML(html)
    rescue
      return nil
    end
  end

  def self.ratings_avg
    sum = 0
    @movies = Movie.all
    @movies.each do |movie|
      unless movie.rating == nil
        sum += movie.rating
      end
    end
    sum / @movies.length
  end

  def self.alphabetized
    @movies = Movie.all
    @movies.sort_by &:title
  end

  def self.ranked
    @movies = Movie.all
    movies = @movies.sort_by &:rating
    movies.reverse
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
    if rt_data == nil
      return nil
    else
      rt_data.css("div#all-critics-numbers span.meter-value span[itemprop='ratingValue']").text
    end
  end

  # def get_mc_score
  #   mc_data = get_mc_data
  #   mc_data.css("div#all-critics-numbers span.meter-value span[itemprop='ratingValue']").text
  # end

  def get_rt_consensus
    rt_data = get_rt_data
    if rt_data == nil
      return nil
    else
      critics_consensus = rt_data.css("div#all-critics-numbers p.critic_consensus").text
      critics_consensus = critics_consensus.gsub(" Critics Consensus:","Critics Consensus:")
    end
  end
end
