# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :issue
  belongs_to :creator, class_name: "User", optional: true

  validates :content, presence: true
end