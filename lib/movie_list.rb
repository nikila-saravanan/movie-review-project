require 'pry'
require 'pstore'

class Movie_List
  def initialize
    @movies_store ||= PStore.new("../movies.pstore")
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
    puts "What rating (out of 100) would you like to give this movie?"
    rating = gets.chomp
    puts "#{title} has been added to your list with a rating of #{rating}."
    @movies_store.transaction do
      @movies_store[title] = rating
      binding.pry
    end
  end

  def view_movie
    puts "What movie would you like to see?"
    film = gets.chomp
    score = @movies_store.transaction { @movies_store[film] }
    if score != nil
      movie = Movie.new(film)
      movie.score = score
      puts "#{movie.title}"
      puts "Your Score: #{movie.score}"
      puts "Rotten Tomatoes Score: #{movie.get_rt_score}"
      #puts "Metacritic Score: #{movie.get_mc_score}"
      puts "#{movie.get_rt_consensus}"
    else
      puts "That movie is not in your list."
    end
  end

  def change_score
    puts "What film's score would you like to change?"
    film = gets.chomp
    score = @movies_store.transaction { @movies_store[film] }
    if score != nil
      puts "What would you rate this movie?"
      rating = gets.chomp
      @movies_store.transaction do
        @movies_store[film] = rating
      end
      puts "The rating has been updated, the score for #{film} is now #{rating}."
    else
      puts "This movie is not in your list."
    end
  end


  def exit
    puts "Goodbye"
  end

end