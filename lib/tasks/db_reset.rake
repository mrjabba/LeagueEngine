namespace :db do
  desc 'drop, create, merge, basline dev db'
  task :reset_hard => :environment do
    puts "Creating dafault db..."
    
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
<<<<<<< HEAD
    Rake::Task["data:baseline"].invoke
=======
    Rake::Task["db:seed"].invoke
>>>>>>> e860c3e4429a4a9f4d4e7da5bff0f6d1d9d9b2a0
  end
end