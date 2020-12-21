# frozen_string_literal: true

class SpecialitiesController < ApplicationController
  def index
    @specialities = Speciality.all
  end

  def new
    @speciality = Speciality.new
  end

  def create
    @speciality = Speciality.new(speciality_params)

    if @speciality.save
      flash[:notice] = t(:success, scope: 'helpers.flash.create')
      redirect_to specialities_path
    else
      render 'new'
    end
  end

  def edit
    @speciality = Speciality.find(params[:id])
  end

  def update
    @speciality = Speciality.find(params[:id])

    if @speciality.update(speciality_params)
      flash[:notice] = t(:success, scope: 'helpers.flash.update')
      redirect_to specialities_path
    else
      render 'edit'
    end
  end

  def destroy
    @speciality = Speciality.find(params[:id])

    if @speciality.destroy
      flash[:notice] = t(:success, scope: 'helpers.flash.destroy')
    else
      flash[:error] = t(:failure, scope: 'helpers.flash.destroy')
    end

    redirect_to specialities_path
  end

  def speciality_params
    params
      .require(:speciality)
      .permit(:name)
  end
end
