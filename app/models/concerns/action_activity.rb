module ActionActivity
  extend ActiveSupport::Concern

  included do
    def create_activity user_id, target_id, action_type, content
      Activity.create user_id: user_id, target_id: target_id,
        action_type: action_type, content: content
    end
  end
end
