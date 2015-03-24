desc "Project reminder email"
task :project_reminder_email => :environment do
  ExplorationUser.project_reminder_email
end