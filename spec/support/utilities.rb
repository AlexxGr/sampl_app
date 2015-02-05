def full_title(page_title)
  base_title = "Ruby on Rails Tutorial Sample App"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

=begin
# добавили определения имеет_ошибку  и не_имеет_ошибку
RSpec::Matchers.define :have_error_message do |message|
   match do |page|
      expect(page).to have_selector('div.alert.alert-error', text: message)
   end
end

RSpec::Matchers.define :not_have_error_message do
   match do |page|
      expect(page).not_to have_selector('div.alert.alert-error')
   end
end
=end
