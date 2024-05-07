@block @block_dash @dash_cohort_users @javascript @_file_upload
Feature: Dash program to show the list of cohort users
  In order to show the users data source in dash block on the dashboard
  As an admin
  I can add the user dash block to the dashboard

  Background:
    Given the following "categories" exist:
      | name       | category | idnumber |
      | Category 2 | 0        | CAT2     |
      | Category 3 | 0        | CAT3     |
      | Category 4 | CAT3     | CAT4     |
    And the following "courses" exist:
      | fullname | shortname | category | enablecompletion |
      | Course 1 | C1        | 0        | 1                |
      | Course 2 | C2        | CAT2     | 0                |
      | Course 3 | C3        | CAT3     | 1                |
      | Course 4 | C4        | CAT4     | 1                |
    And the following "users" exist:
      | username | firstname | lastname | email                |
      | student1 | Student   | First    | student1@example.com |
      | student2 | Student   | Second   | student2@example.com |
      | student3 | Student   | Third    | student3@example.com |
      | student4 | Student   | Fourth   | student4@example.com |
      | student5 | Student   | Fifth    | student5@example.com |
      | student6 | Student   | Sixth    | student6@example.com |
      | student7 | Student   | Seventh  | student7@example.com |
      | teacher1 | Teacher   | First    | teacher1@example.com |
      | teacher2 | Teacher   | Second   | teacher2@example.com |
      | teacher3 | Teacher   | Third    | teacher3@example.com |
      | teacher4 | Teacher   | Fourth   | teacher4@example.com |
      | teacher5 | Teacher   | Fifth    | teacher5@example.com |
      | teacher6 | Teacher   | Sixth    | teacher6@example.com |
    And the following "course enrolments" exist:
      | user     | course | role    |
      | student1 | C1     | student |
      | student1 | C2     | student |
      | student2 | C2     | student |
      | student3 | C1     | student |
      | student4 | C1     | student |
      | student4 | C2     | student |
      | student5 | C3     | student |
      | teacher1 | C1     | teacher |
      | teacher1 | C2     | teacher |
      | teacher2 | C1     | teacher |
      | teacher3 | C1     | teacher |
    And the following "cohorts" exist:
      | name    | idnumber  |
      | Cohort1 | cohortid1 |
      | Cohort2 | cohortid2 |
      | Cohort3 | cohortid3 |
    And the following "cohort members" exist:
      | user     | cohort    |
      | student1 | cohortid1 |
      | teacher1 | cohortid1 |
      | student2 | cohortid1 |
      | teacher2 | cohortid1 |
      | student3 | cohortid1 |
      | teacher3 | cohortid1 |
      | student4 | cohortid1 |
      | student5 | cohortid1 |
      | student4 | cohortid2 |
      | student6 | cohortid2 |
      | student7 | cohortid2 |

  Scenario: Show cohort users in dashboard
    And I log in as "admin"
    And I navigate to "Appearance > Default Dashboard page" in site administration
    And I turn dash block editing mode on
    And I create dash "Users" datasource
    Then I configure the "New Dash" block
    And I set the field "Block title" to "Users cohort"
    And I press "Save changes"
    Then I open the "Users cohort" block preference
    Then I click on "Conditions" "link"
    And I click on "Cohorts" "checkbox"
    And I set the field "config_preferences[filters][cohort][cohorts][]" to "Cohort1"
    And I press "Save changes"
    And I should see "student1" in the "Users cohort" "block"
    And I should see "student2" in the "Users cohort" "block"
    And I should see "teacher1" in the "Users cohort" "block"
    And I should not see "student7" in the "Users cohort" "block"
    And I should not see "student6" in the "Users cohort" "block"
    Then I open the "Users cohort" block preference
    Then I click on "Conditions" "link"
    And I set the field "config_preferences[filters][cohort][cohorts][]" to "Cohort2"
    And I press "Save changes"
    And I should see "student4" in the "Users cohort" "block"
    And I should see "student6" in the "Users cohort" "block"
    And I should not see "student1" in the "Users cohort" "block"
    And I should not see "teacher1" in the "Users cohort" "block"
    And I click on "Reset Dashboard for all users" "button"
    And I log out
#--student login-- Enabled condition 1
    And I log in as "student1"
    And I am on homepage
    And I should see "student4" in the "Users cohort" "block"
    And I should see "student7" in the "Users cohort" "block"
    And I should see "student6" in the "Users cohort" "block"
    And I should not see "student1" in the "Users cohort" "block"
    And I should not see "student2" in the "Users cohort" "block"
    And I should not see "teacher1" in the "Users cohort" "block"
    And I log out
#--Enable cohorts & Users in one of my cohorts-- Enabled condition 1 & 2
    And I log in as "admin"
    And I turn dash block editing mode on
    And I navigate to "Appearance > Default Dashboard page" in site administration
    Then I open the "Users cohort" block preference
    Then I click on "Conditions" "link"
    And I click on "Users in one of my cohorts" "checkbox"
    And I press "Save changes"
    And I log out
    And I log in as "student1"
    And I am on homepage
    And I should see "student4" in the "Users cohort" "block"
    And I should see "student6" in the "Users cohort" "block"
    And I should see "student7" in the "Users cohort" "block"
    And I should not see "student1" in the "Users cohort" "block"
    And I should not see "student3" in the "Users cohort" "block"
    And I log out
    And I log in as "student2"
    And I am on homepage
    And I should see "student4" in the "Users cohort" "block"
    And I should not see "student1" in the "Users cohort" "block"
    And I should not see "student7" in the "Users cohort" "block"
    And I log out
#--Users in one of my cohorts-- Enabled condition 2 with cohort 2
    And I log in as "admin"
    And I turn dash block editing mode on
    And I navigate to "Appearance > Default Dashboard page" in site administration
    Then I open the "Users cohort" block preference
    Then I click on "Conditions" "link"
    And I click on "Cohorts" "checkbox"
    And I press "Save changes"
    And I log out
    And I log in as "student1"
    And I am on homepage
    And I should see "student4" in the "Users cohort" "block"
    And I should see "student6" in the "Users cohort" "block"
    And I should see "student7" in the "Users cohort" "block"
    And I should not see "student1" in the "Users cohort" "block"
    And I should not see "student3" in the "Users cohort" "block"
    And I log out
    And I log in as "student2"
    And I am on homepage
    And I should see "student4" in the "Users cohort" "block"
    And I should not see "student1" in the "Users cohort" "block"
    And I should not see "student7" in the "Users cohort" "block"
    And I log out
#--Users in one of my cohorts-- Enabled condition 2 with cohort 1 
    And I log in as "admin"
    And I navigate to "Appearance > Default Dashboard page" in site administration
    And I turn dash block editing mode on
    Then I open the "Users cohort" block preference
    Then I click on "Conditions" "link"
    And I click on "Cohorts" "checkbox"
    And I click on "span.select2-selection__choice__remove" "css_element" in the "li.select2-selection__choice[title='Cohort2']" "css_element"
    And I wait "5" seconds
    #And I set the field "#id_config_preferences_filters_cohort_cohorts" to "Cohort1"
    And I set the field "config_preferences[filters][cohort][cohorts][]" to "Cohort1"
    And I click on "Cohorts" "checkbox"
    And I press "Save changes"
    And I log out
    And I log in as "student1"
    And I am on homepage
    And I should see "student4" in the "Users cohort" "block"
    And I should see "student6" in the "Users cohort" "block"
    And I should see "student7" in the "Users cohort" "block"
    And I should not see "student1" in the "Users cohort" "block"
    And I should not see "student3" in the "Users cohort" "block"
    And I log out
    And I log in as "student2"
    And I am on homepage
    And I should see "student4" in the "Users cohort" "block"
    And I should not see "student2" in the "Users cohort" "block"
    And I should not see "student3" in the "Users cohort" "block"
    And I log out
#--Users in one of my cohorts-- Enabled condition 2 with cohort 1 disable condition 1
    And I log in as "admin"
    And I navigate to "Appearance > Default Dashboard page" in site administration
    And I turn dash block editing mode on
    Then I open the "Users cohort" block preference
    Then I click on "Conditions" "link"
    And I click on "Cohorts" "checkbox"
    And I press "Save changes"
    And I log out
    And I log in as "student1"
    And I am on homepage
    And I should see "student4" in the "Users cohort" "block"
    And I should see "student6" in the "Users cohort" "block"
    And I should see "student7" in the "Users cohort" "block"
    And I should not see "student1" in the "Users cohort" "block"
    And I should not see "student3" in the "Users cohort" "block"
    And I log out
    And I log in as "student3"
    And I am on homepage
    And I should see "student4" in the "Users cohort" "block"
    And I should not see "student1" in the "Users cohort" "block"
    And I should not see "student3" in the "Users cohort" "block"
    And I log out

