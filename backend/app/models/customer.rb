class Customer < ApplicationRecord
  include Status::Enum

  belongs_to :person
  accepts_nested_attributes_for :person

  validates :note, if: :note?, presence: true, length: { maximum: 1000 }
  validate :address_must_be_valid
  validate :contacts_must_be_valid

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

  private

  NUMBER_OF_EMAILS = 1
  NUMBER_OF_MOBILES = 3
  NUMBER_OF_CONTACTS = NUMBER_OF_EMAILS + NUMBER_OF_MOBILES

  def contacts_must_be_valid
    errors.add(:customer, "precisa ter #{NUMBER_OF_CONTACTS} contatos") if person.contacts.size != NUMBER_OF_CONTACTS
    errors.add(:customer, "precisa ter #{NUMBER_OF_EMAILS} emails") if person.contacts.filter(&:contact_type_email?).size != NUMBER_OF_EMAILS
    errors.add(:customer, "precisa ter #{NUMBER_OF_MOBILES} números de celular") if person.contacts.filter(&:contact_type_mobile?).size != NUMBER_OF_MOBILES
  end

  def address_must_be_valid
    errors.add(:customer, "precisa ter um endereço") if person.address.nil?
  end
end
