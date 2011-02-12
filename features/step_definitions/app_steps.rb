Given /^(?:|I )am logged in as \"(.+)\"$/ do |email|
  user = Factory(:user, :email => email, :password => 'password', :password_confirmation => 'password')
  When %{I am on the new user session page}
  And %{I fill in "Email" with "#{email}"}
  And %{I fill in "Password" with "password"}
  And %{I press "Sign in"}
  Then %{I should see "Welcome, #{user.name}"}
end

Given /^([0-9]+) (.+)(s|) should exist$/ do |count, klass|
  count = count.to_i
  klass = klass.split(/\s+/).join('_').classify.constantize
  assert_equal count, klass.count
end
