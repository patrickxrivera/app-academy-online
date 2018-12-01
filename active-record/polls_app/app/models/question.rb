class Question < ApplicationRecord
  validates :text, presence: true

  has_many :answer_choices,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: 'AnswerChoice'

  belongs_to :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: 'Poll'

  has_many :responses,
    through: :answer_choices,
    source: :responses

  def results_n_plus_one
    answer_choices = self.answer_choices

    map = Hash.new(0)

    answer_choices.each { |ac| map[ac.text] += ac.responses.count }
    
    map
  end

  def results_includes
    answer_choices = self.answer_choices.includes(:responses)

    response_counts = Hash.new(0)

    answer_choices.each { |ac| response_counts[ac.text] += ac.responses.length }

    response_counts
  end

  def results
    answer_choices_with_response_counts = self.answer_choices
      .select('answer_choices.text, COUNT(responses.id) AS response_count')
      .left_outer_joins(:responses)
      .group('answer_choices.id')

    response_counts = Hash.new(0)

    answer_choices_with_response_counts.map { |answer_choice| response_counts[answer_choice.text] = answer_choice.response_count }

    response_counts
  end

  def results_optimized_sql
    answer_choices_with_response_counts = AnswerChoice.find_by_sql([<<-SQL, id])
      SELECT
        answer_choices.text, COUNT(responses.id) AS response_counts
      FROM
        answer_choices
        LEFT OUTER JOIN responses
          ON answer_choices.id = responses.answer_choice_id
      WHERE
        answer_choices.question_id = ?
      GROUP BY
        answer_choices.id
    SQL

    answer_choices_with_response_counts.inject({}) do |results, answer_choice|
      results[answer_choice.text] = answer_choice.response_counts
      results
    end
  end
end
