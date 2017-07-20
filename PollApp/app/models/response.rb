class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, presence: true
  validate :not_duplicate_response, :not_creator_response

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: :AnswerChoice

  has_one :question,
    through: :answer_choice,
    source: :question

  def not_creator_response
    if self.answer_choice.question.poll.author_id == self.user_id
      errors[:user_id] << "Cannot respond to question because has created it."
    end
  end


  def sibling_responses
    self.question.responses.where.not('responses.answer_choice_id = ? ', self.answer_choice_id)
  end

  def respondent_already_answered?
    self.sibling_responses.exists?(["user_id = ?", self.user_id])
  end

  def not_duplicate_response
    if respondent_already_answered?
      errors[:user_id] << "has already responded to this question."
    end
  end




end
