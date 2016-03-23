module ApplicationHelper
  def friendly_validation_message(validation_result, field)
    validation_result.errors.full_messages_for(field).join('. ')
  end

  def validation_error_class(validation_result, field)
    validation_result.errors[field].empty? ? '' : 'has-error'
  end

  def bootstrap_class_for(flash_type)
    {success: 'alert-success', error: 'alert-danger', alert: 'alert-warning', notice: 'alert-info'}[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do
        concat message
      end)
    end
    nil
  end
end
