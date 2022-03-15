class Puzzle < ApplicationRecord
    has_one_attached :content
    has_many :answers
end
