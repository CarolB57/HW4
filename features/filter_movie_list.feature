@ignore
Feature: Filter movie list

    As a user,
    So that I can narrow my search,
    I want to be able to filter the movie list by rating.

Background:
    Given the following movies exist:
    | title                   | rating | release_date |
    | Aladdin                 | G      | 25-Nov-1992  |
    | The Lion King           | G      | 24-Jun-1994  |
    | Star Wars               | PG     | 25-May-1977  |
    | The Terminator          | R      | 26-Oct-1984  |
    | When Harry Met Sally... | R      | 21-Jul-1989  |
    | Amelie                  | R      | 25-Apr-2001  |
    | The Incredibles         | PG     | 05-Nov-2004  |

Scenario: restrict to movies with 'PG' or 'R' ratings [cite: 32]
    Given I am on the RottenPotatoes home page
    When I check the following ratings: PG, R
    And I press "ratings_submit"
    Then I should see "The Terminator"
    And I should see "When Harry Met Sally..."
    And I should see "Amelie"
    And I should not see "Aladdin"
    And I should not see "The Lion King"

Scenario: all ratings selected [cite: 48]
    Given I am on the RottenPotatoes home page
    When I check the following ratings: G, PG, R
    And I press "ratings_submit"
    Then I should see all of the movies [cite: 40]