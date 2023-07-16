class Tag < ApplicationRecord
  has_many :cloth_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :want_clothes, through: :cloth_tags

  scope :merge_want_clothes, -> (tags){ }

  def self.search_want_clothes_for(content, method)
    if method == 'perfect'
      tags = Tag.where(name: content)
    elsif method == 'forward'
      tags = Tag.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      tags = Tag.where('name LIKE ?', '%' + content)
    else
      tags = Tag.where('name LIKE ?', '%' + content + '%')
    end
    return tags.inject(init = []) {|result, tag| result + tag.want_clothes}
  end
end
