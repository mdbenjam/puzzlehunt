require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  test 'check_answer' do
    user =
      User.create!(
        email: 'abc@gmail.com',
        password: 'abc123',
        password_confirmation: 'abc123',
      )
    puzzle_hunt = PuzzleHunt.create(name: 'test hunt')
    puzzle =
      Puzzle.create(
        title: 'Test',
        puzzle_hunt: puzzle_hunt,
        correct_answer: 'abc',
      )
    answer = Answer.create(text: 'ABC', puzzle: puzzle, user: user)

    assert answer.correct
  end

  class CheckStrippedAnswers < ActiveSupport::TestCase
    test 'simple case' do
      assert Answer.check_stripped_answers('abc123', 'ABC123')
    end

    test 'punctuation' do
      assert Answer.check_stripped_answers('abc-123!?', 'ABC123')
    end

    test 'spaces' do
      assert Answer.check_stripped_answers('abc 123  ', 'ABC123')
    end
  end
end
