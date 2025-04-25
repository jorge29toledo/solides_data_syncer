# frozen_string_literal: true

require_relative "mongo_client"
require_relative "errors"
require "logger"

module SolidesDataSyncer
  class Syncer
    attr_reader :connected

    def initialize(source: nil, destination: nil, db_name: nil, collection_name: nil)
      @source = source
      @destination = destination
      @connected = false
      @logger = defined?(Rails) ? Rails.logger : Logger.new($stdout)

      begin
        @mongo = MongoClient.connect
        if @mongo
          @db = @mongo.use(db_name).database
          @collection = @db.collection(collection_name)
          @connected = true
        else
          @logger.error("Erro conexão SolidesDataSyncer")
        end
      rescue MongoConnectionError => e
        @logger.error("Erro de conexão SolidesDataSyncer.")
      rescue => e
        @logger.error("Erro inesperado na inicialização do Syncer")
      end
    end

    def connected?
      @connected
    end

    def find_users(limit: nil)
      return unless connected?

      begin
        users = @collection.find.sort(_id: -1).limit(limit).to_a
        users.each { |doc| puts doc }
        users
      rescue => e
        @logger.error("Erro ao buscar usuários: #{e.message}")
        []
      end
    end

    def add_or_update_user(name:, email:, password:)
      return unless connected?

      now = Time.now.utc

      begin
        result = @collection.update_one(
          { email: email },
          {
            "$set" => {
              name: name,
              password: password,
              updated_at: now
            },
            "$setOnInsert" => {
              created_at: now
            }
          },
          upsert: true
        )
        result
      rescue => e
        @logger.error("Erro ao adicionar/atualizar em SolidesDataSyncer")
        nil
      end
    end
  end
end
