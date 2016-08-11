module SchemaValidations
  module ActiveRecord
    module Base
      module ClassMethods

          def columns
            SchemaMonkey::Middleware::Model::Columns.start(model: self, columns: []) { |env|
              env.columns += super
            }.columns
          end

          def reset_column_information
            SchemaMonkey::Middleware::Model::ResetColumnInformation.start(model: self) do |env|
              super
            end
          end

        public

        # Returns a list of IndexDefinition objects, for each index
        # defind on this model's table.
        #
        def indexes
          @indexes ||= connection.indexes(table_name, "#{name} Indexes")
        end

        # (reset_index_information gets called by by Middleware::Model::ResetColumnInformation)
        def reset_index_information
          @indexes = nil
        end

      end
    end
  end
end
