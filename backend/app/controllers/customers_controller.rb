# frozen_string_literal: true

class CustomersController < CrudController
  def initialize
    @model = Customer
    @parameters = [
      :note, :status,
      person: [
        :name, :person_type, :cpf, :rg, :issuing_agency, :birth_date, :marital_status, :cnpj, :state_registration, :trade_name,
        address: [:street, :number, :complement, :zip_code, :neighborhood, :city_id],
        contacts: [[:id, :contact_type, :email, :mobile_number]]
      ]
    ]
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

  def resource_params
    p = params.permit(@parameters).to_h
    p[:person_attributes] = p.delete(:person)
    p[:person_attributes][:address_attributes] = p[:person_attributes].delete(:address)
    p[:person_attributes][:contacts_attributes] = p[:person_attributes].delete(:contacts)
    p
  end
end
