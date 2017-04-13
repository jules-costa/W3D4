class Question < ApplicationRecord
  validates :text, :poll_id, presence: true

  belongs_to :poll,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id

  has_many :answer_choices,
    class_name: "AnswerChoice",
    foreign_key: :question_id,
    primary_key: :id

  has_many :responses,
    through: :answer_choices,
    source: :responses

  def slow_results
    multiple_choice = {}
    answer_choices.each do |answer_choice|
      multiple_choice[answer_choice.text] = answer_choice.responses.count
    end

    multiple_choice
  end

  def medium_results
    answer_choices_with_responses = answer_choices.includes(:responses)

    multiple_choice = {}

    answer_choices_with_responses.each do |answer_choice|
      multiple_choice[answer_choice.text] = answer_choice.responses.length
    end

    multiple_choice
  end

  def fast_results
    AnswerChoice
      .joins("LEFT OUTER JOIN responses ON responses.answer_choice_id = answer_choices.id")
      .where(question_id: id)
      .group("answer_choices.text")
      .pluck("answer_choices.text, COUNT(*) AS count")
  end
end
