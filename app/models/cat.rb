# == Schema Information
#
# Table name: cats
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  birth_date  :date             not null
#  color       :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Cat < ApplicationRecord
  # Constants
  COLORS = %w( Black White Grey Tabby Orange Tuxedo Calico )
  SEXES = %w( M F )

  # Validations
  validates :name, :birth_date, :color, :sex, :description, presence: true
  validates :color, inclusion: { in: COLORS }
  validates :sex, inclusion: { in: SEXES }
  validate :birth_date_cant_be_in_future, :must_be_at_least_one_year_old

  # Associations
  has_many :cat_rental_requests,
           dependent: :destroy

  # Public Helper Methods
  def age
    now = Date.today
    now.year - birth_date.year - ((now.month > birth_date.month || (now.month == birth_date.month && now.day >= birth_date.day)) ? 0 : 1)
  end

  # Custom Validators
  def birth_date_cant_be_in_future
    unless birth_date.present? && birth_date <  Date.today
      errors[:birth_date] << 'cannot be in the future'
    end
  end
  
  def must_be_at_least_one_year_old
    unless age >= 1
      errors[:cat] << 'must be at least one year old'
    end
  end
  
end
