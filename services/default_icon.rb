# frozen_string_literal: true

class DefaultIcon
  @@icons = {
    'credit card' => '<i class="far fa-credit-card"></i>',
    'deposit' => '<i class="fas fa-dollar-sign"></i>',
    'coffee shop' => '<i class="fas fa-coffee"></i>',
    'restaurants' => '<i class="fas fa-utensils"></i>',
    'bicycles' => '<i class="fas fa-bicycle"></i>',
    'gyms and fitness centers' => '<i class="fas fa-dumbbell"></i>'
  }

  def self.get(categories)
    @@icons[categories.last&.downcase]
  end
end
