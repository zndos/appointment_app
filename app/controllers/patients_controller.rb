# frozen_string_literal: true

class PatientsController < ApplicationController
  def edit
    @patient = current_user.patient || current_user.build_patient
  end

  def update
    @patient = current_user.patient || current_user.build_patient
    @patient.assign_attributes(patient_params)
    if @patient.save
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private

  def patient_params
    params
      .require(:patient)
      .permit(:last_name, :first_name, :gender, :birthday, :phone_number)
  end
end
