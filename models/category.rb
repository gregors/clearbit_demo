# frozen_string_literal: true

class Category
  def initialize(categories = [])
    @categories = categories
  end

  def recurring?
    @categories.any? { |c| c.downcase == 'subscription' }
  end

  def last
    @categories.last
  end
end
