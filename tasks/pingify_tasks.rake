namespace :pingify do

  desc "install gems"
  task :install do
    system "sudo gem install net-ping"
  end

end

