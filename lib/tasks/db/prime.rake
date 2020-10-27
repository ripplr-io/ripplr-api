if Rails.env.development?
  require 'sample_data'

  namespace :db do
    desc 'Setup and populate the database with sample data'
    task prime: ['db:prepare', 'db:sample']

    desc 'Populate the database with sample data'
    task sample: :environment do
      SampleData.new.generate_all
    end
  end
end
