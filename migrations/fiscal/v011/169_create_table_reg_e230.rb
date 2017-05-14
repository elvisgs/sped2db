Sequel.migration do
  change do
    create_table :reg_e230 do
      column :id, Integer, primary_key: true
      column :id_pai, Integer, index: true, null: false
      column :num_da, String, size: 1000
      column :num_proc, String, size: 15
      column :ind_proc, String, size: 1
      column :proc, String, size: 1000
      column :txt_compl, String, size: 1000
      column :cnpj_pai, String, size: 14, index: true
    end
  end
end
