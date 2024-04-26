# frozen_string_literal: true

require 'pstore' # https://github.com/ruby/pstore

# Defining a class Questionnarie
class Questionnaire
  # Name of the file where the data will be stored
  STORE_NAME = 'tendable.pstore'

  def initialize
    # initialize a PStore object with the name of the file where the data will be stored
    @store = PStore.new(STORE_NAME)
  end

  QUESTIONS = {
    'q1' => 'Can you code in Ruby?',
    'q2' => 'Can you code in JavaScript?',
    'q3' => 'Can you code in Swift?',
    'q4' => 'Can you code in Java?',
    'q5' => 'Can you code in C#?'
  }.freeze

  # TODO: FULLY IMPLEMENT
  def do_prompt
    # Ask each question and get an answer from the user's input.
    answers = {}
    QUESTIONS.each do |question_key, question|
      print "#{question} (Yes/No): "
      ans = gets.chomp.downcase

      # Validate the answer. and show promt until the user enters a valid answer.
      ans = validate_answer(question, ans)
      answers[question_key] = ans
    end

    # Store the answers in a PStore file.
    store_in_pstore(answers)
  end

  def store_in_pstore(answers)
    # Store the answers in a PStore file.
    p answers
    @store.transaction do
      @store[:responses] ||= []
      @store[:responses] << answers
    end
  end

  def validate_answer(question, ans)
    # Validate the answer. and show promt until the user enters a valid answer.
    until %w[yes no y n].include?(ans)
      puts "Invalid response. Please enter 'Yes' or 'No'."
      print "#{question} (Yes/No): "
      ans = gets.chomp.downcase
    end
    ans
  end

  def calculate_rating(answers)
    # Calculate the rating for the answers.
    num_yes = answers.count { |_, ans| %w[yes y].include?(ans) }
    (num_yes.to_f / QUESTIONS.size) * 100
  end

  def do_report
    # Calculate the rating for each run and the average rating across all runs.
    @store.transaction(true) do
      total_rating = 0
      total_responses = @store[:responses].size
      @store[:responses].each_with_index do |answers, index|
        # Calculate the rating for the answers.
        rating = calculate_rating(answers)
        total_rating += rating
        puts "Rating for run #{index + 1}: #{rating.round(2)}"
      end

      # Calculate the average rating across all runs.
      print_average_rating(total_rating, total_responses)
    end
  end

  def print_average_rating(total_rating, total_responses)
    # Calculate the average rating across all runs
    average_rating = total_rating / total_responses
    puts "Average rating: #{average_rating.round(2)}"
  end
end

# Main
# Prompt the user for answers to the questions.
# obj = Questionnaire.new
# obj.do_prompt
# Calculate the rating for each run and the average rating across all runs.
# obj.do_report
