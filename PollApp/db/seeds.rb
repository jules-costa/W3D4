# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all

david = User.create!(user_name: "dobrynin")
jules = User.create!(user_name: "jules")
kevin = User.create!(user_name: "kevin")

Poll.destroy_all

election = Poll.create!(title: "Election", author_id: david.id)
snacks = Poll.create!(title: "Snacks", author_id: jules.id)
naps = Poll.create!(title: "Naps", author_id: kevin.id)

Question.destroy_all

president = Question.create!(text: "Who do you want to be president of the United States?", poll_id: election.id)
senator = Question.create!(text: "Who do you want to be your senator? Please pick 2.", poll_id: election.id)
aa_snacks = Question.create!(text: "Which snacks should a/A stock (for free)?", poll_id: snacks.id)
grumpy = Question.create!(text: "When can I take a nap?", poll_id: naps.id)

AnswerChoice.destroy_all

trump = AnswerChoice.create!(text: "Donald Trump", question_id: president.id)
clinton = AnswerChoice.create!(text: "Hillary Clinton", question_id: president.id)
arnold = AnswerChoice.create!(text: "Arnold Schwartzeneger", question_id: senator.id)
rihanna = AnswerChoice.create!(text: "Rihanna", question_id: senator.id)
popcorn = AnswerChoice.create!(text: "Popcorn", question_id: aa_snacks.id)
chips = AnswerChoice.create!(text: "like... I dunno... maybe some chips?", question_id: aa_snacks.id)
no = AnswerChoice.create!(text: "Never!", question_id: grumpy.id)
yes = AnswerChoice.create!(text: "Now is fine.", question_id: grumpy.id)

Response.destroy_all

Response.create!(user_id: david.id, answer_choice_id: clinton.id)
Response.create!(user_id: david.id, answer_choice_id: arnold.id)
Response.create!(user_id: jules.id, answer_choice_id: chips.id)
Response.create!(user_id: jules.id, answer_choice_id: rihanna.id)
Response.create!(user_id: kevin.id, answer_choice_id: yes.id)
Response.create!(user_id: kevin.id, answer_choice_id: popcorn.id)
