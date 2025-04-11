# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed_objects command (or created alongside the database with db:setup).

def load_json!(file_name)
  JSON.load_file!(Rails.root.join('db', 'seed_objects', file_name))
end

def get_objects_not_registered(model, objects)
  ids_to_check = objects.map { |object| object['id'] }
  registered_ids = model.where('id = ANY(ARRAY[?]::bigint[])', ids_to_check).pluck(:id)
  objects.reject { |object| registered_ids.include?(object['id']) }
end

def seed_objects!(model)
  objects = load_json!(model.table_name + '.json')
  objects = get_objects_not_registered(model, objects)
  model.insert_all!(objects)
end

seed_objects!(State)
seed_objects!(City)
