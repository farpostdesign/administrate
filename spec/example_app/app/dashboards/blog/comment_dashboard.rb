require "administrate/base_dashboard"

module Blog
  class CommentDashboard < Administrate::BaseDashboard
    ATTRIBUTE_TYPES = {
      id: Field::Number,
      created_at: Field::DateTime,
      updated_at: Field::DateTime,
      blog_post: Field::BelongsTo.with_options(class_name: 'Blog::Post'),
      customer: Field::BelongsTo,
      body: Field::Text,
    }

    READ_ONLY_ATTRIBUTES = [
      :id,
      :created_at,
      :updated_at,
    ]

    COLLECTION_ATTRIBUTES = [
      :id,
      :customer,
      :blog_post,
    ]

    FORM_ATTRIBUTES = ATTRIBUTE_TYPES.keys - READ_ONLY_ATTRIBUTES
    SHOW_PAGE_ATTRIBUTES = ATTRIBUTE_TYPES.keys
  end
end
