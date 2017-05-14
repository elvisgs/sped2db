Sequel.migration do
  change do
    create_table :reg_f010 do
      column :id, Integer, primary_key: true
      column :id_pai, Integer, index: true, null: false
      column :cnpj, String, size: 14
      column :cnpj_pai, String, size: 14, index: true
    end
  end
end
