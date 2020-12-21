# frozen_string_literal: true

require 'rails_helper'

describe 'Врачи:' do
  let(:user) { User.create!(email: 'test@example.com', password: 'password') }

  let(:otolaryngologist) { Speciality.create!(name: 'Отоларинголог') }
  let(:therapist) { Speciality.create!(name: 'Терапевт') }
  let(:sidorova) do
    Doctor.create!(
      last_name: 'Сидорова',
      first_name: 'Ольга',
      gender: 'female',
      speciality: otolaryngologist
    )
  end
  let(:petrov) do
    Doctor.create!(
      last_name: 'Петров',
      first_name: 'Петр',
      gender: 'male',
      speciality: therapist
    )
  end

  before { login_as(user, scope: :user) }

  describe 'список врачей' do
    before do
      # обращаемся к врачам для создавния в БД
      sidorova
      petrov

      visit doctors_path
    end

    it 'отображается' do
      expect(page).to have_text('Сидорова Ольга Ж Отоларинголог')
      expect(page).to have_text('Петров Петр М Терапевт')
      expect(page).to have_link('Добавить врача', href: new_doctor_path)
      expect(page).to have_link('Редактировать', href: edit_doctor_path(sidorova))
    end
  end

  describe 'форма создания' do
    let(:doctor_information) do
      # heredoc форма записи строки
      # strip нужен для удаления последнего переноса строки
      <<~TEXT.strip
        Фамилия Иванов
        Имя Иван
        Пол М
        Специальность Терапевт
      TEXT
    end

    before do
      # обращаемся к специальности для создавния в БД
      therapist

      visit new_doctor_path

      fill_in 'Фамилия', with: 'Иванов'
      fill_in 'Имя', with: 'Иван'
      choose 'М'
      select 'Терапевт', from: 'Специальность'
      click_button 'Добавить врача'
    end

    it 'работает' do
      expect(page).to have_text('Создание успешно')
      expect(page).to have_text(doctor_information)
    end
  end

  describe 'страница врача' do
    let(:doctor_information) do
      # heredoc форма записи строки
      # strip нужен для удаления последнего переноса строки
      <<~TEXT.strip
        Фамилия Сидорова
        Имя Ольга
        Пол Ж
        Специальность Отоларинголог
      TEXT
    end

    before do
      visit doctor_path(sidorova)
    end

    it 'содержит необходимую информацию' do
      expect(page).to have_text(doctor_information)
      expect(page).to have_link('К списку врачей', href: doctors_path)
      expect(page).to have_link('Редактировать')
    end
  end

  describe 'форма редактирования' do
    let(:doctor_information) do
      # heredoc форма записи строки
      # strip нужен для удаления последнего переноса строки
      <<~TEXT.strip
        Фамилия Васичкин
        Имя Николай
        Пол М
        Специальность Терапевт
      TEXT
    end

    before do
      # обращаемся к специальности для создавния в БД
      therapist

      visit edit_doctor_path(sidorova)

      fill_in 'Фамилия', with: 'Васичкин'
      fill_in 'Имя', with: 'Николай'
      choose 'М'
      select 'Терапевт', from: 'Специальность'
      click_button 'Обновить данные врача'
    end

    it 'работает' do
      expect(page).to have_text('Обновление успешно')
      expect(page).to have_text(doctor_information)
    end
  end

  describe 'удлаение' do
    before do
      # обращаемся к врачам для создавния в БД
      sidorova
      petrov

      visit doctors_path

      # нажимаем ссылку удаления в последней строке таблицы
      within('tbody tr:last-child') do
        click_link 'Удалить'
      end
    end

    it 'работает' do
      expect(page).to have_text('Удаление успешно')
      expect(page).to have_text('Сидорова Ольга')
      expect(page).to have_no_text('Петров Петр')
    end
  end
end
