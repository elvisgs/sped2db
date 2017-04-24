require 'spec_helper'

module Sped2DB
  describe Utils do
    include Utils

    it 'deve detectar layout fiscal' do
      file = 'spec/files/fiscal/sped_fiscal.txt'

      layout = get_layout file

      expect(layout.type).to be :fiscal
      expect(layout.version).to eq '010'
    end

    it 'deve detectar layout contrib' do
      file = 'spec/files/contrib/sped_contrib.txt'

      layout = get_layout file

      expect(layout.type).to be :contrib
      expect(layout.version).to eq '003'
    end
  end
end
