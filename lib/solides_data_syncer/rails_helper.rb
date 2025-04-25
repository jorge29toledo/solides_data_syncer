module SolidesDataSyncer
  class RailsHelper
    def self.syncer
      @syncer ||= Syncer.new(
        db_name: ENV.fetch("MONGO_DB_NAME"),
        collection_name: ENV.fetch("MONGO_COLLECTION_NAME")
      )
    end
  end
end
