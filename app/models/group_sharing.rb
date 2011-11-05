class GroupSharing < ActiveRecord::Base
  belongs_to :group
  belongs_to :card
end