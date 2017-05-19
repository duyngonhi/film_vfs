class Like < ApplicationRecord
  include ActionActivity
  belongs_to :like_user, class_name: User.name
  belongs_to :like_film, class_name: Film.name

  after_create :create_like_activity
  after_destroy :create_unlike_activity

  private

  def create_like_activity
    create_activity like_user_id,
      like_film_id,
      Activity.action_types[:like],
      I18n.t("like.like")
  end

  def create_unlike_activity
    create_activity like_user_id,
      like_film_id,
      Activity.action_types[:un_like],
      I18n.t("like.un_like")
  end
end
