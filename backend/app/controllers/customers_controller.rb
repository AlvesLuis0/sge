# frozen_string_literal: true

class CustomersController < ApplicationController
  include Crud::Extension

  def initialize
    @model = Customer
    @parameters = { customer: [
      :note, :status,
      person_attributes: [
        :name, :person_type, :cpf, :rg, :issuing_agency, :birth_date, :marital_status, :cnpj, :state_registration, :trade_name,
        address_attributes: [ :street, :number, :complement, :zipcode, :neighborhood, :city],
        contacts_attributes: [[ :contact_type, :email, :mobile_number ]]
      ]
    ] }
  end
end
