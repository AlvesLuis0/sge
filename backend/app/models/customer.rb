class Customer < ApplicationRecord
  include Status::Enum

  belongs_to :person
  accepts_nested_attributes_for :person

  validates :note, if: :note?, presence: true, length: { maximum: 1000 }

  after_initialize -> {
    address = Address.new
    contacts = [
      Contact.new(contact_type: :email),
      Contact.new(contact_type: :mobile),
      Contact.new(contact_type: :mobile),
      Contact.new(contact_type: :mobile)
    ]
    self.person ||= Person.new(address: address, contacts: contacts)
    self.person.address ||= address
    self.person.contacts = contacts if self.person.contacts.empty?
  }
end
