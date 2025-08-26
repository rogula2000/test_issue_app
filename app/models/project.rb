# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :creator, class_name: "User", optional: true
  has_many :issues, dependent: :destroy

  validates :name, presence: true
end