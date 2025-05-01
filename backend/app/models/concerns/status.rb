module Status
  module Enum
    extend ActiveSupport::Concern

    included do
      enum :status,
        {
          active: "active",
          inactive: "inactive",
          deleted: "deleted"
        },
        prefix: true,
        validate: true,
        default: :active

      default_scope -> { where.not(status: :deleted) }

      def destroy!
        update!(status: :deleted)
      end
    end
  end
end
