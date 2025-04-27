class Contact < ApplicationRecord
  include ContactType::Enum

  belongs_to :person

  validates :email, if: -> { contact_type_email? && email? }, presence: true, length: { maximum: 100 }
  validates :mobile_number, if: -> { contact_type_mobile? && mobile_number? }, presence: true, length: { is: 13 }, numericality: { only_integer: true }

  protected

  def clear_attributes
    attributes_to_clear = if contact_type_email?
                            [ :mobile_number ]
                          elsif contact_type_mobile?
                            [ :email ]
                          end
    super(attributes_to_clear)
  end
end
