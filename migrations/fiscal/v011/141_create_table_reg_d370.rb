Sequel.migration do
  change do
    create_table :reg_d370 do
      column :id, Integer, primary_key: true
      column :id_pai, Integer, index: true, null: false
      column :cod_mun_orig, String, size: 7
      column :vl_serv, BigDecimal, size: [18, 2]
      column :qtd_bilh, Integer
      column :vl_bc_icms, BigDecimal, size: [18, 2]
      column :vl_icms, BigDecimal, size: [18, 2]
      column :cnpj_pai, String, size: 14, index: true
    end
  end
end
