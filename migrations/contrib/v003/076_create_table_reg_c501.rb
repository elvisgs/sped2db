Sequel.migration do
  change do
    create_table :reg_c501 do
      column :id, Integer, primary_key: true
      column :id_pai, Integer, index: true, null: false
      column :cst_pis, String, size: 2
      column :vl_item, BigDecimal, size: [18, 2]
      column :nat_bc_cred, String, size: 2
      column :vl_bc_pis, BigDecimal, size: [18, 2]
      column :aliq_pis, BigDecimal, size: [18, 4]
      column :vl_pis, BigDecimal, size: [18, 2]
      column :cod_cta, String, size: 60
      column :cnpj_pai, String, size: 14, index: true
    end
  end
end
