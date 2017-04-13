class Response < ApplicationRecord
  validates :user_id, :answer_choice_id, presence: true
  validate :respondent_can_only_answer_once, :author_cant_respond_to_own_poll

  belongs_to :respondent,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id

  belongs_to :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_choice_id,
    primary_key: :id

  has_one :question,
    through: :answer_choice,
    source: :question

  def sibling_responses
    question.responses.where.not(id: self.id)
  end

  def respondent_already_answered?
    sibling_responses.exists?(user_id: respondent.id)
  end

  private

  def respondent_can_only_answer_once
    if respondent_already_answered?
      errors[:base] << "Can't answer more than once"
    end
  end

  def author_cant_respond_to_own_poll
    if respondent.id == question.poll.author.id
      errors[:base] << "User can't rig his own poll!"
    end
  end
end
