Sequel.migration do
  change do
    create_table :reg_1910 do
      column :id, Integer, primary_key: true
      column :id_pai, Integer, index: true, null: false
      column :dt_ini, Date
      column :dt_fin, Date
      column :cnpj_pai, String, size: 14, index: true
    end
  end
end
