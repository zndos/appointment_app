# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @doctors = Doctor.eager_load(:speciality).all
  end
end
