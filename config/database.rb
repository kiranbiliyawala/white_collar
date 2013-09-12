DB_DEFAULTS = {
  :adapter   => 'mysql2',
  :encoding  => 'utf8',
  :reconnect => true,
  :database  => 'smart_delivery',
  :pool      => 25,
  :username  => 'root',
  :password  => '',
  :host      => 'localhost'
}

ActiveRecord::Base.configurations[:development] = DB_DEFAULTS.merge(:host => "localhost")
ActiveRecord::Base.configurations[:test] = DB_DEFAULTS.merge(:host => "localhost")
ActiveRecord::Base.configurations[:qa] = DB_DEFAULTS.merge(:pool => ENV['DB_CONNECTION_POOL_SIZE'] || 50)
ActiveRecord::Base.configurations[:staging] = DB_DEFAULTS.merge(:pool => 50)
ActiveRecord::Base.configurations[:production] = DB_DEFAULTS.merge(:pool => 100)
ActiveRecord::Base.configurations[:ci_proc] = DB_DEFAULTS.merge(:host => "localhost", :pool => 20)
ActiveRecord::Base.configurations[:e2e] = DB_DEFAULTS.merge(:pool => 50)

#slave_configs = {:host => SupplyChain.slave_db_host, :username => SupplyChain.slave_db_user, :password => SupplyChain.slave_db_password, :database => (ENV['SLAVE_DB_NAME'] || SupplyChain.slave_db_name)}
#SLAVE_DB_CONFIG = DB_DEFAULTS.merge(slave_configs)

# Setup our logger
ActiveRecord::Base.logger = logger

# Include Active Record class name as root for JSON serialized output.
ActiveRecord::Base.include_root_in_json = false

# Store the full class name (including module namespace) in STI type column.
ActiveRecord::Base.store_full_sti_class = true

# Use ISO 8601 format for JSON serialized times and dates.
ActiveSupport.use_standard_json_time_format = true

# Don't escape HTML entities in JSON, leave that for the #json_escape helper.
# if you're including raw json in an HTML page.
ActiveSupport.escape_html_entities_in_json = false

# Now we can establish connection with our db
ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[Padrino.env])

