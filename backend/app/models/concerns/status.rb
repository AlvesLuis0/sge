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
    end

    class_methods do
      def public_statuses
        statuses.except(:deleted)
      end
    end
  end
end
