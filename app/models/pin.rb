class Pin < ActiveRecord::Base
  validates_presence_of :title, :url, :slug, :text, :category_id
  validates_uniqueness_of :slug


  belongs_to :category

  belongs_to :user

  has_attached_file :image, styles: { medium: "300x300", thumb: "60x60" }, default_url: "http://placebear.com"

  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end
