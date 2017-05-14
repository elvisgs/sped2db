Sequel.migration do
  change do
    create_table :reg_c470 do
      column :id, Integer, primary_key: true
      column :id_pai, Integer, index: true, null: false
      column :cod_item, String, size: 60
      column :qtd, BigDecimal, size: [18, 3]
      column :qtd_canc, BigDecimal, size: [18, 3]
      column :unid, String, size: 6
      column :vl_item, BigDecimal, size: [18, 2]
      column :cst_icms, String, size: 3
      column :cfop, String, size: 4
      column :aliq_icms, BigDecimal, size: [18, 2]
      column :vl_pis, BigDecimal, size: [18, 2]
      column :vl_cofins, BigDecimal, size: [18, 2]
      column :cnpj_pai, String, size: 14, index: true
    end
  end
end
