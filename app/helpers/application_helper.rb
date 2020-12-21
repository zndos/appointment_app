# frozen_string_literal: true

module ApplicationHelper
  def gender_collection
    %i[male female].map do |gender|
      [translate_gender(gender), gender]
    end
  end

  def translate_gender(gender)
    t(gender, scope: 'activerecord.attributes.genders')
  end

  def flash_class(level) # rubocop:disable Metrics/MethodLength
    case level
    when 'notice'
      'alert alert-success'
    when 'warning', 'alert'
      'alert alert-warning'
    when 'error'
      'alert alert-danger'
    when 'primary', 'secondary', 'info', 'light'
      "alert alert-#{level}"
    else
      'alert alert-dark'
    end
  end
end
