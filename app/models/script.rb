class Script < ApplicationRecord
  validates :title, :content, presence: true, length: {minimum: 2}

  belongs_to :user

  scope :load_script_by_user, ->user {where user_id: user.id}

  enum status: [:request, :approve, :reject]
end
