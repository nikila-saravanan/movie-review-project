require 'nokogiri'
require 'open-uri'

class Movie
  attr_accessor(:score)
  attr_reader(:title,:critic_score)

  def initialize(title)
    @title = title
    @critic_score = nil
  end

  def get_rt_data
    title_1 = @title.downcase.gsub(/['!?.:]/,"")
    title_2 = title_1.gsub(/[,&-]/," ")
    rt_title = title_2.gsub(/\s+/,"_")
    base_url = "http://www.rottentomatoes.com/m/"
    complete_url = base_url + rt_title
    html = open(complete_url)
    Nokogiri::HTML(html)
  end

  def get_rt_score
    rt_data = get_rt_data
    rt_data.css("div#all-critics-numbers span.meter-value span[itemprop='ratingValue']").text
  end

  def get_rt_consensus
    rt_data = get_rt_data
    critics_consensus = rt_data.css("div#all-critics-numbers p.critic_consensus").text
    critics_consensus = critics_consensus.gsub(" Critics Consensus:","Critics Consensus:")
  end

  def get_agreement
    critic_name = data.css("div.review_table div.critic_name a[href='/critic/brad-keefe/']").text
  end

end


