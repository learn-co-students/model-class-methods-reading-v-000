class Post < ActiveRecord::Base

  validate :is_title_case 
  before_validation :make_title_case 
  belongs_to :author

  #put new code here


  def self.by_author(asdf)
    where(author_id: asdf)
  end

  def self.from_today
    where("created_at >=?", Time.zone.today.beginning_of_day) 
  end
  
  def self.old_news
    where("created_at <?", Time.zone.today.beginning_of_day)
  end


  # def self.by_date(date)
  #   where(created_at: date)
  # end


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
