# frozen_string_literal: true

class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { in: 2..20 }
  has_many :article_categories
  has_many :articles, through: :article_categories
end
