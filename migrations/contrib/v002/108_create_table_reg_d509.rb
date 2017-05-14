Sequel.migration do
  change do
    create_table :reg_d509 do
      column :id, Integer, primary_key: true
      column :id_pai, Integer, index: true, null: false
      column :num_proc, String, size: 20
      column :ind_proc, String, size: 1
      column :cnpj_pai, String, size: 14, index: true
    end
  end
end
