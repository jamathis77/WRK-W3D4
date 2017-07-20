# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
u1 = User.create!(user_name: "Jacob") # 9
u2 = User.create!(user_name: "Maverick") # 10

Poll.destroy_all
p1 = Poll.create!(author_id: u1.id, title: "Super Hero Questions") # 5

Question.destroy_all
q1 = Question.create!(text: "If you could have one superpower, what would it be?", poll_id: p1.id) # 5

AnswerChoice.destroy_all
ac1 = AnswerChoice.create!(text: "Telepathy", question_id: q1.id) # 13
ac2 = AnswerChoice.create!(text: "Flight", question_id: q1.id) # 14
ac3 = AnswerChoice.create!(text: "Freeze Breath", question_id: q1.id) # 15

Response.destroy_all
r1 = Response.create!(user_id: u1.id, answer_choice_id: ac2.id) # 7
r2 = Response.create!(user_id: u2.id, answer_choice_id: ac1.id) # 8
