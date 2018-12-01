class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true

  has_many :authored_polls,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: 'Poll'

  has_many :responses,
    primary_key: :id,
    foreign_key: :respondent_id,
    class_name: 'Response'

  def completed_polls
    polls = Poll.find_by_sql([<<-SQL, id])
      SELECT polls.id, polls.title
      FROM polls
        INNER JOIN questions
          ON questions.poll_id = polls.id
        INNER JOIN answer_choices
          ON answer_choices.question_id = questions.id
        INNER JOIN responses
          ON responses.answer_choice_id = answer_choices.id
      WHERE
        responses.respondent_id = ?
    SQL

    polls
  end
end
