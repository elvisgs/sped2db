Sequel.migration do
  change do
    create_table :reg_1210 do
      column :id, Integer, primary_key: true
      column :id_pai, Integer, index: true, null: false
      column :cnpj, String, size: 14
      column :cst_pis, String, size: 2
      column :cod_part, String, size: 60
      column :dt_oper, Date
      column :vl_oper, BigDecimal, size: [18, 2]
      column :vl_bc_pis, BigDecimal, size: [18, 3]
      column :aliq_pis, BigDecimal, size: [18, 4]
      column :vl_pis, BigDecimal, size: [18, 2]
      column :cod_cta, String, size: 60
      column :desc_compl, String, size: 1000
      column :cnpj_pai, String, size: 14, index: true
    end
  end
end
