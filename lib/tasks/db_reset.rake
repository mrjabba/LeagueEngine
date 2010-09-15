namespace :db do
  desc 'drop, create, merge, basline dev db'
  task :reset_hard => :environment do
    puts "Creating dafault db..."
    
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
    Rake::Task["db:seed"].invoke
  end
end