# frozen_string_literal: true

require 'rails_helper'

describe 'Специальности:' do
  let(:user) { User.create!(email: 'test@example.com', password: 'password') }

  let(:otolaryngologist) { Speciality.create!(name: 'Отоларинголог') }
  let(:therapist) { Speciality.create!(name: 'Терапевт') }

  before { login_as(user, scope: :user) }

  describe 'список' do
    before do
      # обращаемся к специальностям для создавния в БД
      otolaryngologist
      therapist

      visit specialities_path
    end

    it 'отображается' do
      expect(page).to have_text('Отоларинголог')
      expect(page).to have_text('Терапевт')
      expect(page).to have_link('Добавить специальность', href: new_speciality_path)
      expect(page).to have_link('Редактировать', href: edit_speciality_path(otolaryngologist))
    end
  end

  describe 'форма создания' do
    before do
      visit new_speciality_path

      fill_in 'Наименование', with: 'Терапевт'
      click_button 'Добавить'
    end

    it 'работает' do
      expect(page).to have_text('Создание успешно')
      expect(page).to have_text('Терапевт')
    end
  end

  describe 'форма редактирования' do
    before do
      # обращаемся к специальности для создавния в БД
      therapist

      visit edit_speciality_path(therapist)

      fill_in 'Наименование', with: 'Психиатр'
      click_button 'Обновить'
    end

    it 'работает' do
      expect(page).to have_text('Обновление успешно')
      expect(page).to have_text('Психиатр')
    end
  end

  describe 'удлаение' do
    before do
      # обращаемся к специальностям для создавния в БД
      otolaryngologist
      therapist

      visit specialities_path

      # нажимаем ссылку удаления в последней строке таблицы
      within('tbody tr:last-child') do
        click_link 'Удалить'
      end
    end

    it 'работает' do
      expect(page).to have_text('Удаление успешно')
      expect(page).to have_text('Отоларинголог')
      expect(page).to have_no_text('Терапевт')
    end
  end
end
