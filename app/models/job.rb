class Job < ApplicationRecord
    has_one_attached :circular
    
    validates :title, :job_type, :description, :application_deadline, presence: true
    validates :job_type, inclusion: { in: ['Government', 'Private'] }
    validate :deadline_must_be_in_future
    scope :by_nearest_application_deadline, -> { order(application_deadline: :asc) }

   
    private
    def deadline_must_be_in_future
      if application_deadline.present? && application_deadline <= Date.current
        errors.add(:application_deadline, "must be in the future")
      end
    end
end
  