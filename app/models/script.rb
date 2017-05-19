class Script < ApplicationRecord
  include ActionActivity
  after_create :create_script_activity
  validates :title, :content, presence: true, length: {minimum: 2}

  belongs_to :user

  scope :load_script_by_user, ->user {where user_id: user.id}

  enum status: [:request, :approve, :reject]

  private

  def create_script_activity
    create_activity user_id, id, Activity.action_types[:submit_script],
      I18n.t("activity.submit_script")
  end
end
