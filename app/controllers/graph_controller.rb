class GraphController < ApplicationController


  def index
  end

  def show
  end

  def data
    respond_to do |format|
      format.json {
        render :json => [1,2,3,4]
      }
    end
  end
end
