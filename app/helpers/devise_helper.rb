module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map do |msg| 
      if msg == "Email has already been taken"
        content_tag(:li) do
          tag_1 = "An account has already been set up for you at this email address. "
          tag_2 = link_to 'Please click here to reset your password.', new_user_password_url, class: 'underline text-danger'
          (tag_1 + tag_2).html_safe
        end 
      else
        content_tag(:li, msg) 
      end
    end.join

    sentence = I18n.t('errors.messages.not_saved',
      count: resource.errors.count,
      resource: resource.class.model_name.human.downcase)

    html = <<-HTML
    <div class="alert alert-danger m-t-md">
      <button type="button" class="close" data-dismiss="alert">x</button>
      <h4>#{sentence}</h4>
      #{messages}
    </div>
    HTML

    html.html_safe
  end
end

