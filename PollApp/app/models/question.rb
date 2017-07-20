class Question < ActiveRecord::Base
  validates :text, :poll_id, presence: true

  has_many :answer_choices,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: :AnswerChoice

  belongs_to :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: :Poll

  has_many :responses,
    through: :answer_choices,
    source: :responses

  def bad_results
    answer_choices = self.answer_choices

    results = {}
    answer_choices.each do |ac|
      results[ac.text] = ac.responses.count
    end
    results
  end

  def better_results
    answer_choices = self
                        .answer_choices
                        .includes(:responses)

    results = {}
    answer_choices.each do |ac|
      results[ac.text] = ac.responses.length
    end
    results
  end

end
