@block @block_dash @dash_feature @javascript @_file_upload
Feature: Add a dash to an admin pages
  In order to check the dash featuers
  I can add the dash block to the dashboard

  Background:
    Given the following "categories" exist:
      | name        | category | idnumber |
      | Category 01 | 0        | CAT1     |
      | Category 02 | 0        | CAT2     |
    And the following "courses" exist:
      | fullname | shortname | category | enablecompletion |
      | Course 1 | C1        | CAT1     | 1                |
      | Course 2 | C2        | CAT1     | 0                |
      | Course 3 | C3        | CAT2     | 1                |
      | Course 4 | C4        | CAT2     | 1                |
    And the following "users" exist:
      | username | firstname | lastname | email                |
      | student1 | Student   | First    | student1@example.com |
      | teacher1 | Teacher   | First    | teacher1@example.com |
      | student2 | Student   | Two      | student2@example.com |
    And the following "activities" exist:
      | activity | course | idnumber | section | name             | intro                 | completion | completionview |
      | page     | C1     | page1    | 0       | Test page name   | Test page description | 2          | 1              |
      | page     | C1     | page2    | 1       | Test page name 2 | Test page description | 2          | 1              |
    And the following "course enrolments" exist:
      | user     | course | role    |
      | student1 | C1     | student |
      | student1 | C2     | student |
      | teacher1 | C1     | teacher |
      | teacher1 | C2     | teacher |

  Scenario: Global Settings : Show header feature
    And I log in as "admin"
    And I navigate to "Plugins > Blocks > Dash" in site administration
    Then I set the field "Show header" to "Hidden"
    Then I press "Save changes"
    And I navigate to "Appearance > Default Dashboard page" in site administration
    And I turn editing mode on
    And I create dash "Users" datasource
    Then I configure the "New Dash" block
    And I set the field "Block title" to "Datasource: Users"
    And I set the following fields to these values:
      | Region | content |
    And I press "Save changes"
    And I create dash "Courses" datasource
    Then I configure the "New Dash" block
    And I set the field "Block title" to "Datasource: Courses"
    And I set the following fields to these values:
      | Region | content |
    And I press "Save changes"
    Then I should see "Datasource: Users"
    Then I should see "Datasource: Courses"
    Then I turn editing mode off
    Then I should not see "Datasource: Users"
    Then I should not see "Datasource: Courses"
    And I click on "Reset Dashboard for all users" "button"
    Then I log in as "student1"
    Then I follow "Dashboard"
    Then I turn editing mode on
    Then I should see "Datasource: Users"
    Then I should see "Datasource: Courses"
    Then I turn editing mode off
    Then I should not see "Datasource: Users"
    Then I should not see "Datasource: Courses"
    Then I log in as "admin"
    And I navigate to "Plugins > Blocks > Dash" in site administration
    Then I set the field "Show header" to "Visible"
    Then I press "Save changes"
    And I navigate to "Appearance > Default Dashboard page" in site administration
    And I turn editing mode on
    And I create dash "Users" datasource
    Then I configure the "New Dash" block
    And I set the field "Block title" to "Datasource: Users Report"
    And I set the following fields to these values:
      | Region | content |
    And I press "Save changes"
    Then I should see "Datasource: Users Report"
    Then I turn editing mode off
    Then I should see "Datasource: Users Report"
    And I click on "Reset Dashboard for all users" "button"
    Then I log in as "student1"
    Then I follow "Dashboard"
    Then I turn editing mode on
    Then I should see "Datasource: Users Report"
    Then I turn editing mode off
    Then I should see "Datasource: Users Report"

  Scenario: Block Settings : Show header feature
    And I log in as "admin"
    And I navigate to "Plugins > Blocks > Dash" in site administration
    Then I set the field "Show header" to "Hidden"
    Then I press "Save changes"
    And I navigate to "Appearance > Default Dashboard page" in site administration
    And I turn editing mode on
    And I create dash "Users" datasource
    Then I configure the "New Dash" block
    And I set the field "Block title" to "Datasource: Users"
    And I set the following fields to these values:
      | Region | content |
      | Show header | Hidden |
    And I press "Save changes"
    And I create dash "Courses" datasource
    Then I configure the "New Dash" block
    And I set the field "Block title" to "Datasource: Courses"
    And I set the following fields to these values:
      | Region | content |
      | Show header | Visible |
    And I press "Save changes"
    Then I should see "Datasource: Users"
    Then I should see "Datasource: Courses"
    Then I turn editing mode off
    Then I should not see "Datasource: Users"
    Then I should see "Datasource: Courses"
    And I click on "Reset Dashboard for all users" "button"
    Then I log in as "student1"
    Then I follow "Dashboard"
    Then I turn editing mode on
    Then I should see "Datasource: Users"
    Then I should see "Datasource: Courses"
    Then I turn editing mode off
    Then I should not see "Datasource: Users"
    Then I should see "Datasource: Courses"

  Scenario: Block Settings: Dash settings improvements
    And I log in as "admin"
    #General setting css classes
    And I navigate to "Plugins > Blocks > Dash" in site administration
    And I set the following fields to these values:
      | CSS classes | dash-card-block |
    And I press "Save changes"
    And I wait "2" seconds

    # Dash block setting css classes
    And I follow dashboard
    And I navigate to "Appearance > Default Dashboard page" in site administration
    And I turn dash block editing mode on
    And I add the "Dash" block
    And I configure the "New Dash" block
    And I expand all fieldsets
    And the field "config_css_class" matches value "dash-card-block"
    And I set the following fields to these values:
      | CSS classes | dash-element, dash-card |
    And I press "Save changes"
    And I wait "2" seconds
    And I click on "Reset Dashboard for all users" "button"
    And I follow dashboard
    And ".dash-element.dash-card" "css_element" should exist in the ".block-region .block_dash" "css_element"

    # Gradient color
    And I navigate to "Appearance > Default Dashboard page" in site administration
    And I turn dash block editing mode on
    And I add the "Dash" block
    And I configure the "New Dash" block
    And I expand all fieldsets
    And I set the following fields to these values:
      | Background gradient | linear-gradient(90deg, rgba(255, 210, 0, .2) 0%, rgba(70, 210, 251, .2) 100%) |
    And I press "Save changes"
    And I wait "2" seconds
    And I click on "Reset Dashboard for all users" "button"
    And I follow dashboard
    And I check dash css "linear-gradient(90deg, rgba(255, 210, 0, 0.2) 0%, rgba(70, 210, 251, 0.2) 100%)" "#inst149013" "background-image"

    # Font color picker
    And I navigate to "Appearance > Default Dashboard page" in site administration
    And I turn dash block editing mode on
    And I add the "Dash" block
    And I click on "Course categories" "radio"
    And I configure the "New Dash" block
    And I expand all fieldsets
    And I set the following fields to these values:
      | Block title | Course categories |
      | Font color | #c60061 |
    And I press "Save changes"
    And I click on "#action-menu-toggle-0" "css_element"
    And I wait "30" seconds
    And I click on "Preferences" "link" in the "Course categories" "block"
    Then I click on "Fields" "link" in the "Edit preferences" "dialogue"
    And I click on "Select all" "button"
    And I press "Save changes"
    And I click on "Reset Dashboard for all users" "button"
    And I follow dashboard
    And I check dash css "rgb(198, 0, 97)" "#inst149007 #instance-149007-header" "color"

    # Border color
    And I navigate to "Appearance > Default Dashboard page" in site administration
    And I turn dash block editing mode on
    And I add the "Dash" block
    And I configure the "New Dash" block
    And I expand all fieldsets
    And the field "Border" matches value "Disable"
    And I set the following fields to these values:
      | Border | Enable |
      | Border Value | 2px solid #000 |
    And I press "Save changes"
    And I wait "2" seconds
    And I click on "Reset Dashboard for all users" "button"
    And I follow dashboard
    And I check dash css "2px solid rgb(0, 0, 0)" "#inst149007" "border"

    # Background Image settings
    And I navigate to "Appearance > Default Dashboard page" in site administration
    And I turn dash block editing mode on
    And I add the "Dash" block
    And I configure the "New Dash" block
    And I expand all fieldsets
    And I upload "/blocks/dash/tests/assets/background.jpg" file to "Background image" filemanager
    And I set the following fields to these values:
      | Block title | Course categories |
      | Background Position      | Left Center   |
      | Background Size          | Contain       |
    And I press "Save changes"
    And I wait "2" seconds
    And I click on "Reset Dashboard for all users" "button"
    And I follow dashboard
    And I wait "20" seconds
    And I check dash css "0% 50%" "#inst149007" "background-position"
    And I check dash css "contain" "#inst149007" "background-size"
    And I navigate to "Appearance > Default Dashboard page" in site administration
    And I turn dash block editing mode on
    And I configure the "Course categories" block
    And I expand all fieldsets
    And I set the following fields to these values:
      | Background Position          | Custom        |
      | Custom Background Position   | Center Top    |
      | Background Size              | Custom        |
      | Custom Background Size       | Cover         |
    And I press "Save changes"
    And I wait "2" seconds
    And I click on "Reset Dashboard for all users" "button"
    And I follow dashboard
    And I check dash css "50% 0%" "#inst149011" "background-position"
    And I check dash css "cover" "#inst149011" "background-size"

    Scenario: Default fields after selecting the data source
      And I log in as "admin"

      # Users data source
      And I navigate to "Appearance > Default Dashboard page" in site administration
      And I turn dash block editing mode on
      And I add the "Dash" block
      And I configure the "New Dash" block
      And I expand all fieldsets
      And I set the following fields to these values:
        | Block title | Users |
      And I press "Save changes"
      And I click on "Users" "radio"
      And I click on "Reset Dashboard for all users" "button"
      And I follow dashboard
      And I should see "User" in the "Admin" "table_row"
      # Then the following should exist in the "Users" table:
      #   | First name / Last name | Email address          | Last login  |
      #   | Admin User             | moodle@example.com     | 25/04/24    |
      #   | Student First          | student1@example.com   |             |

      # Courses data source
      And I navigate to "Appearance > Default Dashboard page" in site administration
      And I turn dash block editing mode on
      And I add the "Dash" block
      And I configure the "New Dash" block
      And I expand all fieldsets
      And I set the following fields to these values:
        | Block title | Courses |
      And I press "Save changes"
      And I click on "Courses" "radio"
      And I click on "Reset Dashboard for all users" "button"
      And I follow dashboard
      And I should see "Category 01" in the "Course 1" "table_row"
      # Then the following should exist in the "Users" table:
      #   | First name / Last name | Email address          | Last login  |
      #   | Admin User             | moodle@example.com     | 25/04/24    |
      #   | Student First          | student1@example.com   |             |

      # Dashboards data source
      And I navigate to "Appearance > Default Dashboard page" in site administration
      And I turn dash block editing mode on
      And I add the "Dash" block
      And I configure the "New Dash" block
      And I expand all fieldsets
      And I set the following fields to these values:
        | Block title | Dashboards |
      And I press "Save changes"
      And I click on "Dashboards" "radio"
      And I click on "Reset Dashboard for all users" "button"
      And I follow dashboard
      And I should see "Core dashboard" in the "Core dashboard" "table_row"
      # Then the following should exist in the "Users" table:
      #   | First name / Last name | Email address          | Last login  |
      #   | Admin User             | moodle@example.com     | 25/04/24    |
      #   | Student First          | student1@example.com   |             |

      # Badges data source
      And I navigate to "Badges > Add a new badge" in site administration
        And I set the following fields to these values:
        | Name        | Demo badge             |
        | Description | Demo badge description |
      And I upload "/blocks/dash/tests/assets/background.jpg" file to "Background image" filemanager
      And I press "Create badge"
      And I navigate to "Appearance > Default Dashboard page" in site administration
      And I turn dash block editing mode on
      And I add the "Dash" block
      And I configure the "New Dash" block
      And I expand all fieldsets
      And I set the following fields to these values:
        | Block title | Badges |
      And I press "Save changes"
      And I click on "Badges" "radio"
      And I click on "Reset Dashboard for all users" "button"
      And I follow dashboard
      And I should see "demo" in the "Site Badge" "table_row"
      # Then the following should exist in the "Users" table:
      #   | First name / Last name | Email address          | Last login  |
      #   | Admin User             | moodle@example.com     | 25/04/24    |
      #   | Student First          | student1@example.com   |             |



