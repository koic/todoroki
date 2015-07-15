describe Todoroki::DRb do
  describe '#next_talker' do
    let(:talkers) { ['小栗虫太郎', '夢野久作', '塔晶夫'] }
    let(:drb_uri) { Todoroki::DRb.start(talkers, 'ja') }
    let(:designator) { DRb::DRbObject.new_with_uri(drb_uri) }

    subject { designator.next_talker }

    it { is_expected.to match Regexp.union(talkers) }
  end
end
