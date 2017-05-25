class Activity < ApplicationRecord
  belongs_to :user
  enum activity_types: [:submit_script, :update_script, :follow, :un_follow]
end
