Sequel.migration do
  change do
    create_table :reg_1050 do
      column :id, :Bignum, primary_key: true
      column :id_pai, :Bignum, index: true, null: false
      column :dt_ref, Date
      column :ind_aj_bc, String, size: 2
      column :cnpj, String, size: 14
      column :vl_aj_tot, BigDecimal, size: [18, 2]
      column :vl_aj_cst01, BigDecimal, size: [18, 2]
      column :vl_aj_cst02, BigDecimal, size: [18, 2]
      column :vl_aj_cst03, BigDecimal, size: [18, 2]
      column :vl_aj_cst04, BigDecimal, size: [18, 2]
      column :vl_aj_cst05, BigDecimal, size: [18, 2]
      column :vl_aj_cst06, BigDecimal, size: [18, 2]
      column :vl_aj_cst07, BigDecimal, size: [18, 2]
      column :vl_aj_cst08, BigDecimal, size: [18, 2]
      column :vl_aj_cst09, BigDecimal, size: [18, 2]
      column :vl_aj_cst49, BigDecimal, size: [18, 2]
      column :vl_aj_cst99, BigDecimal, size: [18, 2]
      column :ind_aprop, String, size: 2
      column :num_rec, String, size: 80
      column :info_compl, String, size: 1000
      column :cnpj_pai, String, size: 14, index: true
    end
  end
end
