# frozen_string_literal: true

require 'clearbit'

class ClearbitData
  Clearbit.key = ENV['CLEARBIT_KEY']

  def self.name_domain_find_all(names)
    results = {}
    names.each do |n|
      results[n] = Clearbit::NameDomain.find(name: n)
    end
    results
  end

  def self.unique_names(transactions)
    transactions.map(&:cleaned_name).uniq
  end

  def self.enrich(transactions)
    unique_names = unique_names(transactions)
    name_domains = name_domain_find_all(unique_names)

    transactions.each do |t|
      clearbit_data = name_domains[t.cleaned_name]
      if clearbit_data
        t.domain = clearbit_data['domain']
        t.logo = clearbit_data['logo']
      end
    end
    transactions
  end
end
