namespace :db do
  desc 'Drop, create and migrate the database'
  task :refresh => [:drop, :create, :migrate]
end
