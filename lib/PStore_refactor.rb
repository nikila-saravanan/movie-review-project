require 'pstore'

  def new_file(filename)
    PStore.new("../#{filename}.pstore")
  end

  def movie_to_file(var,title,rating)
    var.transaction do
      var[title] = rating
    end
  end

  def read_value(var,key)
    var.transaction { var[key] }
  end

  def delete_value(var,value)
    #deletes both key and value from var
    var.transaction { var.delete(value) }
  end

  def get_key_array(var)
    var.transaction { var.roots }
  end
