class Relationship < ApplicationRecord
  include ActionActivity
  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name
  validates :follower_id, presence: true
  validates :followed_id, presence: true
  after_create :create_follow_activity
  after_destroy :create_unfollow_activity

  private

  def create_follow_activity
    create_activity follower_id,
      followed_id,
      Activity.action_types[:follow],
      I18n.t("activity.follow")
  end

  def create_unfollow_activity
    create_activity follower_id,
      followed_id,
      Activity.action_types[:un_follow],
      I18n.t("activity.un_follow")
  end
end
