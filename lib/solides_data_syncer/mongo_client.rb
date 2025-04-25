# lib/solides_data_syncer/mongo_client.rb
require "mongo"
require_relative "errors"
require "logger"

module SolidesDataSyncer
  class MongoClient
    MAX_RETRIES = 3

    def self.connect(uri: ENV["MONGODB_URI"])
      logger = Logger.new($stdout)
      unless uri
        logger.error("SolidesDataSyncer URI não fornecido.")
        return nil
      end

      retries = 0

      begin
        client = Mongo::Client.new(uri, server_selection_timeout: 5)
        client.database_names # Força verificação
        client


      rescue Mongo::Auth::Unauthorized => e
        logger.error("Autenticação SolidesDataSyncer falhou.")
        nil

      rescue Mongo::Error::NoServerAvailable => e
        retries += 1
        logger.warn("⚠️ Tentativa #{retries}/#{MAX_RETRIES} falhou.")

        if retries < MAX_RETRIES
          sleep(1)
          retry
        else
          logger.error("Não foi possível conectar após #{MAX_RETRIES} tentativas.")
          nil
        end

      rescue Mongo::Error => e
        logger.error(" Erro SolidesDataSyncer.")
        nil

      rescue => e
        logger.error("Erro inesperado no SolidesDataSyncer.")
        nil
      end
    end
  end
end