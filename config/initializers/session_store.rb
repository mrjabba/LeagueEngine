# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_leaguest_session',
  :secret      => 'aff2fe1116a03d44eb4eb06dff892c887c776eaed6982b3785bf36821818d00e73b59863720b1be7dcc0f315897cc6d30bbfe5b6ea3e8b93e7cadd4fd8147bdb'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
