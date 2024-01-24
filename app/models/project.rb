# frozen_string_literal: true

# Project class to handle projects
class Project < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true

  validates :title, presence: true, uniqueness: true

  def self.custom_order(order)
    records = includes(:user, :category)
    order_string = order_query_string(order)
    records.order(order_string)
  end

  def self.order_query_string(order)
    case order
    when 'recent_projects', nil
      'created_at desc'
    when 'category_name'
      'categories.name asc'
    when 'username'
      'users.username asc'
    when 'title'
      'projects.title asc'
    end
  end
end
