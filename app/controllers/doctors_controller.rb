# frozen_string_literal: true

class DoctorsController < ApplicationController
  def index
    @doctors = Doctor.eager_load(:speciality).all
  end

  def new
    @doctor = Doctor.new
  end

  def create
    @doctor = Doctor.new(doctor_params)

    if @doctor.save
      flash[:notice] = t(:success, scope: 'helpers.flash.create')
      redirect_to doctor_path(@doctor)
    else
      render 'new'
    end
  end

  def edit
    @doctor = Doctor.find(params[:id])
  end

  def update
    @doctor = Doctor.find(params[:id])

    if @doctor.update(doctor_params)
      flash[:notice] = t(:success, scope: 'helpers.flash.update')
      redirect_to doctor_path(@doctor)
    else
      render 'edit'
    end
  end

  def show
    @doctor = Doctor.find(params[:id])
  end

  def destroy
    @doctor = Doctor.find(params[:id])

    if @doctor.destroy
      flash[:notice] = t(:success, scope: 'helpers.flash.destroy')
    else
      flash[:error] = t(:failure, scope: 'helpers.flash.destroy')
    end

    redirect_to doctors_path
  end

  def doctor_params
    params
      .require(:doctor)
      .permit(:last_name, :first_name, :gender, :speciality_id, :organization_id)
  end
end
