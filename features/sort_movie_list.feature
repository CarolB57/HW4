@ignore
Feature: Sort movie list

    As a user,
    So that I can find movies more easily,
    I want to be able to sort the movie list.

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

Scenario: sort movies alphabetically [cite: 61]
    Given I am on the RottenPotatoes home page
    When I follow "Movie Title"
    Then I should see "Aladdin" before "Amelie" [cite: 53]
    And I should see "Amelie" before "The Lion King"

Scenario: sort movies in increasing order of release date [cite: 62]
    Given I am on the RottenPotatoes home page
    When I follow "Release Date"
    Then I should see "The Terminator" before "When Harry Met Sally..."
    And I should see "When Harry Met Sally..." before "Aladdin"