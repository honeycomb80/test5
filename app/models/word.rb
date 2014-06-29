class Word < ActiveRecord::Base
  has_many :counts
  has_many :articles, through: :counts
end