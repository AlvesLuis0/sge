class Customer < ApplicationRecord
  include Status::Enum

  belongs_to :person
  accepts_nested_attributes_for :person

  validates :note, if: :note?, presence: true, length: { maximum: 1000 }

  after_initialize -> {
    self.person ||= Person.new(
      address: Address.new,
      contacts: [
        Contact.new(contact_type: :email),
        Contact.new(contact_type: :mobile),
        Contact.new(contact_type: :mobile),
        Contact.new(contact_type: :mobile)
      ]
    )
  }
end
