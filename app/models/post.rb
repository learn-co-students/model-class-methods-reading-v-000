class Post < ActiveRecord::Base

  validate :is_title_case
  before_validation :make_title_case
  belongs_to :author

  #put new code here

  private

  def self.by_author(author_id)
    where(author: author_id)
  end

  def self.by_date(date)
    if date == "Today"
      self.from_today
    else
      self.old_news
    end
  end

  def self.old_news
      where("created_at <=?", self.get_time)
  end

  def self.from_today
      where("created_at >=?", self.get_time)
  end

  def self.get_time
    Time.zone.today.beginning_of_day
  end

  def is_title_case
    if title.split.any?{|w|w[0].upcase != w[0]}
      errors.add(:title, "Title must be in title case")
    end
  end

  def make_title_case
    self.title = self.title.titlecase
  end
end
