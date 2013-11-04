Feature: Merge Articles
	As a blog administrator
	In order to manage similar articles
	I want to be able to merge articles with the same topic

	Background: users, articles and comments are added to the database

		Given the blog is set up

		Given the following users exist:
		| login | password | email          | profile_id | name  | state  |
		| user1 | user1pw  | user1@type.com | 2          | user1 | active |
		| user2 | user2pw  | user2@type.com | 3          | user2 | active |
		| user3 | user3pw  | user3@type.com | 4          | user3 | active |

		Given the following articles exist:
		| id | title  | author | user_id | body           | allow_comments | published | published_at        |
		| 3  | Post 3 | user1  | 2       | Post.3 Content | true           | true      | 2012-01-01 01:01:01 |
		| 4  | Post 4 | user2  | 3       | Post.4 Content | true           | true      | 2012-01-01 01:01:02 |

		Given the following comments exist:
		| id | type    | author | user_id | body              | article_id |
		| 1  | Comment | user3  | 4       | Comment 1 Content | 3          |
		| 2  | Comment | user3  | 4       | Comment 2 Content | 4          |


	Scenario: Non-admin cannot merge articles
		Given I am logged in as "user1" with password "user1pw"
		And I go to the edit article page for id "3"
		Then I should not see "Merge Articles"

	Scenario: Admin can merge articles
	  Given I am logged into the admin panel
		And I go to the edit article page for id "3"
		Then I should see "Merge Articles" 
		When I fill in "merge_with" with "4"
		And I press "Merge"
		Then I should see "Merge succeeded."

	Scenario: Merged article should contain the text of both originals
		Given the articles with ids "3" and "4" are merged
		And I am on the home page
		Then I should see "Post 3"
		When I follow "Post 3"
		Then I should see "Post.3 Content"
		And I should see "Post.4 Content"

	Scenario: Merged article should have one author from one of the originals
		Given the articles with ids "3" and "4" are merged
		Then "user1" should have 1 article
		And "user2" should have 0 article

	Scenario: Merged article should have the comments from both originals
		Given the articles with ids "3" and "4" are merged
		And I am on the home page
		Then I should see "Post 3"
		When I follow "Post 3"
		Then I should see "Comment 1 Content"
		And I should see "Comment 2 Content"


	Scenario: Merged article should have one title from one of the originals
		Given the articles with ids "3" and "4" are merged
		And I am on the home page
		Then I should see "Post 3"
		And I should not see "Post 4"