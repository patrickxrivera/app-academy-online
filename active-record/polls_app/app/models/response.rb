class Response < ApplicationRecord
  validate :not_duplicate_response

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: 'AnswerChoice'

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :respondent_id,
    class_name: 'User'

  has_one :question,
   through: :answer_choice,
   source: :question

  def sibling_responses
    self.question.responses.where.not(id: self.id)
  end

  def respondent_already_answered?
    sibling_responses.exists?(respondent_id: self.respondent_id)
  end

  def respondent_is_author?
    answer_choice_id = self.answer_choice_id
    question_id = AnswerChoice.find(answer_choice_id).question_id
    poll_id = Question.find(question_id).poll_id
    
    Poll.find(poll_id).author_id == self.respondent_id
  end

  private

  def not_duplicate_response
    errors[:respondent_id] << "Can't respond twice to a question." if respondent_already_answered?
  end
end
