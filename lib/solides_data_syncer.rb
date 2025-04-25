# frozen_string_literal: true

require_relative "solides_data_syncer/version"
require_relative "solides_data_syncer/syncer"
require_relative "solides_data_syncer/errors"
require_relative "solides_data_syncer/mongo_client"

if defined?(Rails)
  require_relative "solides_data_syncer/rails_helper"
end