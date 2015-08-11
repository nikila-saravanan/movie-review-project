require 'pry'
require 'pstore'

class Movie_List
  def initialize
    @movies = []
    @movies_store = PStore.new("movies.pstore")
  end

  def run
    puts "Please enter a command."
    command = gets.chomp.downcase
    case command
    when "help"
      help
      run
    when "list"
      list
      run
    when "add movie"
      add_movie
      run
    when "change score"
      change_score
      run
    when "view movie"
      view_movie
      run
    when "exit"
      exit
    else
      puts "Not a valid command, please type 'help' for a list of commands."
      run
    end
  end

  def help
    puts 'add movie - adds a movie to your list of movies'
    puts 'view movie - view all rating information for a movie in your list'
    puts 'change score - change the score for a movie already in your list'
    puts 'list - bring up all movies in your list'
    puts 'help - brings up a list of available commands'
    puts 'exit - leaves the program'
    puts
  end

  def list
    @movies.each {|movie|
      puts "#{movie.title} - #{movie.score}"
    }
  end

  def add_movie
    puts "What's the movie title?"
    title = gets.chomp
    movie = Movie.new(title)
    @movies << movie
    puts "What rating (out of 100) would you like to give this movie?"
    rating = gets.chomp
    movie.score = rating
    puts "#{movie.title} has been added to your list with a rating of #{movie.score}."
    @movies_store.transaction do
      @movies_store[movie.title] = movie.score
    end
  end

  def view_movie
    puts "What movie would you like to see?"
    film = gets.chomp
    movie = find_movie(film)
    score = @movies_store.transaction {@movies_store[movie.title]}
    puts "#{movie.title}"
    puts "Your Score: #{score}"
    puts "Rotten Tomatoes Score: #{movie.get_rt_score}"
    #puts "Metacritic Score: #{movie.get_mc_score}"
    puts "#{movie.get_rt_consensus}"
  end

  def find_movie(movie_title)
    @movies.find do |movie|
      if movie.title == movie_title
        return movie
      end
    end
    puts "That movie is not in your list."
    run
  end

  def change_score
    puts "What film's score would you like to change?"
    film = gets.chomp
    movie = find_movie(film)
    puts "What would you rate this movie?"
    rating = gets.chomp
    movie.score = rating
    puts "The rating has been updated, the score for #{movie.title} is now #{movie.score}."
  end


  def exit
    puts "Goodbye"
  end

end