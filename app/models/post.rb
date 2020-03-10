class Post < ActiveRecord::Base

  validate :is_title_case 
  before_validation :make_title_case 
  belongs_to :author

  #put new code here

  def self.by_author(author_id)
    Post.all.select { |post| post.author.id == author_id }
  end

  def self.from_today
    Post.all.select { |post| post.created_at.to_s >= Time.zone.today.beginning_of_day }
    # where("created_at >=?", Time.zone.today.beginning_of_day)
  end

  def self.old_news
    Post.all.select { |post| post.created_at.to_s < Time.zone.today.beginning_of_day }
    # where("created_at <?", Time.zone.today.beginning_of_day)
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
