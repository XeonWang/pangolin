# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Post.delete_all
Post.create(:user_id => 1, :content => 'Question: How can i delete an existing model and scaffolding in ruby on rails 3?
Top answer: rails destroy scaffold MyScaffold')
Post.create(:user_id => 2, :content => 'Hi i want to delete all stuff related to rails generate scaffold at once. ... You can use this command and enjoying...... rails destroy scaffold ...')
Post.create(:user_id => 3, :content => 'If you then run scaffold again it will warn you of any files that you forgot to delete or any I have forgotten to mention. When I started writing Rails ...')