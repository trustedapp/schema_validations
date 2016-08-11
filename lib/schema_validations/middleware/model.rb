module SchemaValidations
  module Middleware
    module Model

      module Columns
        ENV = [:model, :columns]

        def after(env)
          env.columns.each do |column|
            column.model = env.model
          end
        end
      end

      module ResetColumnInformation
        ENV = [:model]

        def after(env)
          env.model.reset_index_information
        end
      end

    end
  end
end
