class Count < ActiveRecord::Base
  belongs_to :article
  belongs_to :word
end
