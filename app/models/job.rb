class Job < ApplicationRecord
    has_one_attached :circular
    
    validates :title, :job_type, :description, :application_deadline, presence: true
    validates :job_type, inclusion: { in: ['Government', 'Private'] }
  end
  