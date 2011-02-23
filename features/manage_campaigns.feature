Feature: A user should be able to create and manage campaigns

Scenario: A user can create a new campaign
  Given I am logged in as "game@master.com"
  And I am on the home page
  When I follow "Create New Campaign"
  Then I should be on the new campaign page
  And I fill in the following:
    | Title       | A New Campaign                                 |
    | Description | Some cool stuff happens, and the heros prevail |
  And I press "Create Campaign"
  Then I should be on the the page for the campaign titled "A New Campaign"
  And I should see "A New Campaign"
  And I should see "Some cool stuff happens, and the heros prevail"

@wip @javascript
Scenario: A GM can invite users to join his campaign
  Given the following user exists:
    | name       | email           |
    | Joe Player | player@game.com |
  And I am logged in as "master@game.com"
  And the following campaign exists:
    | title          | description        | gm                     |
    | A New Campaign | Cool stuff happens | email: game@master.com |
  And I am on the page for the campaign titled "A New Campaign"
  Then I should see "Invite Players"
  And I fill in the following:
    | Email | player@game.com |
  And I press "Send Invitation"
  Then 1 invitation should exist
