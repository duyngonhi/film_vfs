class Script < ApplicationRecord
  validates :title, :content, presence: true, length: {minimum: 2}

  belongs_to :user

  scope :load_script_by_user, -> current_user {where user_id: current_user.id}

  enum status: [:request, :approve, :reject]
end
