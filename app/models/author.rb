class Author < ActiveRecord::Base
  has_many :posts

  def self.by_author(author_id)
    where(author: author_id)
  end

  def self.from_today
    where("created_at >=?", Time.zone.today.beginning_of_day)
  end

  def self.old_news
    where("created_at <?", Time.zone.today.beginning_of_day)
  end 
end
