Sequel.migration do
  change do
    create_table :reg_1220 do
      column :id, Integer, primary_key: true
      column :id_pai, Integer, index: true, null: false
      column :per_apu_cred, String, size: 6
      column :orig_cred, String, size: 2
      column :cod_cred, String, size: 3
      column :vl_cred, BigDecimal, size: [18, 2]
      column :cnpj_pai, String, size: 14, index: true
    end
  end
end
