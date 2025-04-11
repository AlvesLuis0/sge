class Person < ApplicationRecord
  include PersonType::Enum
  include MaritalStatus::Enum

  validates :name, presence: true, length: { maximum: 100 }
  with_options if: :person_type_individual? do |individual|
    individual.validates :cpf, if: cpf?, presence: true, uniqueness: true, length: { is: 11 }
    individual.validates :rg, if: rg?, presence: true, uniqueness: true, length: { maximum: 15 }
    individual.validates :issuing_agency, if: :issuing_agency?, presence: true, length: { maximum: 20 }
    individual.validates :birth_date, if: :birth_date?, presence: true, comparison: { less_than_or_equal_to: -> { Date.today } }
  end
  with_options if: :person_type_company? do |company|
    company.validates :cnpj, if: :cnpj?, presence: true, numericality: { only_integer: true }, length: { is: 14 }, uniqueness: true
    company.validates :state_registration, if: :state_registration?, presence: true, length: { maximum: 20 }
    company.validates :trade_name, if: :trade_name?, presence: true, length: { maximum: 40 }
  end

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
