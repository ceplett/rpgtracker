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
