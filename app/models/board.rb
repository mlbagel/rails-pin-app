class Board < ActiveRecord::Base
  validates_presence_of :name

  belongs_to :user
  has_many :pinnings
  has_many :pins, through: :pinnings
  has_many :board_pinners
  accepts_nested_attributes_for :board_pinners


end
