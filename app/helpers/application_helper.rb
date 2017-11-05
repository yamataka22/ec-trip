module ApplicationHelper
  def bootstrap_class_for(flash_type)
    { success: 'alert-primary', error: 'alert-danger',
      alert: 'alert-warning', notice: 'alert-primary' }[flash_type.to_sym] || flash_type.to_s
  end
  def flash_messages
    flash.each do |flash_type, message|
      concat(
          content_tag(:div, message, class: "alert #{bootstrap_class_for(flash_type)}") do
            concat message
          end
      )
    end
  end

  def error_label_tag(object, field)
    if object.errors.present? && object.errors[field].present?
      content_tag :p, object.errors.full_messages_for(field)[0], class: 'text-danger mt-1 small'
    end
  end

  def search_conditions_keeper(params, conditions)
    params_search = params[:search].present? ? params[:search] : {}
    conditions ||= []
    search = {}
    conditions.each do |condition|
      search[condition] = params_search[condition]
    end
    {
        page: params[:page],
        search: search
    }
  end

  def jpy(value, prefix: false, suffix: false, tax: :none)
    value = 0 if value.nil?
    value = number_with_delimiter value
    if prefix
      value = '¥' + value
    elsif suffix
      value += '円'
    end
    if tax == :include
      value += '(税込)'
    elsif tax == :exclude
      value += '(税抜)'
    end
    value
  end
end
