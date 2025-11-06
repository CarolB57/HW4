@director_search
Feature: Find Movies With Same Director

    As a user,
    So that I can discover similar movies,
    I want to be able to find all movies by a specific director.

Background:
    Given the following movies exist:
    | title         | rating | release_date | director             |
    | Star Wars     | PG     | 25-May-1977  | George Lucas         |
    | THX 1138      | R      | 11-Mar-1971  | George Lucas         |
    | The Godfather | R      | 24-Mar-1972  | Francis Ford Coppola |
    | Blade Runner  | R      | 25-Jun-1982  |                      |
    | Alien         | R      | 25-May-1979  |                      |


Scenario: Add director info to an existing movie [cite: 45]
    Given I am on the details page for "Blade Runner"
    When I follow "Edit Info"
    And I fill in "Director" with "Ridley Scott"
    And I press "Update Movie Info"
    Then I should be on the details page for "Blade Runner"
    And I should see "Director: Ridley Scott"

Scenario: Find movies with same director (Happy Path) [cite: 46]
    Given I am on the details page for "Star Wars"
    When I follow "Find Movies With Same Director"
    Then I should be on the "Similar Movies" page for "Star Wars"
    And I should see "THX 1138"
    And I should not see "The Godfather"
    And I should not see "Blade Runner"

Scenario: Find movies with same director (Sad Path) [cite: 48]
    Given I am on the details page for "Alien"
    When I follow "Find Movies With Same Director"
    Then I should be on the RottenPotatoes home page
    And I should see "'Alien' has no director info."