class Activity < ApplicationRecord
  belongs_to :user

  enum action_types: [:submit_script, :update_script, :follow, :un_follow,
    :like, :un_like]
end
