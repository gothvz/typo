Feature: Create or Edit Categories
	As a blog administrator
	In order to manage articles
	I want to be able to create and edit categories

	Background: 
		Given the blog is set up
		And I am logged into the admin panel

	Scenario: Admin can create a new category
		Given I follow "Categories"
		Then I should see "Categories"
		And I should see "Name"
		And I should see "Keywords"
		And I should see "Permalink"
		And I should see "Description"
		When I fill in "Name" with "Category Sample"
		And I press "Save"
		Then I should see "Category Sample"
		And I should see "no articles"
		

	Scenario: Admin can edit an existing category
		Given I follow "Categories"
		Then I should see "General"
		When I follow "General"
		And I fill in "Name" with "GenStuff"
		And I press "Save"
		Then I should see "GenStuff"
		And I should not see "General"