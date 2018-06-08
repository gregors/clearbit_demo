# frozen_string_literal: true

require_relative './category'
require_relative '../services/name_cleanser'
require 'date'

class Transaction
  attr_reader :amount, :categories, :cleaned_name, :date, :name
  attr_accessor :domain, :logo

  def self.from_plaid_transactions(transactions)
    transactions.map { |r| Transaction.new(r.name, r.date, r.amount, r.category) }
                .sort_by(&:date)
  end

  def initialize(name, date, amount, categories)
    @name = name
    @cleaned_name = NameCleanser.clean(name)
    @date = Date.parse(date)
    @amount = amount
    @categories = Category.new(categories)
  end

  def recurring?
    @categories.recurring?
  end

  def interest?
    @name == 'INTRST PYMNT'
  end
end
