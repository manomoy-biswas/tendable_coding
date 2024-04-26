# frozen_string_literal: true

require 'pstore'

require_relative '../../lib/questionnaire'

RSpec.describe 'Questionnaire' do
  let(:store) { PStore.new('tendable_test.pstore') }

  before do
    allow(PStore).to receive(:new).and_return(store)
    # allow(store).to receive(:transaction).and_yield
  end

  describe '#do_prompt' do
    it 'prompts user for answers and stores them' do
      # Simulate user input
      allow_any_instance_of(Kernel).to receive(:gets).and_return('yes', 'yes', 'no', 'yes', 'no')
      count = store.transaction do
        store[:responses].size
      end
      obj = Questionnaire.new
      obj.do_prompt
      expect(store.transaction {store[:responses].size }).to eq(count + 1)
    end
  end

  describe '#calculate_rating' do
    it 'calculates the rating based on answers' do
      answers = { 'q1' => 'yes', 'q2' => 'no', 'q3' => 'yes', 'q4' => 'yes', 'q5' => 'no' }
      obj = Questionnaire.new
      rating = obj.calculate_rating(answers)

      # Total questions: 5, Yes answers: 3, Rating should be (3/5) * 100 = 60
      expect(rating).to eq(60)
    end
  end

  describe '#do_report' do
    it 'prints the average rating and individual ratings' do
      responses = [
        { 'q1' => 'yes', 'q2' => 'yes', 'q3' => 'no', 'q4' => 'yes', 'q5' => 'no' },
        { 'q1' => 'yes', 'q2' => 'no', 'q3' => 'yes', 'q4' => 'n', 'q5' => 'no' }
      ]
      allow(store).to receive(:[]).with(:responses).and_return(responses)

      obj = Questionnaire.new
      expect do
        obj.do_report
      end.to output(/Rating for run 1: 60.0\nRating for run 2: 40.0\nAverage rating: 50.0/).to_stdout
    end
  end
end
