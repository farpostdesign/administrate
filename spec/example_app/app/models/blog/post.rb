module Blog
  class Post < ActiveRecord::Base
    has_many :comments, foreign_key: "blog_post_id"
    validates :title, :body, presence: true
  end
end
