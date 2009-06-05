require 'md5'
# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def gravitar_url(email)
    gravatar_id = MD5.new(email).to_s
    gravatar_source = "http://www.gravatar.com/avatar.php?gravatar_id=" + gravatar_id
  end
  
  def authenticated_only_block
    auth_only_css_class = "hidden" unless logged_in?
    auth_only_css_class
  end
end
