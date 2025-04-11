class CreatePersonTypes < ActiveRecord::Migration[8.0]
  def change
    create_enum :person_types, [ 'individual', 'company' ]
  end
end
