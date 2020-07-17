# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :bigint           not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CatRentalRequest < ApplicationRecord
  # Constants 
  STATUS = %w( APPROVED DENIED PENDING )
  
  # Validations
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: STATUS }
  validate :start_date_must_be_today_or_future,
           :end_date_must_be_greater_than_start_date,
           :cat_cannot_be_rented_twice_at_the_same_time

  # Associations
  belongs_to :cat

  # Custom Validators
  def start_date_must_be_today_or_future
    if start_date < Date.today
      errors[:start_date] << 'cannot be in the past'
    end
  end

  def end_date_must_be_greater_than_start_date
    if end_date <= start_date
      errors[:end_date] << 'cannot be before the start date'
    end
  end

  def cat_cannot_be_rented_twice_at_the_same_time
    return unless persisted?

    unless overlapping_approved_requests.empty? || status == 'DENIED'
      errors[:cat] << 'cannot be rented twice at the same time'
    end
  end

  # Helper Methods
  def overlapping_requests
    requests = CatRentalRequest.where(cat_id: cat_id)
                               .where.not(id: id)
    overlapping_start = requests.where(start_date: start_date..end_date)
    overlapping_end = requests.where(end_date: start_date..end_date)
    overlapping_start.merge(overlapping_end)
  end

  def overlapping_approved_requests
    overlapping_approved = overlapping_requests.where(status: 'APPROVED')
  end
end


# Comment.where(:created_at => @selected_date.beginning_of_day..@selected_date.end_of_day)
