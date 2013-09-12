class Aparato < ActiveRecord::Base
  has_many :mediciones, class_name: 'Historical', inverse_of: :aparato,
    primary_key: :grd, foreign_key: :grd_id

  validates_uniqueness_of :nombre, :grd
end
