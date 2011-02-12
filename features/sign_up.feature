Feature: Sign up for the web site

Scenario: Cold sign up with valid info
  When I am on the home page
  Then I should see "Sign up"
  When I follow "Sign up"
  Then I should be on the new user registration page
  When I fill in the following:
    | Name | Joe User |
    | Email | joe@user.com |
    | Password | pa$$w0rd |
    | Password confirmation |  pa$$w0rd |
  And I press "Sign up"
  Then I should be on the home page
  And I should see "Welcome, Joe User"

Scenario: Cold sign up with invalid info
  When I am on the home page
  Then I should see "Sign up"
  When I follow "Sign up"
  Then I should be on the new user registration page
  And I press "Sign up"
  Then I should be on new user registration page
  Then show me the page
  And I should see "Name can't be blank"
  And I should see "Email can't be blank"
