Sequel.migration do
  change do
    create_table :reg_1700 do
      column :id, Integer, primary_key: true
      column :id_pai, Integer, index: true, null: false
      column :cod_disp, String, size: 2
      column :cod_mod, String, size: 2
      column :ser, String, size: 4
      column :sub, String, size: 3
      column :num_doc_ini, String, size: 12
      column :num_doc_fin, String, size: 12
      column :num_aut, String, size: 60
      column :cnpj_pai, String, size: 14, index: true
    end
  end
end
