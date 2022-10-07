set :environment, "development"
set :output, ".../log.log"

every "0 0 1 * *" do
  rake "job:mailmonth"
end
