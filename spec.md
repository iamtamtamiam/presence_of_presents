# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
      Used Sinatra to build application - generated with Corneal gem
      Controller inherited from Sinatra::Base
- [X] Use ActiveRecord for storing information in a database
      models created and stored inheriting from ActiveRecord::Base
- [X] Include more than one model class (e.g. User, Post, Category)
      Model Classes: User, Occasions, Gifts
- [X] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
      User has many Occasions
      Occasions has many Gifts
- [X] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
      Occasions belong to a User
      Gifts belong to an Occasion
- [X] Include user accounts with unique login attribute (username or email)
      username
- [X] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
      User has full CRUD for occasions and gifts
- [X] Ensure that users can't modify content created by other users
      Helper methods to ensure users cannot view occasions and gifts that do not belong to them (in case of url manipulation)
      Also hid edit and delete links
- [X] Include user input validations
      Params for username and password cannot be empty for a User
      Params for Occasion Title cannot be empty
      Params for Gift Name cannot be empty
- [X] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
      Used Rack-Flash gem to display errors
- [X] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code
      README.md added with license

Confirm
- [X] You have a large number of small Git commits
      Every 5-20 min
- [X] Your commit messages are meaningful
      comments on each step of every commit
- [X] You made the changes in a commit that relate to the commit message
      So that I could keep track myself in case my code started to break, I would be able to go back
      Rather be safe than sorry
- [X] You don't include changes in a commit that aren't related to the commit message
      I confuse myself enough already
