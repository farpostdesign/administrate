class CreateBlogComments < ActiveRecord::Migration[5.1]
  def change
    create_table :blog_comments do |t|
      t.references :blog_post, foreign_key: true
      t.references :customer, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
