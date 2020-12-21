class ResultsController < ApplicationController

  def index
    @speciality = Speciality.where("name LIKE ?", "%#{params[:query]}%")
  end

  def show
  end

end
