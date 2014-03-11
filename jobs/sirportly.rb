require 'sirportly'
require 'pry'
begin
  sirportly_config = YAML.load_file("config/sirportly.yml")
  departments = sirportly_config['departments']
  
  departments.each do |name, department|
    SCHEDULER.every '100', :first_in => 0 do |job|
      Sirportly.domain = department['domain']
      sirportly = Sirportly::Client.new(department['api_token'], department['api_secret'])
      ticket_count = sirportly.spql("SELECT COUNT FROM tickets WHERE teams.name = '#{department['team']}' AND ((status.name = #{department['statuses'].join(' OR status.name = ')}))").results.flatten.first
      status = "ok"
      status = "warning" if ticket_count.to_i > department['warning_threshold']
      status = "danger" if ticket_count.to_i > department['danger_threshold']
 
      send_event("sirportly_#{name}", { current: ticket_count, status: status })
    end
  end
rescue Errno::ENOENT
  puts "No config file found for sirportly - not starting the Sirportly job"
end