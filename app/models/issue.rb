# frozen_string_literal: true

class Issue < ApplicationRecord
  belongs_to :project
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :status, presence: true
  validates :assignee_name, presence: true

  enum :status, { active: "active", on_hold: "on_hold", resolved: "resolved", closed: "closed" }
end