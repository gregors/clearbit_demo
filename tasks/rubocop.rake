# frozen_string_literal: true

begin
  require 'rubocop/rake_task'

  RuboCop::RakeTask.new
rescue LoadError # rubocop:disable Lint/HandleExceptions
end
