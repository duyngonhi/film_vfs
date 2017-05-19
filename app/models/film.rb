class Film < ApplicationRecord
  validates :name_film, :picture_film, :link_trailer,  presence: true, length:
    {minimum: 2, maximum: 200}
  validates :rating_film, numericality: {only_integer: true}
  validates :count_like, numericality: {only_integer: true}

  belongs_to :category

  has_many :passive_likes, class_name: Like.name,
    foreign_key: :like_film_id, dependent: :destroy
  has_many :liked, through: :passive_likes, source: :like_user

  ARRAY_RATE = [[I18n.t("manage_films.rate_none"), nil],
    [I18n.t("manage_films.rate_1"), I18n.t("manage_films.rate_1")],
    [I18n.t("manage_films.rate_2"), I18n.t("manage_films.rate_2")],
    [I18n.t("manage_films.rate_3"), I18n.t("manage_films.rate_3")],
    [I18n.t("manage_films.rate_4"), I18n.t("manage_films.rate_4")],
    [I18n.t("manage_films.rate_5"), I18n.t("manage_films.rate_5")]]

  class << self
    def to_csv
      CSV.generate do |csv|
        csv << column_names
        all.find_each do |film|
          csv << film.attributes.values_at(*column_names)
        end
      end
    end
  end

  def calculate_rating_film count_like
    rate = count_like/2
    if rate >= 5
      5
    else
      rate
    end
  end
end
