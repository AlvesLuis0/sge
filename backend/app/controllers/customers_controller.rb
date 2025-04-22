# frozen_string_literal: true

class CustomersController < CrudController
  def initialize
    @model = Customer
    @parameters = { customer: [
      :note, :status,
      person_attributes: [
        :name, :person_type, :cpf, :rg, :issuing_agency, :birth_date, :marital_status, :cnpj, :state_registration, :trade_name,
        address_attributes: [:id, :street, :number, :complement, :zipcode, :neighborhood, :city],
        contacts_attributes: [[:id, :contact_type, :email, :mobile_number]]
      ]
    ] }
  end

  def show
    render json: @resource, include: { person: { include: [:address, :contacts] } }
  end

  protected

  def set_resource
    if action_name == "show"
      @resource = Customer
                    .not_status_deleted
                    .includes(person: [:address, :contacts])
                    .find(params.expect(:id))
    else
      super
    end
  end
end
