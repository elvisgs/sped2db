Sequel.migration do
  change do
    create_table :reg_c381 do
      column :id, Integer, primary_key: true
      column :id_pai, Integer, index: true, null: false
      column :cst_pis, String, size: 2
      column :cod_item, String, size: 60
      column :vl_item, BigDecimal, size: [18, 2]
      column :vl_bc_pis, BigDecimal, size: [18, 2]
      column :aliq_pis, BigDecimal, size: [18, 4]
      column :quant_bc_pis, BigDecimal, size: [18, 3]
      column :aliq_pis_quant, BigDecimal, size: [18, 4]
      column :vl_pis, BigDecimal, size: [18, 2]
      column :cod_cta, String, size: 60
      column :cnpj_pai, String, size: 14, index: true
    end
  end
end
