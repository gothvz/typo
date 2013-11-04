Given /^I am logged in as "([^"]*)" with password "([^"]*)"$/ do |login, password|
  visit '/accounts/login'
  fill_in 'user_login', :with => login
  fill_in 'user_password', :with => password
  click_button 'Login'
  if page.respond_to? :should
    page.should have_content('Login successful')
  else
    assert page.has_content?('Login successful')
  end
end

Given /^the following (.+) exist:$/ do |type, table|
	table.hashes.each do |item|
		if type == "users"
			User.create!(item)
		elsif type == "comments"
			Comment.create!(item)
		elsif type == "articles"
			Article.create!(item)
		end
	end
end
 

Given /^the articles with ids "(\d+)" and "(\d+)" are merged$/ do |a1, a2|
  current_article = Article.find(a1)
  current_article.merge_with(a2)
end


Then /"(.+)" should have (\d+) article/ do |user, count|
  assert Article.find_all_by_author(User.find_by_name(user).login).size == Integer(count)
end
