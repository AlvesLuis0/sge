class Person < ApplicationRecord
  include PersonType::Enum
  include MaritalStatus::Enum

  has_one :address
  has_many :contacts
  accepts_nested_attributes_for :address, :contacts, update_only: true

  validates :name, presence: true, length: { maximum: 100 }
  validates :cpf, if: -> { person_type_individual? && cpf? }, presence: true, numericality: { only_integer: true }, uniqueness: true, length: { is: 11 }
  validates :rg, if: -> { person_type_individual? && rg? }, presence: true, numericality: { only_integer: true }, uniqueness: true, length: { maximum: 15 }
  validates :issuing_agency, if: -> { person_type_individual? && issuing_agency? }, presence: true, length: { maximum: 20 }
  validates :birth_date, if: -> { person_type_individual? && birth_date? }, presence: true, comparison: { less_than_or_equal_to: -> { Date.today } }

  validates :cnpj, if: -> { person_type_company? && cnpj? }, presence: true, numericality: { only_integer: true }, length: { is: 14 }, uniqueness: true
  validates :state_registration, if: -> { person_type_company? && state_registration? }, presence: true, length: { maximum: 20 }
  validates :trade_name, if: -> { person_type_company? && trade_name? }, presence: true, length: { maximum: 40 }

  protected

  def clear_attributes
    attributes_to_clear = if person_type_individual?
                            [ :cnpj, :state_registration, :trade_name ]
    elsif person_type_company?
                            [ :cpf, :rg, :issuing_agency, :birth_date, :marital_status ]
    end
    super(attributes_to_clear)
  end
end
