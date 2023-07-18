class Tag < ApplicationRecord
  has_many :cloth_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :want_items, through: :cloth_tags

  scope :merge_want_items, -> (tags){ }

  def self.search_want_items_for(content)
    tags = Tag.where('name LIKE ?', '%' + content + '%')
    return tags.inject(init = []) {|result, tag| result + tag.want_items}
  end
end
