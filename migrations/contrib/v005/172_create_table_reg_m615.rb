Sequel.migration do
  change do
    create_table :reg_m615 do
      column :id, :Bignum, primary_key: true
      column :id_pai, :Bignum, index: true, null: false
      column :ind_aj_bc, String, size: 1
      column :vl_aj_bc, BigDecimal, size: [18, 2]
      column :cod_aj_bc, String, size: 2
      column :num_doc, String, size: 1000
      column :descr_aj_bc, String, size: 1000
      column :dt_ref, Date
      column :cod_cta, String, size: 255
      column :cnpj, String, size: 14
      column :info_compl, String, size: 1000
      column :cnpj_pai, String, size: 14, index: true
    end
  end
end
