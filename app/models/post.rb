class Post < ActiveRecord::Base

  validate :is_title_case 
  before_validation :make_title_case 
  belongs_to :author

  #put new code here

  def self.by_author(author_id)
    self.where(author:author_id)
  end

  def self.by_author_including(author_id)
    self.where(author:author_id).includes(:author)
  end

  def self.from_today
      self.where("created_at >= ?", Time.zone.today.beginning_of_day)
  end

  def self.old_news
    self.where("created_at >= ?", Time.zone.today.beginning_of_day)
  end



  private

  def is_title_case
    if title.split.any?{|w|w[0].upcase != w[0]}
      errors.add(:title, "Title must be in title case")
    end
  end

  def make_title_case
    self.title = self.title.titlecase
  end
end
