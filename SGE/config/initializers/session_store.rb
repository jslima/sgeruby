# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_SGE_session',
  :secret      => '082502e1b4a006230482f56fc1254b0b4f0eaa850e4c34a3bef2bb393392f4a0735124885f081ce70fa34205a16193082dff72e5780a079eb6a109edc00da2fa'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
