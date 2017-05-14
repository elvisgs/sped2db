Sequel.migration do
  change do
    create_table :reg_c101 do
      column :id, Integer, primary_key: true
      column :id_pai, Integer, index: true, null: false
      column :vl_fcp_uf_dest, BigDecimal, size: [18, 2]
      column :vl_icms_uf_dest, BigDecimal, size: [18, 2]
      column :vl_icms_uf_rem, BigDecimal, size: [18, 2]
      column :cnpj_pai, String, size: 14, index: true
    end
  end
end
