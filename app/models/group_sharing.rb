class GroupSharing < ActiveRecord::Base
  belongs_to :group
  belongs_to :card

  validate do
    unless card.user == group.user
      errors.add :group, "can't be added to other people's cards"
    end
  end
end