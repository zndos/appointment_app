# frozen_string_literal: true

class AppointmentsController < ApplicationController
  def new
    @doctor = Doctor.find(params[:doctor_id])
    @appointment = Appointment.new(doctor: @doctor)
  end

  def create
    @doctor = Doctor.find(params[:doctor_id])
    @appointment = Appointment.new(doctor: @doctor, patient: current_user.patient)
    @appointment.assign_attributes(appointments_params)
    if @appointment.save
      flash[:notice] = t(:success, scope: 'helpers.flash.create')
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def appointments_params
    params.require(:appointment).permit(:appointed_at)
  end
end
