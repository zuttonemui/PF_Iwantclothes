class Tag < ApplicationRecord
  has_many :cloth_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :want_clothes, through: :cloth_tags

  scope :merge_want_clothes, -> (tags){ }

  def self.search_want_clothes_for(content)
    tags = Tag.where('name LIKE ?', '%' + content + '%')
    return tags.inject(init = []) {|result, tag| result + tag.want_clothes}
  end
end
